//
//  PremiumCell.m
//  Movie
//
//  Created by wmz on 2023/2/21.
//

#import "PremiumCell.h"
#import "UIView+UIViewController.h"

@implementation PremiumCell
- (void)ht_addCellSubViews{
    self.contentView.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#1B1C20"].CGColor;
    self.contentView.layer.cornerRadius = HTNum(6);
    
    self.icoIV = [[UIImageView alloc] init];
    [self.icoIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:238]];
    [self.contentView addSubview:self.icoIV];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.textColor = [UIColor ht_colorWithHexString:@"#ECECEC"];
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLabel];
    
    self.monthLabel = [[UILabel alloc] init];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel.textColor = [UIColor ht_colorWithHexString:@"#222222"];
    self.monthLabel.font = [UIFont boldSystemFontOfSize:12];
    [self.contentView addSubview:self.monthLabel];
    
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.textColor = [UIColor ht_colorWithHexString:@"#222222"];
    self.priceLabel.font = [UIFont boldSystemFontOfSize:28];
    [self.contentView addSubview:self.priceLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.textColor = [UIColor ht_colorWithHexString:@"#222222"];
    self.detailLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.detailLabel];

}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.icoIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.height.mas_equalTo(HTNum(24));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.icoIV);
        make.width.mas_lessThanOrEqualTo(60);
    }];
    
    [self.monthLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.equalTo(self.contentView);
        make.top.equalTo(self.icoIV.mas_bottom).offset(HTNum(14));
    }];
    
    [self.monthLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.equalTo(self.contentView);
        make.top.equalTo(self.icoIV.mas_bottom).offset(HTNum(14));
    }];
    
    [self.priceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(HTNum(33));
        make.width.equalTo(self.contentView);
        make.top.equalTo(self.monthLabel.mas_bottom).offset(HTNum(14));
    }];
    
    [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.width.equalTo(self.contentView);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(HTNum(11));
    }];
}

- (void)ht_updateCellWithData{
    if ([self.model isKindOfClass:BaseCellModel.class]) {
        NSDictionary *info = self.model.data;
        if (self.model.var_select) {
            if (self.model.var_activity) {
                [self.contentView ht_setGradualChangingColors:@[[UIColor ht_colorWithHexString:@"#FF1C1C"],[UIColor ht_colorWithHexString:@"#FF6D1C"]]];
            } else {
                [self.contentView ht_setGradualChangingColors:@[[UIColor ht_colorWithHexString:@"#EDC391"],[UIColor ht_colorWithHexString:@"#FDDDBB"]]];
            }
            self.contentView.gradientLayer.cornerRadius = HTNum(6);
        } else {
            [self.contentView.gradientLayer removeFromSuperlayer];
        }
        self.monthLabel.textColor = self.model.var_select ? [UIColor ht_colorWithHexString:@"#222222"] : [UIColor ht_colorWithHexString:@"#ECECEC"];
        self.priceLabel.textColor = self.model.var_select ? [UIColor ht_colorWithHexString:@"#222222"] : [UIColor ht_colorWithHexString:@"#ECECEC"];
        self.detailLabel.textColor = self.model.var_select ? [UIColor ht_colorWithHexString:@"#222222"] : [UIColor ht_colorWithHexString:@"#999999"];
        self.nameLabel.text = info[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]];
        self.icoIV.hidden = self.nameLabel.hidden = !info[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]];
        self.monthLabel.text = [LKFPrivateFunction lgjeropj_stringFillEmpty:self.model.var_title];
        self.priceLabel.text = [LKFPrivateFunction lgjeropj_stringFillEmpty:info[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]]];
        NSString *var_detailStr = [LKFPrivateFunction lgjeropj_stringFillEmpty:info[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]]];
        if ([var_detailStr containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$"]]) {
            self.detailLabel.attributedText = [[NSAttributedString alloc] initWithString:var_detailStr attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlineStylePatternSolid), NSFontAttributeName: self.detailLabel.font, NSForegroundColorAttributeName: self.detailLabel.textColor}];
        } else {
            self.detailLabel.attributedText = [[NSAttributedString alloc] initWithString:var_detailStr attributes:@{NSFontAttributeName: self.detailLabel.font, NSForegroundColorAttributeName: self.detailLabel.textColor}];
        }
    }
}

@end
