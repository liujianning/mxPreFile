//
//  MeNormalCell.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "MeNormalCell.h"
#import "LKFPrivateFunction.h"
#import "UIImageView+HTWebImage.h"
#import "HTMutilangManager.h"

@interface MeNormalCell()
@property(nonatomic,strong)UIImageView *iconIV;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *var_moreIV;
@end

@implementation MeNormalCell

- (void)ht_addCellSubViews{
    self.iconIV = [[UIImageView alloc] init];
    self.var_moreIV = [[UIImageView alloc] init];
    self.var_moreIV.tintColor = [UIColor ht_colorWithHexString:@"#8A8A8A"];
    [self.var_moreIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:66] andComplete:^(UIImage * _Nullable image) {
        self.var_moreIV.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.var_moreIV.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    [self.contentView addSubview:self.iconIV];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.var_moreIV];
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.iconIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HTNum(16), HTNum(16)));
        make.left.mas_equalTo(HTNum(10));
        make.centerY.mas_equalTo(0);
    }];
    
    [self.var_moreIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HTNum(24), HTNum(24)));
        make.right.mas_equalTo(-HTNum(10));
        make.centerY.mas_equalTo(0);
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HTNum(15));
        make.height.mas_greaterThanOrEqualTo(HTNum(24));
        make.bottom.mas_equalTo(-HTNum(15));
        make.left.equalTo(self.iconIV.mas_right).offset(HTNum(6));
        make.right.equalTo(self.var_moreIV.mas_left);
    }];
}

- (void)ht_updateCellWithData{
    self.nameLabel.text = [LKFPrivateFunction lgjeropj_stringFillEmpty:self.model.var_title];
    if ([self.model.image isKindOfClass:[UIImage class]]) {
        self.iconIV.image = self.model.image;
    } else if ([self.model.image isKindOfClass:[NSString class]]) {
        if ([self.model.image hasPrefix:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"http"]]) {
            [self.iconIV ht_setImageWithURL:[NSURL URLWithString:self.model.image]];
        } else {
            self.iconIV.image = [UIImage imageNamed:self.model.image];
        }
    }
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.whiteColor;
        label.font = [UIFont boldSystemFontOfSize:15];
        label.text = LocalString(@"Watch Later", nil);
        _nameLabel = label;
    }
    return _nameLabel;
}

@end
