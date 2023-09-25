//
//  HTDerivativeView.m
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import "HTDerivativeView.h"
#import "UIView+UIViewController.h"
#import "YYText.h"
#import "HTCommonConfiguration.h"

@implementation HTDerivativeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews {
     
    GdNstllModel *model = HTManage.sharedInstance.model3.var_gd_nstll;

    UIStackView *var_stackView = [[UIStackView alloc] init];
    [self addSubview:var_stackView];
    [var_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HTNumB(15));
        make.centerX.mas_equalTo(0);
    }];
    var_stackView.spacing = 6;
    UIImageView *icon1 = [[UIImageView alloc] init];
    [icon1 ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:240]];
    [var_stackView addArrangedSubview:icon1];
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = [LKFPrivateFunction lgjeropj_stringFillEmpty:model.var_title];
    label.textColor = [UIColor ht_colorWithHexString:@"#ffffff"];
    label.font = [UIFont boldSystemFontOfSize:18];
    [var_stackView addArrangedSubview:label];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:label.text];
    mstr.yy_lineSpacing = 4;
    mstr.yy_alignment = NSTextAlignmentCenter;
    label.attributedText = mstr;
    UIImageView *icon2 = [[UIImageView alloc] init];
    [icon2 ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:241]];
    [var_stackView addArrangedSubview:icon2];
    
    [icon1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(icon1.image.size);
    }];
    [icon2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(icon2.image.size);
    }];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.text = [LKFPrivateFunction lgjeropj_stringFillEmpty:model.text];
    contentLabel.textColor = [UIColor ht_colorWithHexString:@"#ffffff"];
    contentLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNumB(6));
        make.right.mas_equalTo(-HTNumB(6));
        make.top.equalTo(var_stackView.mas_bottom).offset(HTNumB(16));
    }];
    mstr = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];
    mstr.yy_lineSpacing = 4;
    mstr.yy_alignment = NSTextAlignmentCenter;
    contentLabel.attributedText = mstr;

    UIButton *var_shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [var_shareButton addTarget:self action:@selector(ht_deepAction) forControlEvents:UIControlEventTouchUpInside];
    [var_shareButton setTitle:[LKFPrivateFunction lgjeropj_stringFillEmpty:model.var_update] forState:UIControlStateNormal];
    var_shareButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [var_shareButton setTitleColor:[UIColor ht_colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    var_shareButton.layer.cornerRadius = HTNumB(12);
    var_shareButton.layer.masksToBounds = YES;
    [self addSubview:var_shareButton];
    [var_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(HTNumB(32));
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(HTNumB(44));
        make.bottom.mas_equalTo(-HTNumB(-20));
    }];
    [var_shareButton ht_setGradualChangingColors:@[[UIColor ht_colorWithHexString:@"#5a64ea"], [UIColor ht_colorWithHexString:@"#476cdb"], [UIColor ht_colorWithHexString:@"#3f6fd3"], [UIColor ht_colorWithHexString:@"#3872ca"], [UIColor ht_colorWithHexString:@"#357abc"]]];
}

- (void)ht_deepAction
{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_prelumDeepLinkBlock();
}

@end
