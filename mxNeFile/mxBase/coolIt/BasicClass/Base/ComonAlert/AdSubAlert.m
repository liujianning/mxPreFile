//
//  AdSubAlert.m
//  Movie
//
//  Created by wmz on 2023/3/12.
//

#import "AdSubAlert.h"

@interface AdSubAlert ()
@property (nonatomic,strong)UIView *var_bgView;
@property (nonatomic,strong)UIButton *var_getBTN;
@property (nonatomic,strong)UIButton *cancelBTN;
@property (nonatomic,strong)UIStackView *var_centerStackView;
@end

@implementation AdSubAlert

- (void)ht_setupViews{
    self.backgroundColor = UIColor.clearColor;
    self.var_centerStackView = [[UIStackView alloc] init];
    self.var_centerStackView.axis = UILayoutConstraintAxisVertical;
    self.var_centerStackView.spacing = 30;
    
    self.var_bgView = [[UIView alloc] init];
    [self addSubview:self.var_bgView];
    self.var_bgView.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#23252A"].CGColor;
    [self.var_bgView addSubview:self.var_centerStackView];
    
    self.var_getBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.var_getBTN setTitle:LocalString(@"GET PREMIUM TO REMOVE ADS", nil) forState:UIControlStateNormal];
    [self.var_getBTN setTitleColor:[UIColor ht_colorWithHexString:@"#ECECEC"] forState:UIControlStateNormal];
    self.var_getBTN.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.var_centerStackView addArrangedSubview:self.var_getBTN];
    self.var_getBTN.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#3A3B40"].CGColor;
    self.var_getBTN.layer.cornerRadius = 4;
    
    self.cancelBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelBTN setTitle:LocalString(@"CANCEL", nil) forState:UIControlStateNormal];
    [self.cancelBTN setTitleColor:[UIColor ht_colorWithHexString:@"#ECECEC"] forState:UIControlStateNormal];
    self.cancelBTN.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.var_centerStackView addArrangedSubview:self.cancelBTN];
    self.cancelBTN.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#3A3B40"].CGColor;
    self.cancelBTN.layer.cornerRadius = 4;
    [self.var_getBTN addTarget:self action:@selector(ht_goAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBTN addTarget:self action:@selector(ht_cancelAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
       [self setNeedsUpdateConstraints];
    }
}

- (void)ht_goAction
{
    if (self.BLOCK_closeAdBlock) {
        self.BLOCK_closeAdBlock();
    }
    UIViewController *vc = self.movieVC;
//    [HTWindowManage ht_toPay:vc source:@"18"];//测试-待处理
}

- (void)ht_cancelAction
{
    if (self.BLOCK_closeAdBlock) {
        self.BLOCK_closeAdBlock();
    }
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.var_bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.var_centerStackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
    }];
    
    [self.cancelBTN mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(38);
    }];
    
    [self.var_getBTN mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(38);
    }];
}


@end
