//
//  HTSubscripBootBottomView.m
 
//
//  Created by 李雪健 on 2023/7/12.
//

#import "HTSubscripBootBottomView.h"
#import "UIView+UIViewController.h"
#import "YYText.h"

@implementation HTSubscripBootBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews
{
    self.var_priceBTN = [[UIButton alloc] init];
    self.var_priceBTN.clipsToBounds = YES;
    self.var_priceBTN.layer.masksToBounds = YES;
    self.var_priceBTN.layer.cornerRadius = HTNum(24);
    [self.var_priceBTN addTarget:self action:@selector(ht_payAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.var_priceBTN];
    [self.var_priceBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(HTWidth-HTNum(48));
        make.height.mas_equalTo(HTNum(48));
    }];
    CAGradientLayer *gradientLayer = [self.var_priceBTN ht_setGradualChangingColors:@[[UIColor ht_colorWithHexString:@"#EDC391"],[UIColor ht_colorWithHexString:@"#FDDDB7"]]];
    gradientLayer.cornerRadius =  HTNum(24);

    UIButton *button = [[UIButton alloc] init];
    [button setTitle:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"-41%"] forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:11];
    [self.var_priceBTN addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(HTNum(72), HTNum(24)));
    }];
    CAGradientLayer *buttonLayer =  [button ht_setGradualChangingColors:@[[UIColor ht_colorWithHexString:@"#FF1C1C"],[UIColor ht_colorWithHexString:@"#FF6D1C"]]];
    buttonLayer.cornerRadius =  HTNum(16);
    buttonLayer.maskedCorners = kCALayerMaxXMaxYCorner;
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = LocalString(@"you can cancel anytime", nil);
    label3.textAlignment = NSTextAlignmentCenter;
    label3.numberOfLines = 0;
    label3.textColor = [UIColor ht_colorWithHexString:@"#999999"];
    label3.font = [UIFont systemFontOfSize:12];
    [self addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.var_priceBTN.mas_bottom).offset(HTNum(10));
        make.centerX.mas_equalTo(0);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Choose label plans"]];
    string.yy_alignment = NSTextAlignmentCenter;
    string.yy_font = [UIFont systemFontOfSize:14];
    string.yy_color = UIColor.whiteColor;
    string.yy_underlineStyle = NSUnderlineStyleSingle;
    string.yy_underlineColor  = [UIColor ht_colorWithHexString:@"#ECECEC"];
    label.attributedText = string;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(HTNum(40));
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_labelAction)];
    [label addGestureRecognizer:tapGesture];
}

- (void)ht_payAction
{
    if (self.BLOCK_payBlock) {
        self.BLOCK_payBlock();
    }
}

- (void)ht_labelAction
{
    if (self.BLOCK_moreBlock) {
        self.BLOCK_moreBlock();
    }
}

@end
