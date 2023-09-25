//
//  HTToolInstallGuideView.m
 
//
//  Created by 李雪健 on 2023/7/10.
//

#import "HTToolInstallGuideView.h"
#import "HTToolKitManager.h"
#import "YYWebImage.h"

@interface HTToolInstallGuideView ()

@property (nonatomic, strong) UIView *var_contentView;
@property (nonatomic, copy) dispatch_block_t var_after;

@end

@implementation HTToolInstallGuideView

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
    self.var_contentView = [[UIView alloc] init];
    self.var_contentView.backgroundColor = [UIColor ht_colorWithHexString:@"#292A2F"];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, HTWidth, 375) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(24, 24)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, HTWidth, 375);
    maskLayer.path = maskPath.CGPath;
    self.var_contentView.layer.mask = maskLayer;
    [self addSubview:self.var_contentView];
    
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_p1];
    NSString *var_gif = dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"gif"]];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] init];
    [imageView ht_setImageWithURL:[NSURL URLWithString:var_gif]];
    [self.var_contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(360);
        make.height.mas_equalTo(260);
    }];
    
    UILabel *var_payment = [[UILabel alloc] init];
    var_payment.text = [LocalString(@"Proceeding to XXX to complete payment", nil) stringByReplacingOccurrencesOfString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"XXX"] withString:dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t1"]]];
    var_payment.textColor = [UIColor ht_colorWithHexString:@"#FFD770"];
    var_payment.font = [UIFont boldSystemFontOfSize:14];
    [self.var_contentView addSubview:var_payment];
    [var_payment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.equalTo(imageView.mas_bottom).offset(20);
    }];
    
    [self addTarget:self action:@selector(lgjeropj_dismissAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)lgjeropj_show
{
    [HTWindow addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
 
    if (!self.var_after) {
        __weak typeof(self) weakSelf = self;
        self.var_after = dispatch_block_create(0, ^{
            if ([weakSelf superview]) {
                [weakSelf removeFromSuperview];
                weakSelf.var_contentView.frame = CGRectMake(0, HTHeight, HTWidth, 375);
                [weakSelf lgjeropj_installAction];
            }
        });
    }
    
    self.var_contentView.frame = CGRectMake(0, HTHeight, HTWidth, 375);
    [UIView animateWithDuration:0.2 animations:^{
        self.var_contentView.frame = CGRectMake(0, HTHeight-375, HTWidth, 375);
    }];
    // 4秒后自动下载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), self.var_after);
}

- (void)lgjeropj_installAction
{
    if (self.var_install) {
        self.var_install();
    }
}

- (void)lgjeropj_dismissAction
{
    if (self.var_after) {
        dispatch_block_cancel(self.var_after);
        self.var_after = nil;
    }
    //埋点
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@2 forKey:[LKFPrivateFunction htMethodStringToInt:@"kid"]];
    [params setValue:@8 forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"tspop_cl"] params:params];

    [UIView animateWithDuration:0.2 animations:^{
        self.var_contentView.frame = CGRectMake(0, HTHeight, HTWidth, 334);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
