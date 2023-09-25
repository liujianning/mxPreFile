//
//  HTToolSubscribeToastView.m
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import "HTToolSubscribeToastView.h"
#import "HTToolKitManager.h"

@implementation HTToolSubscribeToastView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews {

    self.backgroundColor = [UIColor ht_colorWithHexString:@"#323232"];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 12;

    UILabel *toastView = [[UILabel alloc] init];
    toastView.text = [NSString stringWithFormat:@"%@%@", [LocalString(@"Proceeding to XXX to complete payment", nil) stringByReplacingOccurrencesOfString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"XXX"] withString:[[[HTToolKitManager shared] lgjeropj_strip_p1] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t1"]]], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"..."]];
    toastView.textColor = [UIColor ht_colorWithHexString:@"#FFD770"];
    toastView.font = [UIFont boldSystemFontOfSize:14];
    toastView.textAlignment = NSTextAlignmentCenter;
    toastView.numberOfLines = 0;
    [self addSubview:toastView];
    [toastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(240);
    }];
}

@end
