//
//  HTSubscripBootInterestView.m
 
//
//  Created by 李雪健 on 2023/7/12.
//

#import "HTSubscripBootInterestView.h"

@implementation HTSubscripBootInterestView

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
    UIImageView *icon = [[UIImageView alloc] init];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(HTNum(280));
        make.top.mas_equalTo(0);
    }];
    
    NSDictionary *var_mInfo = @{
        @"0":@{
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]:LocalString(@"NO ADS", nil),
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"]:LocalString(@"Remove all full-screen ads, banner ads and MREC ads.", nil)
        },
        @"1":@{
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]:LocalString(@"Unlock all movies", nil),
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"]:LocalString(@"Watch full movies and TV shows without sharing.", nil)
        },
        @"2":@{
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]:LocalString(@"Download movies & TV", nil),
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"]:LocalString(@"Download videos to watch anywhere, even when you don't have an internet connection.", nil)
        },
        @"3":@{
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]:LocalString(@"Cast to TV", nil),
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"]:LocalString(@"Support Chromecast, Roku TV, Samsung TV and other DLNA streaming device.", nil)
        },
        @"4":@{
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]:LocalString(@"HIGH DEFINITION", nil),
            [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"]:LocalString(@"Enjoy the best picture quality and sound.", nil)
        },
    };
    NSInteger var_random = NSNotFound;
    if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:HTManage.sharedInstance.model4.var_i3]) {
        while (true) {
            var_random = arc4random() % HTManage.sharedInstance.model4.var_i3.count;
            if (var_random == 0 || var_random == 1 || var_random == 3) {
                break;
            }
        }
        if (var_random != NSNotFound) {
            [icon ht_setImageWithURL:[NSURL URLWithString:HTManage.sharedInstance.model4.var_i3[var_random]]];
        }
    }
    NSDictionary *var_showInfo = @{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]:LocalString(@"NO ADS", nil),
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"]:LocalString(@"Remove all full-screen ads, banner ads and MREC ads.", nil)
    };
    if (var_random != NSNotFound) {
        var_showInfo = var_mInfo[@(var_random).stringValue];
    }

    UILabel *label1 = [[UILabel alloc] init];
    label1.text = var_showInfo[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.numberOfLines = 0;
    label1.textColor = UIColor.whiteColor;
    label1.font = [UIFont boldSystemFontOfSize:22];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(8);
        make.left.mas_equalTo(HTNum(36));
        make.right.mas_equalTo(-HTNum(36));
    }];

    UILabel *label2 = [[UILabel alloc] init];
    label2.text = var_showInfo[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"detail"]];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.numberOfLines = 0;
    label2.textColor = [UIColor ht_colorWithHexString:@"#999999"];
    label2.font = [UIFont systemFontOfSize:14];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(HTNum(20));
        make.left.right.equalTo(label1);
        make.bottom.mas_equalTo(0);
    }];
}

@end
