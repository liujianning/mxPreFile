//
//  HTToolSubscribeAlertView.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTToolSubscribeAlertView.h"
#import "HTToolKitManager.h"
#import "HTToolSubscribeGuideView.h"
#import "HTToolSubscribeToastView.h"
#import "HTCommonConfiguration.h"

@interface HTToolSubscribeAlertView ()

@property (nonatomic, strong) NSDictionary *var_params;

@property (nonatomic, assign) NSInteger source;

@end

@implementation HTToolSubscribeAlertView

- (void)lgjeropj_alertView {
 
    HTToolSubscribeGuideView *view = [[HTToolSubscribeGuideView alloc] init];
    __weak typeof(self) weakSelf = self;
    view.BLOCK_subscribeBlock = ^{
        [weakSelf lgjeropj_subscribeAction];
    };
    view.BLOCK_skipBlock = ^{
        [weakSelf lgjeropj_skipAction];
    };
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(300);
    }];
}

- (void)lgjeropj_toastView {
    
    HTToolSubscribeToastView *view = [[HTToolSubscribeToastView alloc] init];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(63);
    }];
}

- (void)lgjeropj_show:(NSDictionary *)dic source:(NSInteger)source {
    
    HTCommonConfiguration.lgjeropj_shared.BLOCK_stopAdBlock(YES);
    self.source = source;
    self.var_params = dic;
    NSInteger var_count = [[NSUserDefaults standardUserDefaults] integerForKey:@"udf_toolkit_guide_count"];
    BOOL var_alert = var_count < 3 && ![[HTToolKitManager shared] lgjeropj_installed];
    if (var_alert) {
        [self lgjeropj_show_maidian];
        [self lgjeropj_alertView];
        [[NSUserDefaults standardUserDefaults] setInteger:var_count+1 forKey:@"udf_toolkit_guide_count"];
    } else {
        [self lgjeropj_toastView];
    }

    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    if ([self isDescendantOfView:window] == NO) {
        [window addSubview:self];
    }
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (!var_alert) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self) [self lgjeropj_subscribeAction];
            });
        }
    }];
}

- (void)lgjeropj_dismiss {
    
    HTCommonConfiguration.lgjeropj_shared.BLOCK_stopAdBlock(NO);
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)lgjeropj_subscribeAction {
    
    [self lgjeropj_click_maidian:1];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"1" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
    NSString *var_product = self.var_params[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
    if ([var_product isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"week"]]) {
        var_product = @"1";
    } else if ([var_product isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"]]) {
        var_product = @"2";
    } else if ([var_product isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"]]) {
        var_product = @"3";
    } else if ([var_product isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fw"]]) {
        var_product = @"4";
    } else if ([var_product isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fm"]]) {
        var_product = @"5";
    } else if ([var_product isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fy"]]) {
        var_product = @"6";
    }
    // 1:个人周 2:个人月 3:个人年 4:家庭周 5:家庭月 6:家庭年
    [params setValue:var_product forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
    NSInteger var_activity = [self.var_params[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"activity"]] integerValue];
    [params setValue:var_activity > 0 ? var_product : @"0" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"activityProduct"]];
    HTCommonConfiguration.lgjeropj_shared.BLOCK_deepLinkBlock(params);
    [self removeFromSuperview];
}

- (void)lgjeropj_skipAction {
    
    [self lgjeropj_click_maidian:2];
    [self lgjeropj_dismiss];
}

- (void)lgjeropj_click_maidian:(NSInteger)kid
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(self.source) forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
    [params setValue:@(kid) forKey:[LKFPrivateFunction htMethodStringToInt:@"kid"]];
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"tspop_cl"] params:params];
}

- (void)lgjeropj_show_maidian
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(self.source) forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"tspop_sh"] params:params];
}

@end
