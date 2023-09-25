//
//  PayVC.m
//  Movie
//
//  Created by wmz on 2023/3/10.
//

#import "PayVC.h"
#import "NSObject+Toast.h"
#import "IAPManager.h"

@interface PayVC ()

@end

@implementation PayVC

- (void)ht_payAction:(NSString*)proeuctId andBlock:(nullable BLOCK_PayPurchaseResultBlock)block {
    [self lgjeropj_showLoadingForSuperView:self.view];
    [[IAPManager sharedInstance] ht_startPurchaseWithID:proeuctId andCompleteHandle:^(ENUM_IAPPurchType type,NSData *data) {
        [self lgjeropj_hideLoadingForSuperView:self.view];
        if (type == ENUM_IAPPurchSuccess) {
            NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
            NSData *receiptData = [NSData dataWithContentsOfURL:recepitURL];
            NSString *receipt = [receiptData base64EncodedStringWithOptions:0];
            [self lgjeropj_showLoadingForSuperView:self.view];
            [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/325/"] andParams:@{
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"flag"]:@"1",
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"vp"]:HTManage.sharedInstance.model6.var_local.var_value == 1 ? @"1" : @"0",
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pid"]:[LKFPrivateFunction lgjeropj_stringFillEmpty:proeuctId],
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"receipt"]:[LKFPrivateFunction lgjeropj_stringFillEmpty:receipt]
            } andViewController:self andBlock:^(id  _Nullable data, BOOL result) {
                [self lgjeropj_hideLoadingForSuperView:self.view];
                PayModel *var_payModel = [PayModel yy_modelWithJSON:data];
                var_payModel.var_local.var_pid = [LKFPrivateFunction lgjeropj_stringFillEmpty:proeuctId];
                if (result && ([var_payModel.var_server.var_val2 isEqualToString:@"1"] || var_payModel.var_local.var_value == 1)) {
                    [self lgjeropj_showHint:LocalString(@"Pay Success!", nil) superView:self.view];
                } else {
                    [self lgjeropj_showHint:LocalString(@"Pay Fail!", nil) superView:self.view];
                }
                [[NSUserDefaults standardUserDefaults] setObject:proeuctId forKey:@"udf_pid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if ([proeuctId isEqualToString:[NSString stringWithFormat:@"%@_%@", STATIC_Free, STATIC_MONTH]]) {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"udf_freeMonth"];
                } else if ([proeuctId isEqualToString:STATIC_MONTH]) {
                    [[NSUserDefaults standardUserDefaults] setObject:proeuctId forKey:@"udf_firstMonth"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                [HTManage.sharedInstance ht_updateVipWithBlock:^(PayModel * _Nullable var_payModel) {
                    [self ht_getWillData];
                } source:@"3"];
                if (block) {
                    block (YES);
                }
            }];
        } else if (type == ENUM_IAPPurchVerFailed || type == ENUM_IAPPurchFailed) {
            [self lgjeropj_showHint:LocalString(@"Pay Fail!", nil) superView:self.view];
            if (block) {
                block (NO);
            }
        }
    }];
}

@end
