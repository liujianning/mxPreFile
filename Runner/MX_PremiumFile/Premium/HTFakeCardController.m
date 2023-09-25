//
//  HTFakeCardController.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTFakeCardController.h"
#import "HTToolKitManager.h"
#import "HTFakeCardGuideView.h"
#import "HTToolInstallGuideView.h"
#import "HTCommonConfiguration.h"

@interface HTFakeCardController ()

@property (nonatomic, strong) UIControl *var_backgroundView;
@property (nonatomic, strong) UIView *var_contentView;
@property (nonatomic, copy) dispatch_block_t var_after;
@property (nonatomic, strong) HTFakeCardGuideView *var_guideView;
@property (nonatomic, strong) HTToolInstallGuideView *var_installView;

@end

@implementation HTFakeCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterActivityBlock(YES);
    [self lgjeropj_initViews];
    [self lgjeropj_show_maidian];
}

- (void)lgjeropj_initViews {
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView *var_backgroundView = [[UIImageView alloc] init];
    [var_backgroundView ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:254]];
    var_backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:var_backgroundView];
    [var_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.var_guideView = [[HTFakeCardGuideView alloc] init];
    __weak typeof(self) weakSelf = self;
    self.var_guideView.var_becomeAction = ^{
        [weakSelf lgjeropj_becomeAction];
    };
    self.var_guideView.var_skipAction = ^{
        [weakSelf lgjeropj_skipAction];
    };
    [self.view addSubview:self.var_guideView];
    [self.var_guideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.center.mas_equalTo(0);
    }];    
}

- (void)lgjeropj_subscribeAction {
    
    NSDictionary *var_p1 = [[HTToolKitManager shared] lgjeropj_strip_p1];
    if (var_p1 == nil || var_p1.count == 0) {
        return;
    }
    [self lgjeropj_click_maidian:41];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"1" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
    // 1:个人周 2:个人月 3:个人年 4:家庭周 5:家庭月 6:家庭年
    [params setValue:@"2" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
    [params setValue:@"0" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"activityProduct"]];
    HTCommonConfiguration.lgjeropj_shared.BLOCK_deepLinkBlock(params);
    [self ht_backAction];
}

- (void)lgjeropj_installAction {
    
    [self lgjeropj_guide_show_maidian];
    
    if (!self.var_installView) {
        self.var_installView = [[HTToolInstallGuideView alloc] init];
        __weak typeof(self) weakSelf = self;
        self.var_installView.var_install = ^{
            [weakSelf lgjeropj_subscribeAction];
            [weakSelf ht_backAction];
        };
    }
    [self.var_installView lgjeropj_show];
}

- (void)lgjeropj_becomeAction
{
    NSInteger var_count = [[NSUserDefaults standardUserDefaults] integerForKey:@"udf_toolkit_guide_count"];
    BOOL var_installed = [[HTToolKitManager shared] lgjeropj_installed];
    if (var_count < 3 && !var_installed) {
        [[NSUserDefaults standardUserDefaults] setInteger:var_count+1 forKey:@"udf_toolkit_guide_count"];
        [self lgjeropj_installAction];
    } else {
        [self lgjeropj_subscribeAction];
    }
}

- (void)lgjeropj_skipAction
{
    [self lgjeropj_click_maidian:8];
    [self ht_backAction];
}

- (void)ht_backAction
{
    [super ht_backAction];
    HTCommonConfiguration.lgjeropj_shared.BLOCK_AppDelegateOpenAdBlock();
    [NSNotificationCenter.defaultCenter postNotificationName:@"NTFCTString_UpdateHomeHistory" object:nil userInfo:nil];
}

- (void)lgjeropj_show_maidian
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@1 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
    [params setValue:@14 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
    [params setValue:@3 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pay_method"]];
    [params setValue:@1 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vip_sh"] params:params];
}

- (void)lgjeropj_click_maidian:(NSInteger)kid
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@1 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
    [params setValue:@14 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
    [params setValue:@3 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pay_method"]];
    [params setValue:@1 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
    [params setValue:@(kid) forKey:[LKFPrivateFunction htMethodStringToInt:@"kid"]];
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vip_cl"] params:params];
}

- (void)lgjeropj_guide_show_maidian
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@8 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"tspop_sh"] params:params];
}

- (ENUM_ControllerNaviType)ht_customNaviType
{
    return ENUM_ControllerNaviTypeHide;
}

- (void)dealloc
{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterActivityBlock(NO);
}

@end
