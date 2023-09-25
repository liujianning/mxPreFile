//
//  HTPremiumHeaderView.m
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import "HTPremiumHeaderView.h"
#import "YYText.h"

@interface HTPremiumHeaderView ()

@property (nonatomic, strong) UIImageView *headIcon;

@end

@implementation HTPremiumHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews {
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;

    self.head2Icon.hidden = YES;
    [self addSubview:self.head2Icon];
    [self.head2Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(HTNumB(16));
        make.width.mas_equalTo(HTWidth-HTNumB(42));
        make.height.mas_equalTo(HTNumB(72));
    }];

    [self addSubview:self.headIcon];
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(HTNumB(16));
        make.width.mas_equalTo(HTWidth-HTNumB(32));
        make.right.mas_equalTo(-HTNumB(16));
        make.height.mas_equalTo(HTNumB(72));
    }];
}

- (void)ht_updateLocalUI {
    
    [self.head2Icon ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:251]];
    [self.head2Icon.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UILabel *planLb = [[UILabel alloc] init];
    planLb.textColor = [UIColor ht_colorWithHexString:@"#222222"];
    planLb.font = [UIFont boldSystemFontOfSize:18];
    planLb.text = LocalString(@"Current Plan", nil);
    [self.head2Icon addSubview:planLb];
    [planLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNumB(16));
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(HTNumB(72));
    }];
    
    UILabel *freeLabel = [[UILabel alloc] init];
    freeLabel.numberOfLines = 2;
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc] initWithString:@""];
    NSString *type = @"";
    NSString *proId = @"";
    NSString *var_cancel = @"";
    proId = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_pid"];
    if ([HTManage.sharedInstance.model6.var_local.var_auto_renew_status integerValue] == 0) {
        var_cancel = HTManage.sharedInstance.model6.var_local.var_k6;
    }
    if (proId) {
        if ([proId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"]]) {
            type = LocalString(@"Monthly", nil);
        }
        if ([proId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"]]) {
            type = LocalString(@"Yearly", nil);
        }
        if ([proId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"week"]]) {
            type = LocalString(@"Weekly", nil);
        }
        type = [NSString stringWithFormat:@"%@-%@", LocalString(@"Individual", nil), type];
    }
    NSMutableAttributedString *typeStr = [[NSMutableAttributedString alloc] initWithString:type];
    typeStr.yy_color = [UIColor ht_colorWithHexString:@"#222222"];
    typeStr.yy_font = [UIFont systemFontOfSize:16];
    [mstr appendAttributedString:typeStr];
    if (var_cancel.length > 0) {
        [mstr appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:var_cancel.doubleValue];
        NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
        [objDateformat setDateFormat:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"MM dd,yyyy"]];
        NSString *time = [NSString stringWithFormat:@"%@ %@", LocalString(@"Cancel On", nil), [objDateformat stringFromDate: date]];
        NSMutableAttributedString *timeStr = [[NSMutableAttributedString alloc]initWithString:time];
        timeStr.yy_color = [UIColor ht_colorWithHexString:@"#ECECEC"];
        timeStr.yy_font = [UIFont systemFontOfSize:10];
        [mstr appendAttributedString:timeStr];
        mstr.yy_lineSpacing = 4;
    }
    mstr.yy_alignment = NSTextAlignmentRight;
    freeLabel.attributedText = mstr;
    [self.head2Icon addSubview:freeLabel];
    [freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-HTNumB(16));
        make.centerY.equalTo(planLb);
    }];
}

- (void)ht_updateServerUI {
    
    BOOL pay = [HTManage.sharedInstance ht_checkSub];
    if (!pay) {
        [self.headIcon ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:250]];
        [self.headIcon.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UILabel *planLb = [[UILabel alloc] init];
        planLb.textColor = [UIColor ht_colorWithHexString:@"#222222"];
        planLb.font = [UIFont boldSystemFontOfSize:18];
        planLb.text = LocalString(@"Current Plan", nil);
        [self.headIcon addSubview:planLb];
        [planLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HTNumB(16));
            make.centerY.mas_equalTo(0);
        }];
        
        UILabel *freeLabel = [[UILabel alloc] init];
        freeLabel.textColor = [UIColor ht_colorWithHexString:@"#222222"];
        freeLabel.font = [UIFont systemFontOfSize:16];
        freeLabel.text = LocalString(@"Get Free", nil);
        [self.headIcon addSubview:freeLabel];
        [freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HTNumB(16));
            make.centerY.mas_equalTo(0);
        }];
        [self.headIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(HTNumB(16));
            make.width.mas_equalTo(HTWidth-HTNumB(32));
            make.right.mas_equalTo(-HTNumB(16));
            make.height.mas_equalTo(HTNumB(72));
        }];
    } else {
        [self.headIcon ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:251]];
        [self.headIcon.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        UILabel *planLb = [[UILabel alloc] init];
        planLb.textColor = [UIColor ht_colorWithHexString:@"#222222"];
        planLb.font = [UIFont boldSystemFontOfSize:18];
        planLb.text = LocalString(@"Current Plan", nil);
        [self.headIcon addSubview:planLb];
        [planLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(HTNumB(16));
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(HTNumB(72));
        }];
        
        UILabel *freeLabel = [[UILabel alloc] init];
        freeLabel.numberOfLines = 2;
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc] initWithString:@""];
        
        NSString *type = @"";
        NSString *proId = @"";
        NSString *var_cancel = @"";
        BOOL var_isFamily = NO;
        if ([HTManage.sharedInstance.model6.var_family.var_val integerValue] == 1) {
            var_isFamily = YES;
            proId = HTManage.sharedInstance.model6.var_family.var_pid;
            if ([HTManage.sharedInstance.model6.var_family.var_auto_renew_status integerValue] == 0) {
                var_cancel = HTManage.sharedInstance.model6.var_family.var_k6;
            }
        } else if ([HTManage.sharedInstance.model6.var_server.var_val2 integerValue] == 1) {
            proId = HTManage.sharedInstance.model6.var_server.var_pid;
            if ([HTManage.sharedInstance.model6.var_server.var_auto_renew_status integerValue] == 0) {
                var_cancel = HTManage.sharedInstance.model6.var_server.var_k6;
            }
        } else if ([HTManage.sharedInstance.model6.var_device.var_val integerValue] == 1) {
            proId = HTManage.sharedInstance.model6.var_device.var_pid;
        } else if (HTManage.sharedInstance.model6.var_local.var_value == 1) {
            proId = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_pid"];
            if ([HTManage.sharedInstance.model6.var_local.var_auto_renew_status integerValue] == 0) {
                var_cancel = HTManage.sharedInstance.model6.var_local.var_k6;
            }
        }
        if (proId) {
            if ([proId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"]]) {
                type = LocalString(@"Monthly", nil);
            }
            if ([proId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"]]) {
                type = LocalString(@"Yearly", nil);
            }
            if ([proId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"week"]]) {
                type = LocalString(@"Weekly", nil);
            }
            NSString *var_prefix = var_isFamily ? LocalString(@"Family", nil) : LocalString(@"Individual", nil);
            type = [NSString stringWithFormat:@"%@-%@", var_prefix, type];
        }
        NSMutableAttributedString *typeStr = [[NSMutableAttributedString alloc]initWithString:type];
        typeStr.yy_color = [UIColor ht_colorWithHexString:@"#222222"];
        typeStr.yy_font = [UIFont systemFontOfSize:16];
        [mstr appendAttributedString:typeStr];
        if (var_cancel.length > 0) {
            [mstr appendAttributedString:[[NSAttributedString alloc]initWithString:@"\n"]];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:var_cancel.doubleValue];
            NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
            [objDateformat setDateFormat:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"MM dd,yyyy"]];
            NSString *time = [NSString stringWithFormat:@"%@ %@", LocalString(@"Cancel On", nil), [objDateformat stringFromDate: date]];
            NSMutableAttributedString *timeStr = [[NSMutableAttributedString alloc]initWithString:time];
            timeStr.yy_color = [UIColor ht_colorWithHexString:@"#ECECEC"];
            timeStr.yy_font = [UIFont systemFontOfSize:10];
            [mstr appendAttributedString:timeStr];
            mstr.yy_lineSpacing = 4;
        }
        mstr.yy_alignment = NSTextAlignmentRight;
        freeLabel.attributedText = mstr;
        [self.headIcon addSubview:freeLabel];
        [freeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-HTNumB(16));
            make.centerY.equalTo(planLb);
        }];
        
        if (var_isFamily) {
            UIView *line = [[UIView alloc] init];
            line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
            [self.headIcon addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(HTNumB(72));
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(1);
            }];
            UILabel *hintLb = [[UILabel alloc] init];
            hintLb.textColor = [UIColor ht_colorWithHexString:@"#222222"];
            hintLb.font = [UIFont systemFontOfSize:14];
            hintLb.text = LocalString(@"My Family", nil);
            [self.headIcon addSubview:hintLb];
            [hintLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(HTNumB(16));
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(HTNumB(44));
            }];
            BOOL var_master = [HTManage.sharedInstance.model6.var_family.var_master integerValue] == 1;
            UIButton *btn = [[UIButton alloc] init];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitle:var_master ? [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Manager"] : [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"View"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor ht_colorWithHexString:@"#222222"] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
            btn.layer.cornerRadius = 13;
            btn.layer.masksToBounds = YES;
            [btn addTarget:self action:@selector(ht_familyMemberAction) forControlEvents:UIControlEventTouchUpInside];
            [self.headIcon addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.centerY.equalTo(hintLb);
                make.width.mas_equalTo(var_master ? 79 : 59);
                make.height.mas_equalTo(26);
            }];
            
            UIView *redView = [[UIView alloc] init];
            redView.backgroundColor = [UIColor redColor];
            redView.layer.cornerRadius = 3;
            redView.layer.masksToBounds = YES;
            redView.hidden = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_add_family_member_red"];
            [self.headIcon addSubview:redView];
            [redView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.right.equalTo(btn);
                make.size.mas_equalTo(6);
            }];

            BOOL var_second = [self ht_doublePremium];
            [self.headIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.left.mas_equalTo(var_second ? (HTWidth-HTNumB(10)) : HTNumB(16));
                make.width.mas_equalTo(HTWidth-(var_second ? HTNumB(42) : HTNumB(32)));
                make.right.mas_equalTo(-HTNumB(16));
                make.height.mas_equalTo(HTNumB(72+44));
            }];
        } else {
            BOOL var_second = [self ht_doublePremium];
            [self.headIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.bottom.mas_equalTo(0);
                make.left.mas_equalTo(var_second ? (HTWidth-HTNumB(10)) : HTNumB(16));
                make.width.mas_equalTo(HTWidth-(var_second ? HTNumB(42) : HTNumB(32)));
                make.right.mas_equalTo(-HTNumB(16));
                make.height.mas_equalTo(HTNumB(72));
            }];
        }
    }
}

- (void)ht_familyMemberAction {
    
    if (self.BLOCK_FamilyMemberBlock) {
        self.BLOCK_FamilyMemberBlock();
    }
}

- (BOOL)ht_doublePremium {
    
    BOOL var_localVip = HTManage.sharedInstance.model6.var_local.var_value == 1;
    BOOL var_deviceVip = [HTManage.sharedInstance.model6.var_device.var_val integerValue] == 1;
    BOOL var_toolVip = [HTManage.sharedInstance.model6.var_server.var_t1 integerValue] == 2;
    return var_localVip && !var_deviceVip && var_toolVip;
}

- (UIImageView *)headIcon {
    
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.userInteractionEnabled = YES;
    }
    return _headIcon;
}

- (UIImageView *)head2Icon {
    
    if (!_head2Icon) {
        _head2Icon = [[UIImageView alloc] init];
        _head2Icon.userInteractionEnabled = YES;
    }
    return _head2Icon;
}

@end
