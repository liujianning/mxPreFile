//
//  HTFakeCardGuideView.m
 
//
//  Created by 李雪健 on 2023/7/10.
//

#import "HTFakeCardGuideView.h"
#import "HTToolKitManager.h"
#import "YYWebImage.h"

@implementation HTFakeCardGuideView

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
    UIView *var_blackView = [[UIView alloc] init];
    var_blackView.backgroundColor = [UIColor blackColor];
    [self addSubview:var_blackView];
    [var_blackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(72);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *var_priceLabel = [[UILabel alloc] init];
    var_priceLabel.text = [[[HTToolKitManager shared] lgjeropj_strip_p1] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t5"]];
    var_priceLabel.font = [UIFont boldSystemFontOfSize:20];
    var_priceLabel.textColor = [UIColor ht_colorWithHexString:@"#FFD770"];
    [var_blackView addSubview:var_priceLabel];
    [var_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.top.mas_equalTo(13);
    }];
    
    UILabel *var_hintLabel = [[UILabel alloc] init];
    var_hintLabel.text = LocalString(@"Become PREM & Enjoy Uninterrupted Viewing", nil);
    var_hintLabel.font = [UIFont boldSystemFontOfSize:13];
    var_hintLabel.textColor = [UIColor ht_colorWithHexString:@"#FFFFFF"];
    [var_blackView addSubview:var_hintLabel];
    [var_hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIView *var_colorView = [[UIView alloc] init];
    var_colorView.backgroundColor = [UIColor ht_colorWithHexString:@"#3B3838"];
    var_colorView.layer.masksToBounds = YES;
    var_colorView.layer.cornerRadius = 12;
    [self addSubview:var_colorView];
    [var_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_blackView.mas_bottom).offset(68);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(332);
    }];
    
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
    NSString *var_gif = [[[[HTToolKitManager shared] lgjeropj_strip_p2] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"gif"]] firstObject];
    [imageView ht_setImageWithURL:[NSURL URLWithString:var_gif]];
    [var_colorView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(187);
    }];
    
    UIView *var_interestView = [[UIView alloc] init];
    [var_colorView addSubview:var_interestView];
    [var_interestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(48);
    }];
    
    UILabel *var_interestLabel = [[UILabel alloc] init];
    var_interestLabel.text = [NSString stringWithFormat:@"%@%@", LocalString(@"All PREM Privileges", nil), @":"];
    var_interestLabel.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    var_interestLabel.font = [UIFont boldSystemFontOfSize:13];
    [var_interestView addSubview:var_interestLabel];
    [var_interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    CGFloat width = [var_interestLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, 13)].width;
    CGFloat var_width = (332-20-width-20-26*3)/3;
    
    UIImageView *var_img1 = [[UIImageView alloc] init];
    [var_img1 ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:255]];
    [var_interestView addSubview:var_img1];
    [var_img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(var_interestLabel.mas_right).offset(var_width);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(21);
    }];
    
    UIImageView *var_img2 = [[UIImageView alloc] init];
    [var_img2 ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:256]];
    [var_interestView addSubview:var_img2];
    [var_img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(var_img1.mas_right).offset(var_width);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(21);
    }];
    
    UIImageView *var_img3 = [[UIImageView alloc] init];
    [var_img3 ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:257]];
    [var_interestView addSubview:var_img3];
    [var_img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.equalTo(var_img2.mas_right).offset(var_width);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(21);
    }];
    
    NSString *var_btnName = LocalString(@"Become PREM for Only XXX", nil);
    NSString *var_replace = [[[HTToolKitManager shared] lgjeropj_strip_p2] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t1"]];
    var_btnName = [var_btnName stringByReplacingOccurrencesOfString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"XXX"] withString:var_replace];
    UIButton *var_button = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, HTWidth-65, 44);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(__bridge id)[UIColor ht_colorWithHexString:@"#EDC391"].CGColor, (__bridge id)[UIColor ht_colorWithHexString:@"#FDDDB7"].CGColor];
    [var_button.layer addSublayer:gradientLayer];
    var_button.layer.masksToBounds = YES;
    var_button.layer.cornerRadius = 22;
    [var_button setTitle:var_btnName forState:UIControlStateNormal];
    [var_button setTitleColor:[UIColor ht_colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    var_button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_button addTarget:self action:@selector(lgjeropj_becomeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:var_button];
    [var_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_colorView.mas_bottom).offset(69);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(HTWidth-65);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *var_skipBtn = [[UIButton alloc] init];
    [var_skipBtn setTitle:LocalString(@"Skip", nil) forState:UIControlStateNormal];
    [var_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [var_skipBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [var_skipBtn.titleLabel setAttributedText:[[NSAttributedString alloc] initWithString:LocalString(@"Skip", nil) attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}]];
    [var_skipBtn addTarget:self action:@selector(lgjeropj_skipAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:var_skipBtn];
    [var_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_button.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

}

- (void)lgjeropj_becomeAction {
    
    if (self.var_becomeAction) {
        self.var_becomeAction();
    }
}

- (void)lgjeropj_skipAction {
    
    if (self.var_skipAction) {
        self.var_skipAction();
    }
}

@end
