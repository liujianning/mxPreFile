//
//  IAPManager.m
//  Movie
//
//  Created by wmz on 2023/3/14.
//

#import "IAPManager.h"
#import <Foundation/Foundation.h>
#import "NSObject+Toast.h"

@interface IAPManager()<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, copy) NSString *currentPurchasedID;
@property (nonatomic, copy, nullable) BLOCK_iapCompletionBlock iAPCompletionHandle;
@property (nonatomic, copy, nullable) BLOCK_restoreCompletionBlock restoreBlock;
@property (nonatomic, strong) NSMutableArray *restoredArrauy;

@end

@implementation IAPManager
 
+ (instancetype)sharedInstance{
    static IAPManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[IAPManager alloc] init];
    });
    return instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)ht_querryPurchaseWithArray:(NSArray *)products andBlock:(nonnull BLOCK_productsCompletionBlock)handle {
    
    _productsBlock = handle;
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:products]];
    request.delegate = self;
    [request start];
}

- (void)ht_querryPurchaseWithID:(NSString *)purchID andBlock:(BLOCK_productCompletionBlock)handle{
    if (purchID) {
        _productBlock = handle;
        self.currentPurchasedID = purchID;
        NSSet *nsset = [NSSet setWithArray:@[purchID]];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
        request.delegate = self;
        [request start];
    }
}
 
- (void)ht_startPurchaseWithID:(NSString *)purchID andCompleteHandle:(BLOCK_iapCompletionBlock)handle{
    self.iAPCompletionHandle = handle;
    if (purchID) {
        if ([SKPaymentQueue canMakePayments]) {
            self.payBlock = YES;
            self.currentPurchasedID = purchID;
            //从App Store中检索关于指定产品列表的本地化信息
            NSSet *nsset = [NSSet setWithArray:@[purchID]];
            SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
            request.delegate = self;
            [request start];
        } else {
            [self ht_handleActionWithType:ENUM_IAPPurchNotArrow data:nil];
        }
    }
}

- (void)ht_handleActionWithType:(ENUM_IAPPurchType)type data:(NSData *)data{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.iAPCompletionHandle) {
            self.iAPCompletionHandle(type,data);
        }
    });
}
 
- (void)verifyPurchaseWithPaymentTransaction:(SKPaymentTransaction *)transaction {
    // 交易验证
    [self lgjeropj_verifyReceiptURL:NO];
    // 验证成功与否都注销交易,否则会出现虚假凭证信息一直验证不通过,每次进程序都得输入苹果账号
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)lgjeropj_verifyReceiptURL:(BOOL)isSandBox
{
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:recepitURL];
     
    if (!receipt) {
        // 交易凭证为空验证失败
        [self ht_handleActionWithType:ENUM_IAPPurchVerFailed data:nil];
        return;
    }
    if (!isSandBox) {
        // 购买成功将交易凭证发送给服务端进行再次校验
        [self ht_handleActionWithType:ENUM_IAPPurchSuccess data:receipt];
    }
    
    NSError *error;
    NSDictionary *var_requestContents = @{[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"receipt-data"]:[receipt base64EncodedStringWithOptions:0]};
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:var_requestContents options:0 error:&error];
     
    if (!requestData) {
        // 交易凭证为空验证失败
        [self ht_handleActionWithType:ENUM_IAPPurchVerFailed data:nil];
        return;
    }

    NSURL *storeURL = [NSURL URLWithString:isSandBox ? SandBox_VerifyURL : Produce_VerifyURL];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
     
    [[NSURLSession sharedSession] dataTaskWithRequest:storeRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            // 无法连接服务器,购买校验失败
            [self ht_handleActionWithType:ENUM_IAPPurchVerFailed data:nil];
        } else {
            NSError *error;
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!jsonResponse) {
                // 服务器校验数据返回为空校验失败
                [self ht_handleActionWithType:ENUM_IAPPurchVerFailed data:nil];
            }
            NSString *status = [NSString stringWithFormat:@"%@",jsonResponse[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]]];
            if (status && [status isEqualToString:@"0"]) {
                [self ht_handleActionWithType:ENUM_IAPPurchVerSuccess data:nil];
            } else if ([status integerValue] == 21007) {
                [self lgjeropj_verifyReceiptURL:YES];
            } else {
                [self ht_handleActionWithType:ENUM_IAPPurchVerFailed data:nil];
            }
        }
    }];
}
 
#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *product = response.products;
    if ([product count] <= 0) {
        return;
    }
     
    SKProduct *p = nil;
    for(SKProduct *pro in product) {
        if ([pro.productIdentifier isEqualToString:self.currentPurchasedID]) {
            p = pro;
            break;
        }
    }
    if (self.productsBlock && product) {
        [request cancel];
        self.productsBlock(product);
        self.productsBlock = nil;
        return;
    }
    if (self.productBlock && p) {
        [request cancel];
        self.productBlock(p);
        self.productBlock = nil;
        return;
    }
    if (self.payBlock) {
        SKPayment *payment = [SKPayment paymentWithProduct:p];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        self.payBlock = NO;
    }
    
}
 
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{

}
 
- (void)requestDidFinish:(SKRequest *)request{

}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    self.restoredArrauy = [NSMutableArray array];
    for (SKPaymentTransaction *var_tran in transactions) {
        switch (var_tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self verifyPurchaseWithPaymentTransaction:var_tran];
                break;
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStateRestored:{
                [self.restoredArrauy addObject:var_tran];
                self.curProduct = var_tran.payment.productIdentifier;
                [[SKPaymentQueue defaultQueue] finishTransaction:var_tran];
            }
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:var_tran];
                break;
            default:
                break;
        }
    }
}


- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    [self lgjeropj_hideLoading];
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    [[NSUserDefaults standardUserDefaults] setObject:self.curProduct forKey:@"udf_pid"];
    [[NSUserDefaults standardUserDefaults] setObject:receiptString forKey:@"udf_receipt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.restoreBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.restoredArrauy.count) {
                [self lgjeropj_showHint:LocalString(@"Success Restore", nil)];
                self.restoreBlock(self.restoredArrauy);
            } else {
                [self lgjeropj_showHint:LocalString(@"Nothing Restore", nil)];
                self.restoreBlock(nil);
            }
        });
    } else {
        [HTManage.sharedInstance ht_updateVipWithBlock:^(PayModel * _Nullable var_payModel) {} source:@"2"];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    [self lgjeropj_hideLoading];
    if (self.restoreBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self lgjeropj_showHint:LocalString(@"Nothing Restore", nil)];
            self.restoreBlock(nil);
        });
    }
}

// 交易失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        [self ht_handleActionWithType:ENUM_IAPPurchFailed data:nil];
    } else {
        [self ht_handleActionWithType:ENUM_IAPPurchCancel data:nil];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)ht_restorePurchaseCompleteHandle:(BLOCK_restoreCompletionBlock)handle{
    self.restoreBlock = handle;
    if ([SKPaymentQueue canMakePayments]) {
        [self lgjeropj_showLoading];
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
}

+ (NSString*)ht_getLocalIntroductoryPrice:(SKProduct*)product{
//    NSString *currencySymbol = [product.introductoryPrice.priceLocale objectForKey:NSLocaleCurrencySymbol];
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [format setNumberStyle:NSNumberFormatterCurrencyStyle];
    [format setLocale:product.introductoryPrice.priceLocale];
    NSString* var_formattedPrice = [format stringFromNumber:product.introductoryPrice.price];
    return var_formattedPrice;
}

+ (NSString*)ht_getLocalPrice:(SKProduct*)product{
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    [format setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [format setNumberStyle:NSNumberFormatterCurrencyStyle];
    [format setLocale:product.priceLocale];
    NSString* var_formattedPrice = [format stringFromNumber:product.price];
    return var_formattedPrice;
}
@end


