//
//  MeVC.m
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import "MeVC.h"
#import "FeedbackVC.h"
#import "HistoryVC.h"
#import "CollectionVC.h"
#import "HTWebViewController.h"
#import "BaseTableViewCell.h"
#import "HTTableViewModel.h"
#import "BaseSectionModel.h"
#import "HTManage.h"
#import "HTCommonConfiguration.h"

@interface MeVC ()<HTTableViewModelDelegate>

@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,strong) BaseCellModel *historyModel;
@property (nonatomic,strong) NSMutableArray <BaseSectionModel*>*dataSource;
@property (nonatomic, strong) HTTableViewModel *tableViewModel;

@end

@implementation MeVC

- (void)ht_setupViews{
    [self.view addSubview:self.tableView];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(ht_logoutAction:) name:@"NTFCTString_UserLogout" object:nil];
}

- (void)ht_logoutAction:(NSNotification*)no{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)ht_updateViewConstraints {
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ht_purchase_verify) name:@"NTFCTString_PurchaseVerifyCompletion" object:nil];
}

- (void)ht_purchase_verify {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)ht_getWillData {
    self.historyModel.dataArray = [NSMutableArray arrayWithArray:[HTManage.sharedInstance ht_getHistoryDatasource]];
    self.historyModel.var_hideStatus = ![LKFPrivateFunction lgjeropj_isNotEmptyArray:self.historyModel.dataArray];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)ht_getNewData{
    self.dataSource = [[NSMutableArray alloc] init];
    BaseSectionModel *sectionModel = [[BaseSectionModel alloc] init];
    BaseCellModel *model = [BaseCellModel ht_nomal:@"MeHeadCell"];
    model.var_tag = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"head"];
    [sectionModel.var_rows addObject:model];
    [self.dataSource addObject:sectionModel];
    
    sectionModel = [[BaseSectionModel alloc] init];
    model = [BaseCellModel ht_nomal:@"MeNormalCell"];
    model.var_title = LocalString(@"History", nil);
    model.image = [LKFPrivateFunction htMethodImageUrlFromNumber:101].absoluteString;
    model.var_tag = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"history"];
    [sectionModel.var_rows addObject:model];
    model = [BaseCellModel ht_nomal:@"MeHistoryCell"];
    self.historyModel = model;
    
    [sectionModel.var_rows addObject:model];
    [self.dataSource addObject:sectionModel];
    
    sectionModel = [[BaseSectionModel alloc] init];
    model = [BaseCellModel ht_nomal:@"MeNormalCell"];
    model.var_title = LocalString(@"Watch Later", nil);
    model.image = [LKFPrivateFunction htMethodImageUrlFromNumber:170].absoluteString;
    model.var_tag = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"collect"];
    [sectionModel.var_rows addObject:model];
    
    model = [BaseCellModel ht_nomal:@"MeNormalCell"];
    model.var_title = LocalString(@"Friend Referral", nil);
    model.image = [LKFPrivateFunction htMethodImageUrlFromNumber:105].absoluteString;
    model.var_tag = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"share"];
    [sectionModel.var_rows addObject:model];
    
    model = [BaseCellModel ht_nomal:@"MeNormalCell"];
    model.var_title = LocalString(@"Feedback", nil);
    model.image = [LKFPrivateFunction htMethodImageUrlFromNumber:100].absoluteString;
    model.var_tag = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Feedback"];
    [sectionModel.var_rows addObject:model];
    
    [self.dataSource addObject:sectionModel];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)lgjeropj_tableView:(UITableView *)tableView andCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellModel *model;
    if (self.dataSource.count > indexPath.section) {
        if (self.dataSource[indexPath.section].var_rows.count > indexPath.row) {
            model = self.dataSource[indexPath.section].var_rows[indexPath.row];
        }
    }
    BaseTableViewCell *cell = [NSClassFromString(model.var_className) ht_cellWithTableView:tableView];
    cell.model = model;
    [cell ht_updateCellWithData];
    return cell;
}

- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseCellModel *model = self.dataSource[indexPath.section].var_rows[indexPath.row];
    if (model.var_hideStatus) {
        return CGFLOAT_MIN;
    }
    return UITableViewAutomaticDimension;
}

- (void)lgjeropj_tableView:(UITableView *)tableView andSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseSectionModel *sectionModel = self.dataSource[indexPath.section];
    BaseCellModel *model = sectionModel.var_rows[indexPath.row];
    if (sectionModel.tag && [sectionModel.tag isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"history"]] && indexPath.row == 0) {
        HTCommonConfiguration.lgjeropj_shared.BLOCK_windowPushToVCBlock([[HistoryVC alloc] init], self, YES);
    } else {
        if (model.var_tag) {
            if ([model.var_tag isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Feedback"]]) {
                HTCommonConfiguration.lgjeropj_shared.BLOCK_windowPushToVCBlock([[FeedbackVC alloc] init], self, YES);
            }
            else if ([model.var_tag isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"head"]]) {
                HTWebViewController *vc = [[HTWebViewController alloc] init];
                vc.source = @"14";
                HTCommonConfiguration.lgjeropj_shared.BLOCK_windowPushToVCBlock(vc, self, YES);
            }
            else if ([model.var_tag isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"share"]]) {
                [self ht_clickShare];
            }
            else if ([model.var_tag isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"collect"]]) {
                HTCommonConfiguration.lgjeropj_shared.BLOCK_windowPushToVCBlock([[CollectionVC alloc] init], self, YES);
            }
            else if ([model.var_tag isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"history"]]) {
                HTCommonConfiguration.lgjeropj_shared.BLOCK_windowPushToVCBlock([[HistoryVC alloc] init], self, YES);
            }
        }
    }
}

- (NSInteger)lgjeropj_tableView:(UITableView *)tableView andNumberOfRowsInSection:(NSInteger)section{
    return self.dataSource[section].var_rows.count;
}

- (NSInteger)lgjeropj_numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (ENUM_ControllerNaviType)ht_customNaviType{
    return ENUM_ControllerNaviTypeHide;
}

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self.tableViewModel;
        _tableView.dataSource = self.tableViewModel;
        _tableView.bounces = NO;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    }
    return _tableView;
}

-(void)ht_clickShare{
    [HTManage ht_shareTitle:[LKFPrivateFunction lgjeropj_stringFillEmpty:HTManage.sharedInstance.model3.var_appm_text] andURL:[LKFPrivateFunction lgjeropj_stringFillEmpty:HTManage.sharedInstance.model3.var_appm_link] andImage:nil];
}

- (HTTableViewModel *)tableViewModel {
    
    if (!_tableViewModel) {
        _tableViewModel = [[HTTableViewModel alloc] init];
        _tableViewModel.delegate = self;
    }
    return _tableViewModel;
}

@end
