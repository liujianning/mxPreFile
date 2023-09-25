//
//  PremiumVC.m
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import "PremiumVC.h"
#import "PremiumCell.h"
#import "PreiumBottomView.h"
#import "HTToolKitManager.h"
#import "HTWebViewController.h"
#import "HTToolSubscribeAlertView.h"
#import "HTUnSubscribeRemindView.h"
#import "HTFamilyViewController.h"
#import "HTDerivativeView.h"
#import "HTPremiumProductManager.h"
#import "HTRestoreLabel.h"
#import "HTPremiumHeaderView.h"
#import "UIView+UIViewController.h"
#import "HTCollectionViewModel.h"
#import "HTCommonConfiguration.h"
#import "BaseIconTextView.h"
#import "IAPManager.h"

@interface PremiumVC ()<HTCollectionViewModelDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HTCollectionViewModel *collectionViewModel;
@property (nonatomic, strong) UIView *confirmView;
@property (nonatomic, strong) UIView *accessView;
@property (nonatomic, strong) UIView *privilegeView;
@property (nonatomic, strong) UIButton *individualBtn;
@property (nonatomic, strong) UIButton *familyBtn;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) YYLabel *restoreLabel;
@property (nonatomic, strong) PreiumBottomView *preBottomView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *var_familyData;
@property (nonatomic, strong) BaseCellModel *selectModel;
@property (nonatomic, strong) UIButton *confirmBTN;
@property (nonatomic, strong) HTPremiumHeaderView *headView;
@property (nonatomic, strong) HTPremiumProductManager *productManager;
@property (nonatomic, strong) BaseCellModel *monthModel;
@property (nonatomic, strong) BaseCellModel *familyMonthModel;
/// 是否选中家庭计划
@property (nonatomic, assign) BOOL var_family;

@end

@implementation PremiumVC
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterPreVCBlock(NO);
    [NSNotificationCenter.defaultCenter postNotificationName:@"NTFCTString_Rotation_OPEN" object:nil];
}

- (void)ht_setupNavigation{
    [self ht_customBack:@"icon_back" andForce:self.var_showBack];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterPreVCBlock(NO);
}

- (void)ht_scrollView{
    self.var_scrollView = [[UIScrollView alloc] init];
    self.var_scrollView.showsVerticalScrollIndicator = NO;
    self.var_scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.var_scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.var_scrollView];
    [self.var_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    self.contenView = [[UIView alloc] init];;
    [self.var_scrollView addSubview:self.contenView];
    [self.contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.width.equalTo(self.var_scrollView.mas_width);
    }];
}

- (void)ht_getWillData{
    [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/78/"] andParams:HTCommonConfiguration.lgjeropj_shared.BLOCK_takePartInfoParamsBlock() andViewController:self andBlock:^(id  _Nullable data, BOOL result) {
        if (result) {
            ShareModel *model = HTManage.sharedInstance.model3;
            ShareModel *nowModel = [ShareModel yy_modelWithJSON:data];
            if (model.var_gd_nstll.status != nowModel.var_gd_nstll.status) {
                [self ht_setupViews];
            }
            HTManage.sharedInstance.model3 = nowModel;
        }
    }];
    [self ht_updateUI];
    
    NSLog(@"🐴订阅页展示");
    NSString *var_pay_method = [[HTToolKitManager shared] lgjeropj_strip_k12] ? @"3" : @"0";
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vip_sh"] params:@{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]:self.source?:@"1",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]:[self ht_getPointType],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pay_method"]:var_pay_method,
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]:@"1",
        [LKFPrivateFunction htMethodStringToInt:@"userid"]:HTManage.sharedInstance.model2.var_uid?:@"",
    }];
}

- (void)ht_updateUI {
    
    if ([self ht_doublePremium]) {
        self.headView.head2Icon.hidden = NO;
        [self ht_updateLocalUI];
    } else {
        self.headView.head2Icon.hidden = YES;
    }
    [self ht_updateServerUI];
}

- (void)ht_updateLocalUI {
    
    [self.headView ht_updateLocalUI];
}

- (void)ht_updateServerUI {
    
    BOOL pay = [HTManage.sharedInstance ht_checkSub];
    if (!pay) {
        [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(HTNumB(20));
            make.height.mas_equalTo(HTNumB(72));
        }];
    } else {
        BOOL var_isFamily = NO;
        if ([HTManage.sharedInstance.model6.var_family.var_val integerValue] == 1) {
            var_isFamily = YES;
        }
        if (var_isFamily) {
            [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(HTNumB(20));
                make.height.mas_equalTo(HTNumB(72+44));
            }];
        } else {
            [self.headView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.top.mas_equalTo(HTNumB(20));
                make.height.mas_equalTo(HTNumB(72));
            }];
        }
    }
    [self.headView ht_updateServerUI];
    [self ht_updatePrice];
}

- (void)ht_familyMemberAction {
    
    HTFamilyViewController *vc = [[HTFamilyViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_add_family_member_red"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self ht_updateUI];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HTCommonConfiguration.lgjeropj_shared.BLOCK_enterPreVCBlock(YES);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ht_purchase_verify) name:@"NTFCTString_PurchaseVerifyCompletion" object:nil];
}

- (void)ht_purchase_verify {
    
    [self ht_getWillData];
    [self ht_showRemindIcon];
    [self ht_showUnsubscribeAlertView];
}

- (void)ht_setupViews {
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [NSNotificationCenter.defaultCenter postNotificationName:@"NTFCTString_Rotation_CLOSE" object:nil];
    [self ht_scrollView];
    self.title = LocalString(@"Premium", nil);
    self.view.backgroundColor = [UIColor ht_colorWithHexString:@"#111218"];
    
    [self.contenView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(HTNumB(20));
        make.height.mas_equalTo(HTNumB(72));
    }];
    
    self.privilegeView = [[UIView alloc] init];
    self.privilegeView.backgroundColor = [UIColor ht_colorWithHexString:@"#161A26"];
    [self.contenView addSubview:self.privilegeView];
    [self.privilegeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(20);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    
    self.individualBtn = [[UIButton alloc] init];
    self.individualBtn.backgroundColor = [UIColor ht_colorWithHexString:@"#111218"];
    [self.individualBtn setTitle:LocalString(@"Individual Plan", nil) forState:UIControlStateNormal];
    [self.individualBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.individualBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.individualBtn addTarget:self action:@selector(ht_individualAction) forControlEvents:UIControlEventTouchUpInside];
    [self.privilegeView addSubview:self.individualBtn];
    [self.individualBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(HTWidth/2);
    }];
    
    self.familyBtn = [[UIButton alloc] init];
    self.familyBtn.backgroundColor = [UIColor ht_colorWithHexString:@"#161A26"];
    [self.familyBtn setTitle:LocalString(@"Family Plan", nil) forState:UIControlStateNormal];
    [self.familyBtn setTitleColor:[UIColor ht_colorWithHexString:@"#727682"] forState:UIControlStateNormal];
    self.familyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.familyBtn addTarget:self action:@selector(ht_familyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.privilegeView addSubview:self.familyBtn];
    [self.familyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(0);
        make.width.mas_equalTo(HTWidth/2);
    }];

    UIView *accessView = [[UIView alloc] init];
    accessView.layer.backgroundColor = [UIColor clearColor].CGColor;
    accessView.layer.masksToBounds = YES;
    [self.contenView addSubview:accessView];
    [accessView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNumB(16));
        make.right.mas_equalTo(-HTNumB(16));
        make.top.equalTo(self.privilegeView.mas_bottom);
        make.height.mas_equalTo(HTNumB(76));
    }];
    self.accessView = accessView;
    
    if (true) {
        BaseIconTextView *one = [[BaseIconTextView alloc] initWithFrame:CGRectZero andPosition:0 andTextAligment:NSTextAlignmentLeft andTextFont:[UIFont boldSystemFontOfSize:12] andTextColor:[UIColor ht_colorWithHexString:@"#EAE9EE"] andText:LocalString(@"Remove ads", nil) andImage:[LKFPrivateFunction htMethodImageStringFromNumber:212] andIconInsets:UIEdgeInsetsMake(0, 0, 0, HTNumB(10)) andTextInsets:UIEdgeInsetsMake(0, HTNum(8), 0, 0) andIconSize:CGSizeMake(HTNumB(15), HTNumB(15))];
        [accessView addSubview:one];
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HTNumB(16));
            make.top.mas_equalTo(HTNumB(16));
        }];
        
        BaseIconTextView *two = [[BaseIconTextView alloc] initWithFrame:CGRectZero andPosition:0 andTextAligment:NSTextAlignmentLeft andTextFont:[UIFont boldSystemFontOfSize:12] andTextColor:[UIColor ht_colorWithHexString:@"#EAE9EE"] andText:LocalString(@"Unlock all movies", nil) andImage:[LKFPrivateFunction htMethodImageStringFromNumber:212] andIconInsets:UIEdgeInsetsMake(0, 0, 0, HTNumB(10)) andTextInsets:UIEdgeInsetsMake(0, HTNum(8), 0, 0) andIconSize:CGSizeMake(HTNumB(15), HTNumB(15))];
        [accessView addSubview:two];
        [two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-HTNumB(4));
            make.top.mas_equalTo(HTNumB(16));
            make.left.mas_equalTo(HTWidth/2+10);
        }];
    }
    if (true) {
        BaseIconTextView *one = [[BaseIconTextView alloc] initWithFrame:CGRectZero andPosition:0 andTextAligment:NSTextAlignmentLeft andTextFont:[UIFont boldSystemFontOfSize:12] andTextColor:[UIColor ht_colorWithHexString:@"#EAE9EE"] andText:LocalString(@"HD Resources", nil) andImage:[LKFPrivateFunction htMethodImageStringFromNumber:212] andIconInsets:UIEdgeInsetsMake(0, 0, 0, HTNumB(10)) andTextInsets:UIEdgeInsetsMake(0, HTNum(8), 0, 0) andIconSize:CGSizeMake(HTNumB(15), HTNumB(15))];
        [accessView addSubview:one];
        [one mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HTNumB(46));
            make.left.mas_equalTo(HTNumB(16));
        }];
        
        BaseIconTextView *two = [[BaseIconTextView alloc] initWithFrame:CGRectZero andPosition:0 andTextAligment:NSTextAlignmentLeft andTextFont:[UIFont boldSystemFontOfSize:12] andTextColor:[UIColor ht_colorWithHexString:@"#EAE9EE"] andText:LocalString(@"Unlimited Screen Casting", nil) andImage:[LKFPrivateFunction htMethodImageStringFromNumber:212] andIconInsets:UIEdgeInsetsMake(0, 0, 0, HTNumB(10)) andTextInsets:UIEdgeInsetsMake(0, HTNum(8), 0, 0) andIconSize:CGSizeMake(HTNumB(15), HTNumB(15))];
        [accessView addSubview:two];
        [two mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HTNumB(46));
            make.right.mas_offset(-HTNumB(4));
            make.left.mas_equalTo(HTWidth/2+10);
        }];
        
        BaseIconTextView *five = [[BaseIconTextView alloc] initWithFrame:CGRectZero andPosition:0 andTextAligment:NSTextAlignmentLeft andTextFont:[UIFont boldSystemFontOfSize:12] andTextColor:[UIColor ht_colorWithHexString:@"#EAE9EE"] andText:LocalString(@"Up To 5 Members", nil) andImage:[LKFPrivateFunction htMethodImageStringFromNumber:212] andIconInsets:UIEdgeInsetsMake(0, 0, 0, HTNumB(10)) andTextInsets:UIEdgeInsetsMake(0, HTNum(8), 0, 0) andIconSize:CGSizeMake(HTNumB(15), HTNumB(15))];
        [accessView addSubview:five];
        [five mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(HTNumB(76));
            make.left.mas_equalTo(HTNumB(16));
        }];
    }
    if (HTManage.sharedInstance.model3.var_gd_nstll.status == 0) {
        [self ht_addCollectionView];
        [self ht_addContentView];
    } else {
        [self ht_addInstallView];
    }
    [self ht_getWillData];
    [self ht_showRemindIcon];
}

- (BOOL)ht_doublePremium {
    
    BOOL var_localVip = HTManage.sharedInstance.model6.var_local.var_value == 1;
    BOOL var_deviceVip = [HTManage.sharedInstance.model6.var_device.var_val integerValue] == 1;
    BOOL var_toolVip = [HTManage.sharedInstance.model6.var_server.var_t1 integerValue] == 2;
    return var_localVip && !var_deviceVip && var_toolVip;
}

- (void)ht_showRemindIcon {
    
    BOOL var_show = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_unsubscribe_icon"];
    if (!var_show) {
        return;
    }
    if ([self ht_doublePremium]) {
        // 既是本地vip 又是工具包vip 且不是绑定在设备上
        UIButton *rightView = [[UIButton alloc] init];
        rightView.frame = CGRectMake(0, 0, 44, 44);
        [rightView addTarget:self action:@selector(ht_unsubscribeAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:248]];
        [rightView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(29, 24));
        }];
        
        BOOL var_show_red = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_unsubscribe_red"];
        if (!var_show_red) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor redColor];
            view.layer.cornerRadius = 3;
            view.layer.masksToBounds = YES;
            [rightView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.equalTo(imageView);
                make.size.mas_equalTo(6);
            }];
        }
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    }
}

- (void)ht_showUnsubscribeAlertView {
    
    BOOL var_reminded = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_unsubscribe"];
    if (var_reminded) {
        // 弹过就不弹了
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_unsubscribe"];
    if ([self ht_doublePremium]) {
        // 既是本地vip 又是工具包vip 且不是绑定在设备上
        HTUnSubscribeRemindView *view = [[HTUnSubscribeRemindView alloc] init];
        view.block = ^(id  _Nullable data) {
            // skip 显示右上角icon
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_unsubscribe_icon"];
            [self ht_showRemindIcon];
        };
        [view lgjeropj_show];
    }
}

- (void)ht_unsubscribeAction {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_unsubscribe_red"];
    HTUnSubscribeRemindView *view = [[HTUnSubscribeRemindView alloc] init];
    [view lgjeropj_show];
    [self ht_showRemindIcon];
    
    // 埋点
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(44) forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
    [params setValue:@(46) forKey:[LKFPrivateFunction htMethodStringToInt:@"kid"]];
    [[HTPointRequest sharedInstance] ht_point:[LKFPrivateFunction htMethodStringToInt:@"vip_cl"] params:params];
}

- (void)ht_individualAction {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.var_family = NO;
        self.individualBtn.backgroundColor = [UIColor ht_colorWithHexString:@"#111218"];
        self.familyBtn.backgroundColor = [UIColor ht_colorWithHexString:@"#161A26"];
        self.individualBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.familyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.individualBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.familyBtn setTitleColor:[UIColor ht_colorWithHexString:@"#727682"] forState:UIControlStateNormal];
        self.selectModel.var_select = NO;
        self.selectModel = self.dataSource.firstObject;
        self.selectModel.var_select = YES;
        [self.collectionView reloadData];
        [self.accessView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HTNumB(76));
        }];
    });
}

- (void)ht_familyAction {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.var_family = YES;
        self.familyBtn.backgroundColor = [UIColor ht_colorWithHexString:@"#111218"];
        self.individualBtn.backgroundColor = [UIColor ht_colorWithHexString:@"#161A26"];
        self.familyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.individualBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.familyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.individualBtn setTitleColor:[UIColor ht_colorWithHexString:@"#727682"] forState:UIControlStateNormal];
        self.selectModel.var_select = NO;
        self.selectModel = self.var_familyData.firstObject;
        self.selectModel.var_select = YES;
        [self.collectionView reloadData];
        [self.accessView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(HTNumB(96));
        }];
    });
}

///导量UI
- (void)ht_addInstallView {
    
    GdNstllModel *model = HTManage.sharedInstance.model3.var_gd_nstll;
    NSLog(@"🐴导量显示");
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"app_guide_sh"] params:@{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]:@(model.status).stringValue,
        [LKFPrivateFunction htMethodStringToInt:@"g_name"]:model.var_a1 ?: @"",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]:@"4",
        [LKFPrivateFunction htMethodStringToInt:@"vip_name"]:HTCommonConfiguration.lgjeropj_shared.BLOCK_takePartInfoParamsBlock()[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"p1"]],
        [LKFPrivateFunction htMethodStringToInt:@"vip_type"]:HTCommonConfiguration.lgjeropj_shared.BLOCK_takePartInfoParamsBlock()[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"p2"]]
    }];
    
    HTDerivativeView *view = [[HTDerivativeView alloc] init];
    [self.contenView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accessView.mas_bottom).offset(HTNumB(16));
        make.left.mas_equalTo(HTNumB(50));
        make.right.mas_equalTo(-HTNumB(50));
        make.bottom.mas_equalTo(0);
    }];
}

- (void)ht_addCollectionView {
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = HTNumB(12);
    flow.minimumInteritemSpacing = HTNumB(12);
    CGFloat itemWidth = floor((HTWidth - HTNumB(56))/3.0);
    flow.itemSize = CGSizeMake(itemWidth, itemWidth * 68 / 53);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flow];
    self.collectionView.delegate = self.collectionViewModel;
    self.collectionView.dataSource = self.collectionViewModel;
    self.collectionView.backgroundColor = UIColor.clearColor;
    [self.contenView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accessView.mas_bottom).offset(HTNumB(16));
        make.left.mas_equalTo(HTNumB(16));
        make.right.mas_offset(-HTNumB(16));
        make.height.mas_equalTo(flow.itemSize.height);
    }];
}

- (void)ht_addContentView {
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.numberOfLines = 0;
    [self.contenView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset(HTNumB(10));
        make.left.mas_equalTo(HTNumB(16));
        make.right.mas_offset(-HTNumB(16));
    }];
    
    self.confirmView = [[UIView alloc] init];
    [self.contenView addSubview:self.confirmView];
    [self.confirmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(HTNumB(64));
        make.top.equalTo(self.priceLabel.mas_bottom).offset(HTNumB(20));
    }];
    
    self.confirmBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBTN.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#685034"].CGColor;
    self.confirmBTN.layer.cornerRadius = HTNumB(22);
    self.confirmBTN.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.confirmBTN setTitleColor:[UIColor ht_colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    [self.confirmBTN addTarget:self action:@selector(ht_payAction) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmView addSubview:self.confirmBTN];
    [self.confirmBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNumB(24));
        make.right.mas_equalTo(-HTNumB(24));
        make.height.mas_equalTo(HTNumB(44));
        make.centerY.mas_equalTo(0);
    }];
    CAGradientLayer *gradientLayer = [self.confirmBTN ht_setGradualChangingColors:@[[UIColor ht_colorWithHexString:@"#EDC391"],[UIColor ht_colorWithHexString:@"#FDDDB7"]]];
    gradientLayer.cornerRadius = HTNumB(22);

    self.restoreLabel = [[HTRestoreLabel alloc] init];
    [self.contenView addSubview:self.restoreLabel];
    [self.restoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.confirmView.mas_bottom).offset(HTNumB(20));
        make.left.right.equalTo(self.priceLabel);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor ht_colorWithHexString:@"#ECECEC" andAlpha:0.1];
    [self.contenView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.restoreLabel.mas_bottom).offset(HTNumB(24));
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.7);
    }];
    
    self.preBottomView = [[PreiumBottomView alloc] init];
    [self.contenView addSubview:self.preBottomView];
    [self.preBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(HTNumB(10));
        make.left.mas_equalTo(HTNumB(16));
        make.right.mas_offset(-HTNumB(16));
        make.bottom.mas_equalTo(0);
    }];
}

- (void)ht_getNewData {
    
    self.dataSource = [self.productManager lgjeropj_individualProductArray];
    self.var_familyData = [self.productManager lgjeropj_familyProductArray];
    NSArray *var_month = [self.dataSource filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(BaseCellModel *  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.var_fake == NO && [evaluatedObject.var_tag isEqualToString:STATIC_MONTH];
    }]];
    if ([var_month count] > 0) {
        self.monthModel = [var_month firstObject];
    }
    NSArray *var_familyMonth = [self.dataSource filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(BaseCellModel *  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return evaluatedObject.var_fake == NO && [evaluatedObject.var_tag isEqualToString:[NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_MONTH]];
    }]];
    if ([var_familyMonth count] > 0) {
        self.familyMonthModel = [var_familyMonth firstObject];
    }
    // 默认选中
    self.selectModel.var_select = NO;
    self.selectModel = self.dataSource.firstObject;
    self.selectModel.var_select = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        // 更新卡片价格
        [self ht_updatePrice];
    });
}

- (void)ht_updatePrice {
    
    if (!self.monthModel || !self.familyMonthModel) return;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"udf_freeMonth"]) {
        self.monthModel.data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]] = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Free"];
        self.monthModel.var_detail = [NSString stringWithFormat:LocalString(@"* Free for the 1 month, then %@/month after", nil),[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$4.99"]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        self.monthModel.var_kid = @"34";
        self.monthModel.var_tag = [NSString stringWithFormat:@"%@_%@", STATIC_Free, STATIC_MONTH];
        self.selectModel.var_select = NO;
        self.selectModel = self.dataSource.firstObject;
        self.selectModel.var_select = YES;
    } else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"udf_firstMonth"]) {
            self.monthModel.var_kid = @"2";
            self.monthModel.data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]] = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$4.99"];
            self.monthModel.var_detail = [NSString stringWithFormat:LocalString(@"*Auto-renewal for %@ per month.", nil),[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$4.99"]];
            self.monthModel.var_tag = STATIC_MONTH;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            self.selectModel.var_select = NO;
            self.selectModel = self.dataSource.firstObject;
            self.selectModel.var_select = YES;
        } else {
            __weak typeof(self) weakSelf = self;
            [IAPManager.sharedInstance ht_querryPurchaseWithArray:@[STATIC_MONTH, [NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_MONTH]] andBlock:^(NSArray * _Nonnull products) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (SKProduct *product in products) {
                        if ([product.productIdentifier isEqualToString:STATIC_MONTH]) {
                            NSString *var_price =  [IAPManager ht_getLocalIntroductoryPrice:product];
                            weakSelf.monthModel.data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]] = var_price;
                            weakSelf.monthModel.var_kid = @"9";
                            weakSelf.monthModel.var_detail = [NSString stringWithFormat:LocalString(@"%@ for the 1st month. Next recurring monthly renewal will be %@.", nil),var_price,[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$4.99"]];
                            weakSelf.monthModel.var_tag = STATIC_MONTH;
                        } else if ([product.productIdentifier isEqualToString:[NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_MONTH]]) {
                            NSString *var_price =  [IAPManager ht_getLocalIntroductoryPrice:product];
                            weakSelf.familyMonthModel.data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]] = var_price;
                            weakSelf.familyMonthModel.var_kid = @"9";
                            weakSelf.familyMonthModel.var_detail = [NSString stringWithFormat:LocalString(@"%@ for the 1st month. Next recurring monthly renewal will be %@.", nil),var_price,[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$7.99"]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakSelf.collectionView reloadData];
                            });
                        }
                    }
                    weakSelf.selectModel.var_select = NO;
                    if (weakSelf.var_family) {
                        weakSelf.selectModel = [weakSelf.var_familyData firstObject];
                    } else {
                        weakSelf.selectModel = [weakSelf.dataSource firstObject];
                    }
                    weakSelf.selectModel.var_select = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.collectionView reloadData];
                    });
                });
            }];
        }
    }
}

- (void)setSelectModel:(BaseCellModel *)selectModel {
    _selectModel = selectModel;
    NSString *cancel = LocalString(@"Cancel Anytime", nil);
    NSString *priceLabel = [LKFPrivateFunction lgjeropj_stringFillEmpty:selectModel.var_detail];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",priceLabel,cancel]];
    mstr.yy_lineSpacing = HTNumB(4);
    mstr.yy_color = [UIColor ht_colorWithHexString:@"#999999"];
    mstr.yy_font = [UIFont systemFontOfSize:12];
    [mstr yy_setFont:[UIFont boldSystemFontOfSize:12] range:[mstr.string rangeOfString:priceLabel]];
    [mstr yy_setColor:[UIColor ht_colorWithHexString:@"#3CDEF4"] range:[mstr.string rangeOfString:priceLabel]];
    self.priceLabel.attributedText = mstr;
    if (selectModel.var_fake) {
        [self.confirmBTN setTitle:[NSString stringWithFormat:@"%@ %@%@", LocalString(@"Pay", nil), [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$"], selectModel.var_pay] forState:UIControlStateNormal];
    } else {
        [self.confirmBTN setTitle:[NSString stringWithFormat:@"%@ %@", LocalString(@"Pay", nil), [LKFPrivateFunction lgjeropj_stringFillEmpty:selectModel.data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]]]] forState:UIControlStateNormal];
    }
}

- (void)ht_payAction {
    // 埋点
    [self ht_click_maidian];
    // 假卡片
    if (self.selectModel.var_fake) {
        NSInteger count = [[self.selectModel.var_params objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"c1"]] integerValue];
        HTToolSubscribeAlertView *view = [[HTToolSubscribeAlertView alloc] init];
        if (count < 30) {
            [view lgjeropj_show:self.selectModel.var_params source:self.var_family ? 4 : 3];
        } else if (count == 30) {
            [view lgjeropj_show:self.selectModel.var_params source:self.var_family ? 5 : 1];
        } else {
            [view lgjeropj_show:self.selectModel.var_params source:self.var_family ? 6 : 2];
        }
        return;
    }
    if ([self.var_familyData containsObject:self.selectModel] && !HTManage.sharedInstance.model2.var_uid) {
        // 强制登录
        HTWebViewController *vc = [[HTWebViewController alloc] init];
        vc.source = @"5";
        HTCommonConfiguration.lgjeropj_shared.BLOCK_windowPushToVCBlock(vc, self, YES);
        return;
    }
    if (!self.selectModel.var_tag) return;
    [self ht_payAction:self.selectModel.var_tag andBlock:nil];
}

- (void)lgjeropj_collectionView:(UICollectionView *)collectionView andDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectModel) {
        if (self.selectModel == self.dataSource[indexPath.row]) return;
        if (self.selectModel == self.var_familyData[indexPath.row]) return;
        self.selectModel.var_select = NO;
    }
    if (self.var_family) {
        self.selectModel = self.var_familyData[indexPath.row];
        self.selectModel.var_select = YES;
    } else {
        self.selectModel = self.dataSource[indexPath.row];
        self.selectModel.var_select = YES;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [collectionView reloadData];
    });
}

- (UICollectionViewCell *)lgjeropj_collectionView:(UICollectionView *)collectionView andCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PremiumCell *cell = [PremiumCell ht_cellWithCollectionView:collectionView forIndexPath:indexPath];
    if (self.var_family) {
        if (self.var_familyData.count > indexPath.row) {
            cell.model = self.var_familyData[indexPath.row];
        }
    } else {
        if (self.dataSource.count > indexPath.row) {
            cell.model = self.dataSource[indexPath.row];
        }
    }
    [cell ht_updateCellWithData];
    return cell;
}

- (NSInteger)lgjeropj_collectionView:(UICollectionView *)collectionView andNumberOfItemsInSection:(NSInteger)section {
    if (self.var_family) {
        return [self.var_familyData count];
    }
    return self.dataSource.count;
}

- (HTPremiumHeaderView *)headView {
    
    if (!_headView) {
        _headView = [[HTPremiumHeaderView alloc] init];
        __weak typeof(self) weakSelf = self;
        _headView.BLOCK_FamilyMemberBlock = ^{
            [weakSelf ht_familyMemberAction];
        };
    }
    return _headView;
}

- (void)ht_backAction{
    [super ht_backAction];
    NSLog(@"🐴vip页点关闭按钮");
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vip_cl"] params:@{
        [LKFPrivateFunction htMethodStringToInt:@"kid"]:@"8",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]:self.source?:@"1",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]:[self ht_getPointType],
        [LKFPrivateFunction htMethodStringToInt:@"userid"]:HTManage.sharedInstance.model2.var_uid?:@"",
    }];
}

- (ENUM_ControllerNaviType)ht_customNaviType{
    return ENUM_ControllerNaviTypeNormal;
}

// 埋点
- (void)ht_click_maidian {
    
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vip_cl"] params:@{
        [LKFPrivateFunction htMethodStringToInt:@"kid"]:self.selectModel.var_kid,
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]:self.source?:@"1",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]:[self ht_getPointType],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pay_type"]:(self.selectModel.var_fake ? @"3" : @"0"),
        [LKFPrivateFunction htMethodStringToInt:@"userid"]:HTManage.sharedInstance.model2.var_uid?:@"",
    }];
}

- (NSString*)ht_getPointType {
    return self.selectModel.var_activity ? @"2" : (self.var_family ? @"3" : @"1");
}

- (HTPremiumProductManager *)productManager {
    
    if (!_productManager) {
        _productManager = [[HTPremiumProductManager alloc] init];
    }
    return _productManager;
}

- (HTCollectionViewModel *)collectionViewModel {
    
    if (!_collectionViewModel) {
        _collectionViewModel = [[HTCollectionViewModel alloc] init];
        _collectionViewModel.delegate = self;
    }
    return _collectionViewModel;
}

@end
