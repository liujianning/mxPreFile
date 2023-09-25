//
//  FeedbackVC.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "FeedbackVC.h"
#import "BaseTextView.h"
#import "HTMutilangManager.h"
#import "BSNetAPIClient.h"
#import "LKFPrivateFunction.h"
#import "NSObject+Toast.h"

@interface FeedbackVC ()
@property (nonatomic,strong) BaseTextView *textView;
@property (nonatomic,strong) BaseTextView *etextView;
@property (nonatomic,strong) UIButton *confirmBTN;
@end

@implementation FeedbackVC

- (void)ht_setupViews
{
    self.title = LocalString(@"Feedback", nil);
    [self ht_scrollView];
    BaseTextView *textView = [[BaseTextView alloc] init];
    __weak typeof(self) weakSelf = self;
    textView.var_textChangeBlock = ^(UIView * _Nonnull view) {
        [weakSelf ht_checkEnable];
    };
    textView.title = LocalString(@"Question/Feedback", nil);
    textView.placeHolder = LocalString(@"Please describe your problems or suggestions here.", nil);
    [self.contenView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HTNum(20));
        make.left.mas_equalTo(HTNum(10));
        make.right.mas_equalTo(-HTNum(10));
    }];
    self.textView = textView;
    
    BaseTextView *etextView = [[BaseTextView alloc] init];
    etextView.var_textChangeBlock = ^(UIView * _Nonnull view) {
        [weakSelf ht_checkEnable];
    };
    etextView.title = LocalString(@"Contact Details", nil);
    etextView.placeHolder = LocalString(@"Please leave your e-mail address for us to better serve you", nil);
    [self.contenView addSubview:etextView];
    [etextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(HTNum(20));
        make.left.mas_equalTo(HTNum(10));
        make.right.mas_equalTo(-HTNum(10));
    }];
    self.etextView = etextView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#B82450"].CGColor;
    btn.layer.cornerRadius = HTNum(6);
    [btn setTitle:LocalString(@"Submit", nil) forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ht_confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contenView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(etextView.mas_bottom).offset(HTNum(40));
        make.left.mas_equalTo(HTNum(10));
        make.right.mas_equalTo(-HTNum(10));
        make.height.mas_equalTo(HTNum(40));
        make.bottom.mas_lessThanOrEqualTo(0);
    }];
    self.confirmBTN = btn;
    [self ht_checkEnable];
}

- (void)ht_confirmAction{
    
    [self lgjeropj_showLoadingForSuperView:self.view];
    [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/5/"] andParams:@{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]:self.textView.textView.text ?: @"",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mail"]:self.etextView.textView.text ?: @"",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"vid"]:self.var_vid ?: @"0",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"sid"]:self.var_sid ?: @"0",
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"eid"]:self.var_eid ?: @"0",
    } andViewController:self andBlock:^(id  _Nullable data, BOOL result) {
        [self lgjeropj_hideLoadingForSuperView:self.view];
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
            [self lgjeropj_showHint:LocalString(@"Submit Success", nil)];
        } else {
            if (data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"errorStr"]]) {
                [self lgjeropj_showHint:data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"errorStr"]] superView:self.contenView];
            }
        }
    }];
}

- (void)ht_checkEnable{
    BOOL enable = NO;
    if ([LKFPrivateFunction lgjeropj_isNotEmpty:self.textView.textView.text] && [LKFPrivateFunction lgjeropj_isNotEmpty:self.etextView.textView.text]) {
        enable = YES;
    }
    self.confirmBTN.layer.backgroundColor = enable?[UIColor ht_colorWithHexString:@"#B82450"].CGColor:[[UIColor ht_colorWithHexString:@"#B82450"] colorWithAlphaComponent:0.5].CGColor;
    self.confirmBTN.enabled = enable;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
