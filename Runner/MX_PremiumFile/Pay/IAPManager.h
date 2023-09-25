//
//  IAPManager.h
//  Movie
//
//  Created by wmz on 2023/3/14.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    ENUM_IAPPurchSuccess = 0,       // 购买成功
    ENUM_IAPPurchFailed = 1,        // 购买失败
    ENUM_IAPPurchCancel = 2,        // 取消购买
    ENUM_IAPPurchVerFailed = 3,     // 订单校验失败
    ENUM_IAPPurchVerSuccess = 4,    // 订单校验成功
    ENUM_IAPPurchNotArrow = 5,      // 不允许内购
}ENUM_IAPPurchType;

typedef void (^BLOCK_iapCompletionBlock)(ENUM_IAPPurchType type,NSData *data);
typedef void (^BLOCK_productCompletionBlock)(SKProduct *product);
typedef void (^BLOCK_productsCompletionBlock)(NSArray *products);
typedef void (^BLOCK_restoreCompletionBlock)(id _Nullable data);
@interface IAPManager : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic,copy,nullable) BLOCK_productCompletionBlock productBlock;
@property (nonatomic,copy,nullable) BLOCK_productsCompletionBlock productsBlock;
@property (nonatomic,assign) BOOL payBlock;
@property (nonatomic,copy) NSString *curProduct;

- (void)ht_querryPurchaseWithArray:(NSArray *)products andBlock:(BLOCK_productsCompletionBlock)handle;
- (void)ht_querryPurchaseWithID:(NSString *)purchID andBlock:(BLOCK_productCompletionBlock)handle;
- (void)ht_startPurchaseWithID:(NSString *)purchID andCompleteHandle:(BLOCK_iapCompletionBlock)handle;
/// 恢复交易
- (void)ht_restorePurchaseCompleteHandle:(BLOCK_restoreCompletionBlock)handle;
+ (NSString*)ht_getLocalIntroductoryPrice:(SKProduct*)product;
+ (NSString*)ht_getLocalPrice:(SKProduct*)product;
@end

NS_ASSUME_NONNULL_END
