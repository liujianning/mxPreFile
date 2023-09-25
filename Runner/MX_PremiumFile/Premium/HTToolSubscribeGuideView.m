//
//  HTToolSubscribeGuideView.m
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import "HTToolSubscribeGuideView.h"
#import "HTToolKitManager.h"
#import "YYWebImage.h"

@implementation HTToolSubscribeGuideView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews {
    
    self.backgroundColor = [UIColor ht_colorWithHexString:@"#292A2F"];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 12;
    
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_p1];
    NSString *var_gif = dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"gif"]];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
    [self addSubview:imageView];
    [imageView ht_setImageWithURL:[NSURL URLWithString:var_gif]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(36);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(220);
    }];
    
    UILabel *var_label = [[UILabel alloc] init];
    var_label.text = [LocalString(@"Subscribe at XXX to become PREM", nil) stringByReplacingOccurrencesOfString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"XXX"] withString:[[[HTToolKitManager shared] lgjeropj_strip_p1] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t1"]]];
    var_label.textColor = [UIColor ht_colorWithHexString:@"#FFD29D"];
    var_label.font = [UIFont systemFontOfSize:14];
    [self addSubview:var_label];
    [var_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(imageView.mas_bottom).offset(25);
    }];
    
    UIButton *var_button = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 238, 44);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(__bridge id)[UIColor ht_colorWithHexString:@"#EDC391"].CGColor, (__bridge id)[UIColor ht_colorWithHexString:@"#FDDDB7"].CGColor];
    [var_button.layer addSublayer:gradientLayer];
    var_button.layer.masksToBounds = YES;
    var_button.layer.cornerRadius = 22;
    [var_button setTitle:[[HTToolKitManager shared] lgjeropj_installed] ? [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Go Subscribe"] : [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Install"] forState:UIControlStateNormal];
    [var_button setTitleColor:[UIColor ht_colorWithHexString:@"#685034"] forState:UIControlStateNormal];
    var_button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_button addTarget:self action:@selector(lgjeropj_subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:var_button];
    [var_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_label.mas_bottom).offset(35);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(238);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *var_skipBtn = [[UIButton alloc] init];
    [var_skipBtn setTitle:LocalString(@"Later", nil) forState:UIControlStateNormal];
    [var_skipBtn setTitleColor:[UIColor ht_colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [var_skipBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
    [var_skipBtn.titleLabel setAttributedText:[[NSAttributedString alloc] initWithString:LocalString(@"Later", nil) attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}]];
    [var_skipBtn addTarget:self action:@selector(lgjeropj_skipAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:var_skipBtn];
    [var_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(var_button.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
    }];
}

- (void)lgjeropj_subscribeAction {
    
    if (self.BLOCK_subscribeBlock) {
        self.BLOCK_subscribeBlock();
    }
}

- (void)lgjeropj_skipAction {
    
    if (self.BLOCK_skipBlock) {
        self.BLOCK_skipBlock();
    }
}

@end
