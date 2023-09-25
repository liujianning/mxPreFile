//
//  HTFamilyMemberViewController.m
//  Merriciya
//
//  Created by 昊天 on 2023/5/29.
//

#import "HTFamilyMemberViewController.h"
#import "HTFamilyMemberTableViewCell.h"
#import "HTFamilyGroupManager.h"
#import "HTTableViewModel.h"
#import "HTTextFieldModel.h"
#import "NSObject+Toast.h"

@interface HTFamilyMemberViewController ()<HTTextFieldModelDelegate, HTTableViewModelDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *var_tableView;
@property (nonatomic, copy) NSString *var_inputText;
@property (nonatomic, strong) HTTableViewModel *tableViewModel;
@property (nonatomic, strong) HTTextFieldModel *textFieldModel;

@end

@implementation HTFamilyMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = LocalString(@"Add Member", nil);
    [self ht_loadData];
    [self ht_setupUI];
}
- (void)ht_loadData {
    self.dataArray = [NSMutableArray arrayWithCapacity:5];
    [self.dataArray addObject:LocalString(@"Email, phone or account ID", nil)];
    [self.dataArray addObject:LocalString(@"Phone number example: +19097165187", nil)];
    [self.dataArray addObject:LocalString(@"*You can only add users registered in this app\n*You can add up to four additional family members\n*You cannot add users with family plan accounts", nil)];
}
- (void)ht_setupUI {
    self.var_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.var_tableView];
    self.var_tableView.delegate = self.tableViewModel;
    self.var_tableView.dataSource = self.tableViewModel;
    self.var_tableView.backgroundColor = [UIColor clearColor];
    self.var_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.var_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.var_tableView registerClass:[HTFamilyMemberTableViewCell class] forCellReuseIdentifier:@"CELLString_FamilyMemberTableViewCell"];
}
#pragma mark - table delegate
- (NSInteger)lgjeropj_numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)lgjeropj_tableView:(UITableView *)tableView andNumberOfRowsInSection:(NSInteger)section {
    return 2 - section;
}
- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 30;
        }
    }
    return 130;
}
- (UITableViewCell *)lgjeropj_tableView:(UITableView *)tableView andCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTFamilyMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLString_FamilyMemberTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    if (self.dataArray.count > 0) {
        NSInteger index = (indexPath.section == 0) ?indexPath.row : 2;
        if (self.dataArray.count > index) {
            [cell ht_updateInfo:self.dataArray[index] andIndex:index];
        }
        if (index == 0) {
            cell.var_textField.delegate = self.textFieldModel;
            [cell.var_questionButton addTarget:self action:@selector(ht_showHowAddMember) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return cell;
}
-(CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 150;
    }
    return 60;
}
- (UIView *)lgjeropj_tableView:(UITableView *)tableView andViewForHeaderInSection:(NSInteger)section {
    UIView *var_sectionView = [[UIView alloc] init];
    
    if (section == 1) {
        UIButton *var_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [var_sectionView addSubview:var_button];
        [var_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(var_sectionView);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(HTWidth *0.75);
        }];
        var_button.backgroundColor = [UIColor whiteColor];
        [var_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [var_button setTitle:@"Add" forState:UIControlStateNormal];
        var_button.layer.masksToBounds = YES;
        var_button.layer.cornerRadius = 10.0;
        [var_button addTarget:self action:@selector(ht_addMemberAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return var_sectionView;
}

- (void)ht_addMemberAction
{
    [self.view endEditing:YES];
    if (self.var_inputText.length == 0) {
        [self lgjeropj_showHint:LocalString(@"Email, phone or account ID", nil) superView:self.view];
    } else {
        __weak typeof(self) weakSelf = self;
        [HTFamilyGroupManager lgjeropj_addMemberRequest:self.var_inputText andComplete:^{
            weakSelf.var_inputText = @"";
        }];
    }
}

- (void)ht_showHowAddMember
{
    [HTFamilyGroupManager ht_showHowAddMember];
}

- (void)lgjeropj_textFieldDidEndEditing:(UITextField *)textField {
    self.var_inputText = textField.text;
}

- (BOOL)lgjeropj_textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (HTTableViewModel *)tableViewModel {
    
    if (!_tableViewModel) {
        _tableViewModel = [[HTTableViewModel alloc] init];
        _tableViewModel.delegate = self;
    }
    return _tableViewModel;
}

- (HTTextFieldModel *)textFieldModel {
    
    if (!_textFieldModel) {
        _textFieldModel = [[HTTextFieldModel alloc] init];
        _textFieldModel.delegate = self;
    }
    return _textFieldModel;
}

@end
