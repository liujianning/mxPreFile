//
//  HTFamilyViewController.m
//  Merriciya
//
//  Created by 昊天 on 2023/5/29.
//

#import "HTFamilyViewController.h"
#import "HTFamilyTableViewCell.h"
#import "HTFamilyMemberViewController.h"
#import "HTFamilyQuestionViewController.h"
#import "HTFamilyGroupManager.h"
#import "HTFamilySectionView.h"
#import "HTFamilyBottomView.h"
#import "HTFamilyTableViewCell.h"
#import "HTTableViewModel.h"
#import "SVPullToRefresh.h"
#import "UIButton+ImagePosition.h"
#import "HTCommonConfiguration.h"
#import "NSObject+Toast.h"

@interface HTFamilyViewController ()<HTTableViewModelDelegate, HTFamilyTableCellClickDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *var_tableView;
@property (nonatomic, strong) HTFamilyBottomView *var_bottomView;
@property (nonatomic, assign) NSInteger var_remainNum;
@property (nonatomic, assign) NSInteger var_currentNum;
@property (nonatomic, strong) HTTableViewModel *tableViewModel;

@end

@implementation HTFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = LocalString(@"Family Account", nil);
    [self ht_setupUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.var_tableView triggerPullToRefresh];
}
- (void)ht_setupUI {
    
    self.var_bottomView = [[HTFamilyBottomView alloc] init];
    [self.var_bottomView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_familyQuestionAction:)]];
    [self.view addSubview:self.var_bottomView];
    [self.var_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    self.var_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.var_tableView];
    [self.var_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.var_bottomView.mas_top).mas_offset(0);
    }];
    self.var_tableView.delegate = self.tableViewModel;
    self.var_tableView.dataSource = self.tableViewModel;
    self.var_tableView.backgroundColor = [UIColor clearColor];
    self.var_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.var_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.var_tableView registerClass:[HTFamilyTableViewCell class] forCellReuseIdentifier:@"CELLString_HTFamilyTableViewCell"];
    [self ht_configRefreshUI];
}
- (void)ht_setupNavigation {
    UserModel *var_user = HTManage.sharedInstance.model2;
    PayModel *var_payModel = HTManage.sharedInstance.model6;
    if (var_user.var_master.intValue == 1 && var_payModel.var_server.var_val2.intValue == 0) {
        UIButton *var_dissolveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [var_dissolveButton addTarget:self action:@selector(ht_dissolveFamilyGroupAction:) forControlEvents:UIControlEventTouchUpInside];
        [var_dissolveButton ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:26] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:var_dissolveButton];
    }else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (UIView *)ht_setupSectionView:(NSInteger)type {
    
    HTFamilySectionView *view = [[HTFamilySectionView alloc] initWithType:type count:self.var_remainNum];
    view.frame = CGRectMake(0, 0, HTWidth, 100);
    __weak typeof(self) weakSelf = self;
    view.BLOCK_buttonActionBlock = ^(NSInteger type) {
        if (type == 0) {
            [weakSelf ht_addMemberAction];
        } else if (type == 1) {
            [weakSelf ht_quitFamilyAction];
        } else {
            [weakSelf ht_buyFamilyAction];
        }
    };
    return view;
}

#pragma mark - table delegate
- (NSInteger)lgjeropj_numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)lgjeropj_tableView:(UITableView *)tableView andNumberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (UITableViewCell *)lgjeropj_tableView:(UITableView *)tableView andCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTFamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLString_HTFamilyTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (self.dataArray.count > indexPath.row) {
        cell.delegate = self;
        ZQFamilyAccountModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [cell lgjeropj_updateCellWithData:model andIndex:indexPath.row];
    }
    
    return cell;
}
- (void)ht_familyMemberCellClick:(NSInteger)index {
    BOOL var_master = [self ht_judgeUserIsMaster];
    if (var_master) {
        ZQFamilyAccountModel *model = [self.dataArray objectAtIndex:index];
        if (model.var_master.intValue != 1) {
            // 主账号删除子成员
            [self ht_deleteFamilyMember:model];
        }
    }
}
- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForFooterInSection:(NSInteger)section {
    if (self.dataArray.count > 0) {
        BOOL var_master = [self ht_judgeUserIsMaster];
        if (var_master) {
            if (![HTManage.sharedInstance ht_checkSub]) {
                return 100;
            } else if (self.var_remainNum > 0) {
                return 100;
            }
        }else {
            return 100;
        }
    }
    
    return CGFLOAT_MIN;
}
- (UIView *)lgjeropj_tableView:(UITableView *)tableView andViewForFooterInSection:(NSInteger)section {
    UIView *var_sectionView = [[UIView alloc] init];
    
    if (self.dataArray.count > 0) {
        BOOL var_master = [self ht_judgeUserIsMaster];
        if (var_master) {
            if (![HTManage.sharedInstance ht_checkSub]) {
                var_sectionView = [self ht_setupSectionView:2];
            } else if (self.var_remainNum > 0) {
                var_sectionView = [self ht_setupSectionView:0];
            }
        }else {
            var_sectionView = [self ht_setupSectionView:1];
        }
    }
    
    return var_sectionView;
}
- (BOOL)ht_judgeUserIsMaster {
    BOOL var_master = NO;
    UserModel *loginUser = HTManage.sharedInstance.model2;
    for (ZQFamilyAccountModel *model in self.dataArray) {
        if (model.var_uid.intValue == loginUser.var_uid.intValue && model.var_master.intValue == 1) {
            return YES;
        }
    }
    return var_master;
}
#pragma mark - Action
- (void)ht_addMemberAction {
    HTFamilyMemberViewController *controller = [[HTFamilyMemberViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)ht_quitFamilyAction {
    ZQFamilyAccountModel *userModel = nil;
    UserModel *loginUser = HTManage.sharedInstance.model2;
    for (ZQFamilyAccountModel *model in self.dataArray) {
        if (model.var_uid.intValue == loginUser.var_uid.intValue) {
            userModel = model;
            break;
        }
    }
    if (userModel) {
        [self ht_deleteFamilyMember:userModel];
    }
}
- (void)ht_buyFamilyAction {
    HTCommonConfiguration.lgjeropj_shared.BLOCK_toPayBlock(nil, @"19");
}
- (void)ht_familyQuestionAction:(UITapGestureRecognizer *)sender {
    HTFamilyQuestionViewController *controller = [[HTFamilyQuestionViewController alloc] init];
    controller.var_total = self.var_currentNum + self.var_remainNum;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)ht_deleteFamilyMember:(ZQFamilyAccountModel *)model
{
    __weak typeof(self) weakSelf = self;
    [HTFamilyGroupManager ht_deleteFamilyMember:model andComplete:^(id  _Nonnull data) {
        if ([[data objectForKey:@"status"] integerValue] == 200) {
            [weakSelf.dataArray removeObject:model];
            weakSelf.var_remainNum = [[data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"remain"]] integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.var_tableView reloadData];
            });
        }
        // 订阅验证
        [[HTManage sharedInstance] ht_updateVipWithBlock:nil source:@"4"];
        if ([data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]] && [[data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]] isKindOfClass:[NSString class]] && [[data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]] length] > 0) {
            NSString *var_msg = [data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]];
            [weakSelf lgjeropj_showHint:var_msg];
        }
    }];
}

- (void)ht_dissolveFamilyGroupAction:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [HTFamilyGroupManager ht_dissolveFamilyGroupAction:^(id  _Nonnull data) {
        if ([[data objectForKey:@"status"] integerValue] == 200) {
            UserModel *loginUser = HTManage.sharedInstance.model2;
            loginUser.var_fid = @"0";
            loginUser.var_master = @"0";
            HTManage.sharedInstance.model2 = loginUser;
            // 订阅验证
            [[HTManage sharedInstance] ht_updateVipWithBlock:nil source:@"4"];
            [weakSelf lgjeropj_showHint:LocalString(@"You have left the family, you can continue to purchase an individual/family plan", nil)];
            [weakSelf ht_backAction];
        }
    }];
}

#pragma mark - data
- (void)ht_configRefreshUI {
    __weak typeof(self) weakSelf = self;
    [self.var_tableView addPullToRefreshWithActionHandler:^{
        [weakSelf ht_loadData];
    }];
}

- (void)ht_loadData {
    __weak typeof(self) weakSelf = self;
    [HTFamilyGroupManager lgjeropj_requestFamilyInfo:^(id  _Nonnull data) {
        if (data) {
            if ([[data objectForKey:@"status"] integerValue] == 200) {
                [weakSelf.dataArray removeAllObjects];
                NSArray *dataArr = data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data"]];
                if (dataArr.count > 0) {
                    NSArray *tmpArr = [NSArray yy_modelArrayWithClass:ZQFamilyAccountModel.class json:dataArr];
                    [weakSelf.dataArray addObjectsFromArray:tmpArr];
                    weakSelf.var_currentNum = [[data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"cur_cnts"]] integerValue];
                    weakSelf.var_remainNum = [[data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"remain"]] integerValue];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.var_tableView reloadData];
            });
            [weakSelf.var_tableView.pullToRefreshView stopAnimating];
        } else {
            [weakSelf.var_tableView.pullToRefreshView stopAnimating];
        }
    }];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (HTTableViewModel *)tableViewModel {
    
    if (!_tableViewModel) {
        _tableViewModel = [[HTTableViewModel alloc] init];
        _tableViewModel.delegate = self;
    }
    return _tableViewModel;
}

@end
