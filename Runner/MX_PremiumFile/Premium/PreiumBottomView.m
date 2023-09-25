//
//  PreiumBottomView.m
//  Movie
//
//  Created by wmz on 2023/2/21.
//

#import "PreiumBottomView.h"
#import "PreiumBottomItemView.h"

@implementation PreiumBottomView
- (void)ht_setupViews{
    PreiumBottomItemView *item = [[PreiumBottomItemView alloc] init];
    item.content = LocalString(@"Subscription automatically renews unless auto-renewal is disabled at least 24 hours before the end of the current period.", nil);
    item.freStr = LocalString(@"Subscription automatically renews", nil);
    [self addSubview:item];
    
    item = [[PreiumBottomItemView alloc] init];
    item.content = LocalString(@"Subscriptions can be managed by the user and automatic renewal can be disabled by going to the User Account Settings after purchase.", nil);
    item.freStr = LocalString(@"automatic renewal can be disabled", nil);
    [self addSubview:item];
    
    item = [[PreiumBottomItemView alloc] init];
    item.content = LocalString(@"You must confirm and pay the VIP subscription through the iTunes account in the purchase confirmation.", nil);
    [self addSubview:item];

    item = [[PreiumBottomItemView alloc] init];
    item.content = LocalString(@"Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable.", nil);
    [self addSubview:item];
    
    item = [[PreiumBottomItemView alloc] init];
    item.content = LocalString(@"The VIP subscription is automatically renewed.", nil);
    item.freStr = LocalString(@"The VIP subscription is automatically renewed.", nil);
    [self addSubview:item];
    
    item = [[PreiumBottomItemView alloc] init];
    item.content = LocalString(@"Subscriptions length: Weekly,Monthly,Annually.", nil);
    [self addSubview:item];
    
    item = [[PreiumBottomItemView alloc] init];
    item.pushWeb = true;
    item.webTitle = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user"];
    item.content = [NSString stringWithFormat:@"%@:%@", LocalString(@"Terms of Use", nil), STATIC_Terms];
    item.freStr = STATIC_Terms;
    [self addSubview:item];
    
    item = [[PreiumBottomItemView alloc] init];
    item.pushWeb = true;
    item.webTitle = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"protocol"];
    item.content = [NSString stringWithFormat:@"%@:%@", LocalString(@"Privacy Policy", nil), STATIC_Privacypolicy];
    item.freStr = STATIC_Privacypolicy;
    [self addSubview:item];
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    
    UIView *temp = nil;
    for (UIView *view in self.subviews) {
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            if (temp) {
                make.top.equalTo(temp.mas_bottom);
            } else {
                make.top.mas_equalTo(0);
            }
            make.bottom.mas_lessThanOrEqualTo(0);
        }];
        temp = view;
    }
}
@end
