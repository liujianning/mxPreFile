//
//  HTFamilyGroupManager.m
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import "HTFamilyGroupManager.h"
#import "HTCommonConfiguration.h"
#import "NSObject+Toast.h"

@implementation HTFamilyGroupManager

+ (void)lgjeropj_requestFamilyInfo:(void(^)(id data))completion
{
    UIViewController *vc = HTCommonConfiguration.lgjeropj_shared.BLOCK_currentVCBlock();
    UserModel *loginUser = HTManage.sharedInstance.model2;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:loginUser.var_uid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"uid"]];
    [dict setObject:loginUser.var_fid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"]];
    [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/284/"] andParams:dict andViewController:vc andStatus:YES andBlock:^(id  _Nullable data, BOOL result) {
        if (completion) {
            completion(data);
        }
    }];
}

+ (void)ht_deleteFamilyMember:(ZQFamilyAccountModel *)model andComplete:(void(^)(id data))completion {
    
    UserModel *loginUser = HTManage.sharedInstance.model2;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:model.var_mail forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mail"]];
    [dict setObject:loginUser.var_fid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"]];
    __weak typeof(self) weakSelf = self;
    [self lgjeropj_showLoading];
    [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/283/"] andParams:dict andViewController:HTCommonConfiguration.lgjeropj_shared.BLOCK_currentVCBlock() andStatus:YES andBlock:^(id  _Nullable data, BOOL result) {
        [weakSelf lgjeropj_hideLoading];
        if (result) {
            if (completion) {
                completion(data);
            }
        } else {
            [weakSelf lgjeropj_showHint:LocalString(@"Time out, server is not responding.", nil)];
        }
    }];
}

+ (void)ht_dissolveFamilyGroupAction:(void(^)(id data))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:LocalString(@"Are you sure you want to delete this family account?", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:LocalString(@"Delete", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UserModel *loginUser = HTManage.sharedInstance.model2;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:loginUser.var_uid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"uid"]];
        [dict setObject:loginUser.var_fid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"]];
        [weakSelf lgjeropj_showLoading];
        [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/327/"] andParams:dict andViewController:HTCommonConfiguration.lgjeropj_shared.BLOCK_currentVCBlock() andStatus:YES andBlock:^(id  _Nullable data, BOOL result) {
            [weakSelf lgjeropj_hideLoading];
            if (result) {
                if (completion) {
                    completion(data);
                }
            } else {
                [weakSelf lgjeropj_showHint:LocalString(@"Time out, server is not responding.", nil)];
            }
        }];
    }];
    [alertController addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LocalString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    UIViewController *vc = HTCommonConfiguration.lgjeropj_shared.BLOCK_currentVCBlock();
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = vc.view;
        popover.sourceRect = CGRectMake(HTWidth *0.5 - 100, HTHeight, 200, 250);
        popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
    }
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)lgjeropj_addMemberRequest:(NSString *)title andComplete:(void(^)(void))completion
{
    [self lgjeropj_showLoading];
    UIViewController *vc = HTCommonConfiguration.lgjeropj_shared.BLOCK_currentVCBlock();
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:title forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mail"]];
    UserModel *loginUser = HTManage.sharedInstance.model2;
    [params setObject:loginUser.var_fid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"]];
    __weak typeof(self) weakSelf = self;
    [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/282/"] andParams:params andViewController:vc andStatus:YES andBlock:^(id  _Nullable data, BOOL result) {
        [weakSelf lgjeropj_hideLoading];
        if (result) {
            NSInteger status = [[data objectForKey:@"status"] integerValue];
            if (status == 200) {
                NSInteger remain = [data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"remain"]] integerValue];
                if (remain == 0) {
                    [weakSelf lgjeropj_showHint:LocalString(@"Family members reached the upper limit", nil)];
                } else {
                    [weakSelf lgjeropj_showHint:LocalString(@"Added successfully", nil)];
                }
            } else if (status == 300) {
                [weakSelf lgjeropj_showHint:LocalString(@"The account does not exist", nil)];
            } else if (status == 301) {
                [weakSelf lgjeropj_showHint:LocalString(@"The user already exists", nil)];
            } else if (status == 302) {
                [weakSelf lgjeropj_showHint:LocalString(@"The user has already joined another family plan", nil)];
            } else if (status == 304) {
                NSString *var_titleStr = LocalString(@"Added successfully", nil);
                NSString *var_msgStr = LocalString(@"Please ask your family to install this app and log in to an account with **** on the Mylibrary page.", nil);
                var_msgStr = [var_msgStr stringByReplacingOccurrencesOfString:@"****" withString:title];
                NSInteger var_remain = [[data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"remain"]] integerValue];
                if (var_remain <= 0) {
                    var_msgStr = [NSString stringWithFormat:@"%@\n%@", var_msgStr, LocalString(@"Family members reached the upper limit", nil)];
                }
                [weakSelf ht_shareMemberThisApp:var_titleStr andMsg:var_msgStr];
                if (completion) {
                    completion();
                }
            } else {
                [weakSelf lgjeropj_showHint:[data objectForKey:@"msg"]];
            }
        } else {
            [weakSelf lgjeropj_showHint:LocalString(@"Time out, server is not responding.", nil)];
        }
    }];
}

+ (void)ht_shareMemberThisApp:(NSString *)title andMsg:(NSString *)message
{
    UIViewController *vc = HTCommonConfiguration.lgjeropj_shared.BLOCK_currentVCBlock();
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:LocalString(@"Share the app with my family", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [HTManage ht_shareTitle:[LKFPrivateFunction lgjeropj_stringFillEmpty:HTManage.sharedInstance.model3.var_appm_text] andURL:[LKFPrivateFunction lgjeropj_stringFillEmpty:HTManage.sharedInstance.model3.var_appm_link] andImage:nil];
    }];
    [alertController addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LocalString(@"Cancel", nil) style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = vc.view;
        popover.sourceRect = CGRectMake(HTWidth *0.5 - 100, HTHeight, 200, 250);
        popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
    }
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)ht_showHowAddMember
{
    UIViewController *vc = HTCommonConfiguration.lgjeropj_shared.BLOCK_currentVCBlock();
    NSString *var_titleStr = LocalString(@"How to add family accounts:", nil);
    NSMutableString *var_msgStr = [NSMutableString stringWithString:LocalString(@"Enter the email address or account ID of a family member and click Add to add him or her successfully.", nil)];
    [var_msgStr appendString:@"\n\n"];
    [var_msgStr appendString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Note: "]];
    [var_msgStr appendString:@"\n"];
    [var_msgStr appendString:LocalString(@"Family members need to Log In to their family account to get the premium version.", nil)];
    [var_msgStr appendString:@"\n"];
    [var_msgStr appendString:LocalString(@"Your family members can register an account in the My library page or Settings page of the app.", nil)];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:var_titleStr message:var_msgStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LocalString(@"OK", nil) style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = vc.view;
        popover.sourceRect = CGRectMake(HTWidth *0.5 - 100, HTHeight, 200, 250);
        popover.permittedArrowDirections = UIPopoverArrowDirectionDown;
    }
    [vc presentViewController:alertController animated:YES completion:nil];
}

@end
