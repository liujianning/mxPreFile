//
//  HTActivityVC.m
//  Movie
//
//  Created by wmz on 2023/4/23.
//

#import "HTActivityVC.h"
#import "HTToolKitManager.h"
#import "HTCommonConfiguration.h"
#import "YYText.h"

@interface HTActivityVC ()
@property (nonatomic,strong) UIImageView *iconIV;
@property (nonatomic,strong) UIButton *closeBTN;
@end

@implementation HTActivityVC

- (void)ht_setupViews{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterActivityBlock(YES);

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *var_visualView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    var_visualView.frame = self.view.bounds;
    var_visualView.alpha = 0.5;
    [self.view addSubview:var_visualView];
    
    self.view.backgroundColor = UIColor.clearColor;
    self.iconIV = [[UIImageView alloc] init];
    self.closeBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBTN setImage:[UIImage imageNamed:@"icon_home_close"] forState:UIControlStateNormal];
    self.closeBTN.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self.view addSubview:self.iconIV];
    [self.view addSubview:self.closeBTN];
    self.iconIV.backgroundColor = UIColor.whiteColor;
    [self.iconIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kWidthScale(272));
        make.height.mas_equalTo(kWidthScale(400));
        make.center.mas_equalTo(0);
    }];
    [self.iconIV ht_setImageWithURL:[NSURL URLWithString:self.icon]];
    [self.closeBTN mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconIV.mas_right).offset(-10);
        make.top.equalTo(self.iconIV.mas_top).offset(10);
    }];
    
    UILabel *more = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:LocalString(@"Choose more plans", nil)];
    string.yy_alignment = NSTextAlignmentCenter;
    string.yy_font = [UIFont systemFontOfSize:14];
    string.yy_color = UIColor.whiteColor;
    string.yy_underlineStyle = NSUnderlineStyleSingle;
    string.yy_underlineColor  = [UIColor ht_colorWithHexString:@"#ECECEC"];
    more.attributedText = string;
    [self.view addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconIV.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
    }];
    more.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_moreAction)];
    [more addGestureRecognizer:tapGesture];

    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_backAction)];
    self.closeBTN.userInteractionEnabled = YES;
    [self.closeBTN addGestureRecognizer:closeTap];
    
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_subscribeAction)];
    self.iconIV.userInteractionEnabled = YES;
    [self.iconIV addGestureRecognizer:iconTap];
}

- (void)ht_moreAction {
 
    [self ht_backAction];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HTCommonConfiguration.lgjeropj_shared.BLOCK_toPayBlock(nil, @"14");
    });
}

- (void)ht_subscribeAction {
    
    if ([[HTToolKitManager shared] lgjeropj_strip_k12]) {
        NSString *var_activity_product = @"";
        NSArray *var_k3 = [[HTToolKitManager shared] lgjeropj_strip_k3];
        if (var_k3.count > 0) {
            NSInteger var_activity = [[var_k3 firstObject] integerValue];
            if (var_activity == 1) {
                // 有活动
                if (var_k3.count > 2) {
                    var_activity_product = [NSString stringWithFormat:@"%@", [var_k3 objectAtIndex:2]];
                }
            }
        }
        if (var_activity_product.length > 0) {
            // 活动深链跳转投屏工具包
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setValue:@"1" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
            if ([var_activity_product containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"week"]]) {
                var_activity_product = @"1";
            } else if ([var_activity_product containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"]]) {
                var_activity_product = @"2";
            } else if ([var_activity_product containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"]]) {
                var_activity_product = @"3";
            }
            // 1:个人周 2:个人月 3:个人年 4:家庭周 5:家庭月 6:家庭年
            [params setValue:var_activity_product forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
            [params setValue:var_activity_product forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"activityProduct"]];
            HTCommonConfiguration.lgjeropj_shared.BLOCK_deepLinkBlock(params);
            [self ht_backAction];
            return;
        }
    }
    [self ht_payAction:self.productId andBlock:^(BOOL var_success) {
        [self ht_backAction];
    }];
}

- (void)ht_backAction {
    HTCommonConfiguration.lgjeropj_shared.BLOCK_AppDelegateOpenAdBlock();
    [NSNotificationCenter.defaultCenter postNotificationName:@"NTFCTString_UpdateHomeHistory" object:nil userInfo:nil];
    [super ht_backAction];
}

- (ENUM_ControllerNaviType)ht_customNaviType{
    return ENUM_ControllerNaviTypeHide;
}

- (void)dealloc{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterActivityBlock(NO);
}

@end
