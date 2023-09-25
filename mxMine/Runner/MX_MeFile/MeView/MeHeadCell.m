//
//  MeHeadCell.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "MeHeadCell.h"
#import "HTManage.h"
#import "YYText.h"
#import "HTCommonConfiguration.h"

@interface MeHeadCell()

@property(nonatomic,strong)UIImageView *var_bgIV;
@property(nonatomic,strong)UIImageView *iconIV;
@property(nonatomic,strong)UIImageView *var_rightIV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIView *var_vipView;
@property(nonatomic,strong)UIImageView *var_vipBgView;
@property(nonatomic,strong)UILabel *var_vipTopLabel;
@property(nonatomic,strong)UILabel *var_vipBottomLabel;
@property(nonatomic,strong)UIImageView *var_vipTypeIV;
@property(nonatomic,strong)UILabel *var_vipTypeLabel;

@end

@implementation MeHeadCell

- (void)ht_addCellSubViews
{
    self.var_bgIV = [[UIImageView alloc] init];
    [self.var_bgIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:244]];
    self.var_bgIV.contentMode = UIViewContentModeScaleAspectFill;
    self.var_bgIV.clipsToBounds = YES;
    [self.contentView addSubview:self.var_bgIV];

    self.iconIV = [[UIImageView alloc] init];
    self.iconIV.image = [UIImage imageNamed:@"icon_me_avatar"];
    self.iconIV.contentMode = UIViewContentModeScaleAspectFill;
    self.iconIV.clipsToBounds = YES;
    self.iconIV.layer.cornerRadius = HTNum(27);
    self.iconIV.layer.borderColor = [UIColor ht_colorWithHexString:@"#ECECEC"].CGColor;
    self.iconIV.layer.borderWidth = 1;
    [self.var_bgIV addSubview:self.iconIV];

    self.var_rightIV = [[UIImageView alloc] init];
    self.var_rightIV.image = [UIImage imageNamed:@"icon_back"];
    self.var_rightIV.transform = CGAffineTransformMakeRotation(M_PI);
    [self.var_bgIV addSubview:self.var_rightIV];

    [self.var_bgIV addSubview:self.nameLabel];
    [self.var_bgIV addSubview:self.var_vipTypeIV];
    [self.var_bgIV addSubview:self.var_vipTypeLabel];
    
    self.var_vipView = [[UIView alloc] init];
    [self.contentView addSubview:self.var_vipView];
    
    self.var_vipBgView = [[UIImageView alloc] init];
    [self.var_vipBgView ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:236]];
    self.var_vipBgView.contentMode = UIViewContentModeScaleToFill;
    self.var_vipBgView.layer.cornerRadius = HTNum(6);
    self.var_vipBgView.clipsToBounds = YES;
    [self.var_vipView addSubview:self.var_vipBgView];
    
    [self.var_vipView addSubview:self.var_vipTopLabel];
    [self.var_vipView addSubview:self.var_vipBottomLabel];
    
    self.var_vipView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_tapAction)];
    [self.var_vipView addGestureRecognizer:tap];
}

- (void)ht_tapAction
{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_toPayBlock(nil, [NSString stringWithFormat:@"%d", 45]);
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.var_bgIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(HTNum(132));
        make.bottom.mas_lessThanOrEqualTo(0);
    }];

    [self.var_rightIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(HTNum(2));
        make.width.height.mas_equalTo(HTNum(15));
    }];

    [self.iconIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HTNum(20));
        make.left.mas_equalTo(HTNum(10));
        make.width.height.mas_equalTo(HTNum(54));
    }];

    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if ([HTManage.sharedInstance ht_checkSub]) {
            make.top.equalTo(self.iconIV);
            make.height.mas_lessThanOrEqualTo(HTNum(20));
        } else {
            make.centerY.equalTo(self.iconIV);
        }
        make.left.equalTo(self.iconIV.mas_right).offset(HTNum(16));
        make.right.mas_lessThanOrEqualTo(-HTNum(40));
    }];
    
    [self.var_vipTypeIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(HTNum(2));
        make.left.equalTo(self.iconIV.mas_right).offset(HTNum(16));
        make.width.mas_lessThanOrEqualTo(HTNum(100));
        make.height.mas_lessThanOrEqualTo(HTNum(27));
    }];
    
    [self.var_vipTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.var_vipTypeIV.mas_bottom).offset(HTNum(2));
        make.left.equalTo(self.iconIV.mas_right).offset(HTNum(16));
        make.right.mas_lessThanOrEqualTo(-HTNum(40));
        make.height.mas_lessThanOrEqualTo(HTNum(15));
    }];

    [self.var_vipView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.var_vipView.isHidden) {
            make.top.equalTo(self.var_bgIV.mas_bottom);
            make.left.mas_equalTo(HTNum(10));
            make.right.mas_equalTo(-HTNum(10));
            make.height.mas_equalTo(HTNum(60));
            make.bottom.mas_lessThanOrEqualTo(0);
        }
    }];
    
    [self.var_vipBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.var_vipTopLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HTNum(8));
        make.left.mas_equalTo(HTNum(10));
        make.right.mas_equalTo(-HTNum(10));
    }];
    
    [self.var_vipBottomLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-HTNum(8));
        make.left.right.equalTo(self.var_vipTopLabel);
    }];
    
    HTCommonConfiguration.lgjeropj_shared.BLOCK_querryPurchaseWithIDBlock(STATIC_MONTH);
}

- (UILabel *)var_vipTopLabel{
    if (!_var_vipTopLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor ht_colorWithHexString:@"#222222"];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.text = LocalString(@"Special Offer For You", nil);
        _var_vipTopLabel = label;
    }
    return _var_vipTopLabel;
}

- (UILabel *)var_vipBottomLabel{
    if (!_var_vipBottomLabel) {
        UILabel *label = [[UILabel alloc] init];
        NSString *var_price = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$2.99"];
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@", var_price, LocalString(@"for the 1 month", nil)]];
        mstr.yy_font = [UIFont systemFontOfSize:14];
        mstr.yy_color = [UIColor ht_colorWithHexString:@"#222222"];
        [mstr yy_setFont:[UIFont boldSystemFontOfSize:18] range:[mstr.string rangeOfString:var_price]];
        label.attributedText = mstr;
        _var_vipBottomLabel = label;
    }
    return _var_vipBottomLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.whiteColor;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.text = LocalString(@"Login/Signup", nil);
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UIImageView *)var_vipTypeIV {
    if (!_var_vipTypeIV) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _var_vipTypeIV = imageView;
    }
    return _var_vipTypeIV;
}

- (UILabel *)var_vipTypeLabel{
    if (!_var_vipTypeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.lightGrayColor;
        label.font = [UIFont systemFontOfSize:13];
        _var_vipTypeLabel = label;
    }
    return _var_vipTypeLabel;
}

- (void)ht_updateCellWithData{
    UserModel *var_userModel = HTManage.sharedInstance.model2;
    if (HTManage.sharedInstance.model2.var_uid) {
        self.nameLabel.text = [LKFPrivateFunction lgjeropj_stringFillEmpty:var_userModel.var_user_name];
        [self.iconIV ht_setImageWithURL:[NSURL URLWithString:var_userModel.var_user_face] placeholder:[UIImage imageNamed:@"icon_me_avatar"]];
    } else {
        self.nameLabel.text = LocalString(@"Login/Signup", nil);
        self.iconIV.image = [UIImage imageNamed:@"icon_me_avatar"];
    }
    if ([HTManage.sharedInstance ht_checkSub]) {
        self.var_vipView.hidden = YES;
        NSString *var_ProductId = @"";
        NSString *var_CancelTime = @"";
        NSString *var_ProductName = @"";
        if ([[HTManage sharedInstance].model6.var_server.var_val2 isEqualToString:@"1"]) {
            var_ProductId = [HTManage sharedInstance].model6.var_server.var_pid;
            if (![[HTManage sharedInstance].model6.var_server.var_auto_renew_status isEqualToString:@"1"]) {
                var_CancelTime = [HTManage sharedInstance].model6.var_server.var_k6;
            }
        } else if ([[HTManage sharedInstance].model6.var_device.var_val isEqualToString:@"1"]) {
            var_ProductId = [HTManage sharedInstance].model6.var_device.var_pid;
            var_CancelTime = [HTManage sharedInstance].model6.var_device.var_k6;
        } else if ([[HTManage sharedInstance].model6.var_family.var_val isEqualToString:@"1"]) {
            var_ProductId = [HTManage sharedInstance].model6.var_family.var_pid;
            if (![[HTManage sharedInstance].model6.var_family.var_auto_renew_status isEqualToString:@"1"]) {
                var_CancelTime = [HTManage sharedInstance].model6.var_family.var_k6;
            }
        } else if ([HTManage sharedInstance].model6.var_local.var_value == 1) {
            var_ProductId = [HTManage sharedInstance].model6.var_local.var_pid;
            if (![[HTManage sharedInstance].model6.var_local.var_auto_renew_status isEqualToString:@"1"]) {
                var_CancelTime = [HTManage sharedInstance].model6.var_local.var_k6;
            }
        }
        if ([var_ProductId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"family"]]) {
            [self.var_vipTypeIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:266]];
        } else {
            [self.var_vipTypeIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:245]];
        }
        self.var_vipTypeIV.hidden = NO;

        if (var_CancelTime.length > 0) {
            NSDate *var_date = [NSDate dateWithTimeIntervalSince1970:var_CancelTime.longLongValue];
            NSDateFormatter *var_formatter = [[NSDateFormatter alloc] init];
            [var_formatter setDateFormat:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"MMM d, yyyy"]];
            NSString *var_dateString = [var_formatter stringFromDate:var_date];
            var_CancelTime = [NSString stringWithFormat:@"%@ %@", LocalString(@"Cancel On", nil), var_dateString];
        }
        if ([var_ProductId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"week"]]) {
            var_ProductName = LocalString(@"Weekly", nil);
        } else if ([var_ProductId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"]]) {
            var_ProductName = LocalString(@"Monthly", nil);
        } else if ([var_ProductId containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"]]) {
            var_ProductName = LocalString(@"Annually", nil);
        }
        self.var_vipTypeLabel.text = var_CancelTime.length > 0 ? var_CancelTime : var_ProductName;
        self.var_vipTypeLabel.hidden = NO;
    } else {
        self.var_vipView.hidden = NO;
        self.var_vipTypeIV.hidden = YES;
        self.var_vipTypeLabel.hidden = YES;
    }
    [self setNeedsUpdateConstraints];
}
@end
