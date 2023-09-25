//
//  HistoryVC.m
//  Movie
//
//  Created by wmz on 2023/2/13.
//

#import "HistoryVC.h"
#import "HistoryCell.h"
#import "HTTableViewModel.h"
#import "PostCommon_Config.h"
#import "HTMutilangManager.h"
#import "HTManage.h"

@interface HistoryVC () <HTTableViewModelDelegate>

@property (nonatomic,strong) UIButton *editBTN ;
@property (nonatomic,strong) UIView *editView ;
@property (nonatomic,strong) UIButton *selectAllBTN ;
@property (nonatomic,strong) UIButton *deleteBTN ;
@property (nonatomic,strong) HTTableViewModel *tableViewModel;

@end

@implementation HistoryVC

- (void)ht_setupViews{
    [super ht_setupViews];
    self.title = LocalString(@"History", nil);
    
    [self.view addSubview:self.tableView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(ht_editAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:LocalString(@"Edit", nil) forState:UIControlStateNormal];
    [button setTitle:LocalString(@"Cancel", nil) forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button sizeToFit];
    [button setTitleColor:[UIColor ht_colorWithHexString:@"#ECECEC"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.editBTN = button;
    [self.view addSubview:self.editView];
    self.selectAllBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectAllBTN addTarget:self action:@selector(ht_selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBTN setTitle:LocalString(@"Select All", nil) forState:UIControlStateNormal];
    [self.selectAllBTN setTitle:LocalString(@"Deselect All", nil) forState:UIControlStateSelected];
    [self.selectAllBTN setTitleColor:[UIColor ht_colorWithHexString:@"#ECECEC"] forState:UIControlStateNormal];
    [self.editView addSubview:self.selectAllBTN];
    
    self.deleteBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBTN addTarget:self action:@selector(ht_deleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBTN setTitle:LocalString(@"Delete", nil) forState:UIControlStateNormal];
    [self.deleteBTN setTitleColor:[UIColor ht_colorWithHexString:@"#ECECEC"] forState:UIControlStateNormal];
    [self.editView addSubview:self.deleteBTN];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(ht_noAction) name:@"NTFCTString_UpdateHistoryMovie" object:nil];
}

- (void)ht_noAction{
    [self ht_getWillData];
}

- (void)ht_updateViewConstraints {
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        if (self.editView.isHidden) {
            make.bottom.mas_equalTo(0);
        } else {
            make.bottom.equalTo(self.editView.mas_top);
        }
    }];
    
    [self.editView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.editView.isHidden) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(HTNum(60) + HTBottomSafeHeight);
        }
    }];
    
    [self.selectAllBTN mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.editView.isHidden) {
            make.left.top.mas_equalTo(0);
            make.width.equalTo(self.editView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(HTNum(60));
        }
    }];
    
    [self.deleteBTN mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.editView.isHidden) {
            make.right.top.mas_equalTo(0);
            make.width.equalTo(self.editView.mas_width).multipliedBy(0.5);
            make.height.mas_equalTo(HTNum(60));
        }
    }];
}

- (void)ht_checkEnable{
    BOOL hasData = NO;
    for (BaseCellModel *model in self.dataArray) {
        if (model.var_select) {
            hasData = YES;break;
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.deleteBTN setTitleColor:hasData?[UIColor ht_colorWithHexString:@"#EA4D3D"]:[UIColor ht_colorWithHexString:@"#828386"] forState:UIControlStateNormal];
        self.deleteBTN.enabled = hasData;
    });
}

- (void)ht_selectAllAction{
    self.selectAllBTN.selected = !self.selectAllBTN.isSelected;
    for (BaseCellModel *model in self.dataArray) {
        model.var_select = self.selectAllBTN.isSelected;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    [self ht_checkEnable];
}

- (void)ht_editAction{
    self.edit = !self.edit;
}

- (void)setEdit:(BOOL)edit{
    _edit = edit;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.editBTN.selected = edit;
        [self.editBTN sizeToFit];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editBTN];
        self.selectAllBTN.selected = NO;
        self.editView.hidden = !edit;
        for (BaseCellModel *model in self.dataArray) {
            model.var_show = edit;
            model.var_select = NO;
        }
        [self.tableView reloadData];
        [self.view setNeedsUpdateConstraints];
        [self ht_checkEnable];
    });
}

- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)ht_getWillData{
    self.dataArray = [NSMutableArray arrayWithArray:[HTManage.sharedInstance ht_getHistoryDatasource]];
    [self.tableView ht_reloadData:NO];
}

- (void)ht_deleteAction{
    for (MovieModel *var_movieModel in self.dataArray) {
        if (var_movieModel.var_select && [HTManage.sharedInstance ht_checkHistory:var_movieModel.var_id]) {
            [HTManage.sharedInstance ht_saveHistoryModel:var_movieModel andDele:YES];
        }
    }
    [self ht_getWillData];
    self.edit = !self.edit;
}

- (NSInteger)lgjeropj_tableView:(UITableView *)tableView andNumberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)lgjeropj_tableView:(UITableView *)tableView andCellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell *cell = [HistoryCell ht_cellWithTableView:tableView];
    if (self.dataArray.count > indexPath.row) {
        cell.model = self.dataArray[indexPath.row];
    }
    cell.source = [self source];
    [cell ht_updateCellWithData];
    __weak typeof(self) weakSelf = self;
    cell.block = ^(id data) {
        [weakSelf ht_checkEnable];
    };
    return cell;
}

- (UIView *)editView {
    
    if (!_editView) {
        _editView = [[UIView alloc] init];
        _editView.hidden = YES;
        _editView.backgroundColor = [UIColor ht_colorWithHexString:@"#1A1C21"];
    }
    return _editView;
}

- (NSString *)source {
    return @"6";
}

- (BaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self.tableViewModel;
        _tableView.dataSource = self.tableViewModel;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, HTBottomSafeHeight, 0);
    }
    return _tableView;
}

- (HTTableViewModel *)tableViewModel {
    
    if (!_tableViewModel) {
        _tableViewModel = [[HTTableViewModel alloc] init];
        _tableViewModel.delegate = self;
    }
    return _tableViewModel;
}

- (NSMutableArray *)dataArray {

    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
