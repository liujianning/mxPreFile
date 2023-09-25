//
//  HTFamilyQuestionViewController.m
//  Merriciya
//
//  Created by 昊天 on 2023/5/30.
//

#import "HTFamilyQuestionViewController.h"
#import "HTTableViewModel.h"

@interface HTFamilyQuestionViewController ()<HTTableViewModelDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *var_tableView;
@property (nonatomic, strong) HTTableViewModel *tableViewModel;

@end

@implementation HTFamilyQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"FAQ"];
    [self ht_loadData];
    [self ht_setupUI];
}
- (void)ht_loadData {
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:LocalString(@"What is a family package?", nil)];
    [self.dataArray addObject:[NSString stringWithFormat:LocalString(@"The family plan packs up to %ld independent accounts into one payment, and the accounts are completely independent.\nThe main family account can invite other members at any time, and members can log out at any time.", nil), self.var_total]];
    [self.dataArray addObject:LocalString(@"Upgrade to family package?", nil)];
    [self.dataArray addObject:LocalString(@"If you have already purchased a single plan, you can upgrade to a family plan at any time.\nThe family plan needs to be paid , and the old subscription balance will be refunded to you in proportion.", nil)];
}
- (void)ht_setupUI {
    self.var_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.var_tableView];
    self.var_tableView.delegate = self.tableViewModel;
    self.var_tableView.dataSource = self.tableViewModel;
    self.var_tableView.backgroundColor = [UIColor clearColor];
    self.var_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.var_tableView.rowHeight = UITableViewAutomaticDimension;
    self.var_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.var_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELLString_FamilyQuestionTableViewCell"];
}
#pragma mark - table delegate
- (NSInteger)lgjeropj_numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)lgjeropj_tableView:(UITableView *)tableView andNumberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)lgjeropj_tableView:(UITableView *)tableView andCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLString_FamilyQuestionTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    if (self.dataArray.count > 0) {
        cell.textLabel.text = self.dataArray[indexPath.section*2 + indexPath.row];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if (indexPath.row == 0) {
            cell.textLabel.textColor = [UIColor whiteColor];
        }else {
            cell.textLabel.textColor = [UIColor grayColor];
        }
    }
    
    return cell;
}

- (HTTableViewModel *)tableViewModel {
    
    if (!_tableViewModel) {
        _tableViewModel = [[HTTableViewModel alloc] init];
        _tableViewModel.delegate = self;
    }
    return _tableViewModel;
}

@end
