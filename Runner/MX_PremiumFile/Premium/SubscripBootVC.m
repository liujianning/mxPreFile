//
//  BubscripBootVC.m
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import "SubscripBootVC.h"
#import "AppDelegate.h"
#import "MainTabbarVC.h"
#import "HTSubscripBootBottomView.h"
#import "HTSubscripBootInterestView.h"
#import "HTCommonConfiguration.h"
#import "YYText.h"
#import "IAPManager.h"

@interface SubscripBootVC ()

@property (nonatomic, strong) HTSubscripBootBottomView *var_bottomView;

@end

@implementation SubscripBootVC

- (void)ht_setupViews{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterActivityBlock(YES);
    
    [super ht_setupViews];
    self.view.backgroundColor = UIColor.blackColor;
    UIButton *closeBTN = [[UIButton alloc] init];
    [closeBTN setImage:[UIImage imageNamed:@"icon_home_close"] forState:UIControlStateNormal];
    [closeBTN addTarget:self action:@selector(ht_backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBTN];
    [closeBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HTNum(37));
        make.top.mas_equalTo(HTNavigationStatusBar + HTNum(10));
    }];
    
    HTSubscripBootInterestView *interestView = [[HTSubscripBootInterestView alloc] init];
    [self.view addSubview:interestView];
    [interestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(closeBTN.mas_bottom).offset(8);
    }];
        
    self.var_bottomView = [[HTSubscripBootBottomView alloc] init];
    __weak typeof(self) weakSelf = self;
    self.var_bottomView.BLOCK_payBlock = ^{
        [weakSelf ht_payAction];
    };
    self.var_bottomView.BLOCK_moreBlock = ^{
        [weakSelf ht_moreAction];
    };
    [self.view addSubview:self.var_bottomView];
    [self.var_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(interestView.mas_bottom).offset(HTNum(60));
        make.left.right.mas_equalTo(0);
    }];
}

- (void)ht_moreAction {
    HTCommonConfiguration.lgjeropj_shared.BLOCK_toPayBlock(nil, @"14");
}

- (void)ht_backAction {
    HTCommonConfiguration.lgjeropj_shared.BLOCK_AppDelegateOpenAdBlock();
    [super ht_backAction];
    [NSNotificationCenter.defaultCenter postNotificationName:@"NTFCTString_UpdateHomeHistory" object:nil userInfo:nil];
}

- (void)ht_payAction
{
    __weak typeof(self) weakSelf = self;
    [self ht_payAction:STATIC_MONTH andBlock:^(BOOL var_success) {
        [weakSelf ht_backAction];
    }];
}

- (void)ht_getNewData{
    if (!HTManage.sharedInstance.model5) {
        [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/300/"] andParams:@{} andViewController:nil andBlock:^(id  _Nullable data, BOOL result) {
             if (result) {
                HTManage.sharedInstance.model5 = [SubscribeModel yy_modelWithJSON:data];
             }
        }];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"udf_firstMonth"]) {
        NSString *var_price = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$4.99"];
        NSMutableAttributedString *matr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",var_price , LocalString(@"month", nil)]];
        matr.yy_color = [UIColor ht_colorWithHexString:@"#685034"];
        matr.yy_font = [UIFont boldSystemFontOfSize:23];
        [matr yy_setFont:[UIFont systemFontOfSize:10] range:[matr.string rangeOfString:[NSString stringWithFormat:@"%@/", LocalString(@"month", nil)]]];
        [self.var_bottomView.var_priceBTN setAttributedTitle:matr forState:UIControlStateNormal];
    } else {
        __weak typeof(self) weakSelf = self;
        [IAPManager.sharedInstance ht_querryPurchaseWithID:STATIC_MONTH andBlock:^(SKProduct * _Nonnull product) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *var_price =  [IAPManager ht_getLocalIntroductoryPrice:product];
                NSMutableAttributedString *matr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",var_price , LocalString(@"month", nil)]];
                matr.yy_color = [UIColor ht_colorWithHexString:@"#685034"];
                matr.yy_font = [UIFont boldSystemFontOfSize:23];
                [matr yy_setFont:[UIFont systemFontOfSize:10] range:[matr.string rangeOfString:[NSString stringWithFormat:@"%@/", LocalString(@"month", nil)]]];
                [weakSelf.var_bottomView.var_priceBTN setAttributedTitle:matr forState:UIControlStateNormal];
            });
        }];
    }
}

- (ENUM_ControllerNaviType)ht_customNaviType{
    return ENUM_ControllerNaviTypeHide;
}

- (void)dealloc{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterActivityBlock(NO);
}

@end
