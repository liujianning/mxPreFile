//
//  HTFreeMonthAlert.m
//  Movie
//
//  Created by wmz on 2023/4/26.
//

#import "HTFreeMonthAlert.h"
#import "UIView+UIViewController.h"
#import "YYText.h"

@interface HTFreeMonthAlert ()

@end

@implementation HTFreeMonthAlert

- (void)ht_setupViews{
    
    NSLog(@"🐴 导量会员赠送弹窗展示");
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vipguide_sh"] params:@{[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]:@"1"}];
    
    self.view.backgroundColor = [UIColor ht_colorWithHexString:@"#000000" andAlpha:0.7];
    UIView *var_centerView = [[UIView alloc] init];
    var_centerView.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#F6F6F6"].CGColor;
    var_centerView.layer.cornerRadius = HTNum(12);
    [self.view addSubview:var_centerView];
    [var_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(HTNum(53));
        make.right.mas_equalTo(-HTNum(53));
    }];
    
    UILabel *more = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:LocalString(@"Give Up Discount", nil)];
    string.yy_alignment = NSTextAlignmentCenter;
    string.yy_font = [UIFont systemFontOfSize:14];
    string.yy_color = [UIColor ht_colorWithHexString:@"#666666"];
    string.yy_underlineStyle = NSUnderlineStyleSingle;
    string.yy_underlineColor  = [UIColor ht_colorWithHexString:@"#666666"];
    more.attributedText = string;
    [var_centerView addSubview:more];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HTNum(20));
        make.centerX.mas_equalTo(0);
    }];
    more.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_backAction)];
    [more addGestureRecognizer:tapGesture];
    
    UIButton *var_shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [var_shareButton addTarget:self action:@selector(ht_shareAction) forControlEvents:UIControlEventTouchUpInside];
    [var_shareButton setTitle:LocalString(@"Receive", nil) forState:UIControlStateNormal];
    var_shareButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_shareButton setTitleColor:[UIColor ht_colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    var_shareButton.layer.cornerRadius = HTNum(12);
    var_shareButton.layer.masksToBounds = YES;
    [var_centerView addSubview:var_shareButton];
    [var_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(more.mas_top).offset(-HTNum(16));
        make.left.mas_equalTo(HTNum(28));
        make.right.mas_equalTo(-HTNum(28));
        make.height.mas_equalTo(HTNum(44));
        make.top.mas_equalTo(HTNum(102));
    }];
    [var_shareButton ht_setGradualChangingColors:@[[UIColor ht_colorWithHexString:@"#5a64ea"], [UIColor ht_colorWithHexString:@"#476cdb"], [UIColor ht_colorWithHexString:@"#3f6fd3"], [UIColor ht_colorWithHexString:@"#3872ca"], [UIColor ht_colorWithHexString:@"#357abc"]]];
    
    UIImageView *topView = [[UIImageView alloc] init];
    [topView ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:246] andComplete:^(UIImage * _Nullable image) {
        topView.layer.contents = (id)image.CGImage;
        topView.layer.contentsGravity = kCAGravityResizeAspectFill;
        topView.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#222222"].CGColor;
        topView.layer.cornerRadius = HTNum(6);
    }];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(var_centerView.mas_left).offset(HTNum(25));
        make.right.equalTo(var_centerView.mas_right).offset(-HTNum(25));
        make.top.equalTo(var_centerView.mas_top).offset(-HTNum(17));
    }];

    UILabel *label = [[UILabel alloc] init];
    label.text = @"1";
    label.textColor = UIColor.whiteColor;
    label.font = [UIFont boldSystemFontOfSize:40];
    [topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(HTNum(10));
        make.height.mas_equalTo(HTNum(47));
    }];

    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.text = LocalString(@"Month Free Premium For You", nil);
    detailLabel.numberOfLines = 0;
    detailLabel.textColor = UIColor.whiteColor;
    detailLabel.font = [UIFont systemFontOfSize:12];
    [topView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNum(10));
        make.right.mas_equalTo(-HTNum(57));
        make.bottom.mas_equalTo(-HTNum(10));
        make.top.equalTo(label.mas_bottom);
    }];

    UIImageView *iconIV = [[UIImageView alloc] init];
    [iconIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:247]];
    [self.view addSubview:iconIV];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView);
        make.size.mas_equalTo(CGSizeMake(86, 86));
        make.top.equalTo(topView.mas_top).offset(-HTNum(31));
    }];
}

- (void)ht_shareAction{
    NSLog(@"🐴 导量会员确定点击");
    [self ht_payAction:[NSString stringWithFormat:@"%@_%@", STATIC_Free, STATIC_MONTH] andBlock:^(BOOL var_success) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vipguide_cl"] params:@{[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]:@"1",[LKFPrivateFunction htMethodStringToInt:@"kid"]:@"1"}];
}

- (void)ht_backAction{
    NSLog(@"🐴 导量会员取消点击");
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"vipguide_cl"] params:@{[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]:@"1",[LKFPrivateFunction htMethodStringToInt:@"kid"]:@"2"}];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
