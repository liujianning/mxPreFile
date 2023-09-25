//
//  CommonMovieItemCell.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "CommonMovieItemCell.h"
#import "UIImageView+HTWebImage.h"
#import "HTCommonConfiguration.h"
#import "YYText.h"
#import "LKFPrivateFunction.h"
#import "UIColor+ColorValue.h"
#import "Masonry.h"
#import "PostCommon_Config.h"
#import "MovieModel.h"



@interface CommonMovieItemCell()
@property (nonatomic,strong) UIImageView *playIV;
@property (nonatomic,strong) UIImageView *movieIV;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) YYLabel *statusLabel;
@property (nonatomic,strong) UILabel *contenLabel;
@property (nonatomic,strong) UILabel *camLabel;
@property (nonatomic,strong) UIImageView *shadomView;
@end
@implementation CommonMovieItemCell
- (void)ht_addCellSubViews{
    self.shadomView = [[UIImageView alloc] init];
    [self.shadomView ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:37]];
    self.shadomView.hidden = YES;
    self.playIV = [[UIImageView alloc] init];
    self.movieIV = [[UIImageView alloc] init];
    self.movieIV.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#23252A"].CGColor;
    self.movieIV.contentMode = UIViewContentModeScaleAspectFill;
    self.movieIV.clipsToBounds = YES;
    self.movieIV.layer.cornerRadius = 6;
    self.playIV.backgroundColor = [UIColor ht_colorWithHexString:@"#23252A" andAlpha:0.5];
    [self.playIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:103] andComplete:^(UIImage * _Nullable image) {
        self.playIV.layer.cornerRadius = 15;
        self.playIV.clipsToBounds = YES;
    }];
    [self.contentView addSubview:self.movieIV];
    [self.contentView addSubview:self.playIV];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.camLabel];
    [self.contentView addSubview:self.shadomView];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.contenLabel];
    self.contentView.backgroundColor = UIColor.clearColor;
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ht_tapAction)];
    [self.contentView addGestureRecognizer:ta];
}

- (void)ht_tapAction{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_commonMovieItemCellTapActionBlock (self.model, self.indexPath, self.var_movielist_id, self.list_type, self.var_source, self.var_like);
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.movieIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.model.var_itemSize.height ? self.model.var_itemSize.height: HTNumB(120));
        make.bottom.mas_lessThanOrEqualTo(0);
    }];
    
    [self.playIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.equalTo(self.movieIV);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(HTNumB(5));
    }];
    
    [self.contenLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNumB(7));
        make.right.mas_equalTo(-HTNumB(7));
        make.top.equalTo(self.movieIV.mas_bottom).offset(HTNumB(5));
    }];
    
    [self.camLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(HTNumB(7));
        make.right.mas_equalTo(-HTNumB(7));
        make.size.mas_equalTo(CGSizeMake(35, 20));
    }];
    
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(HTNumB(24));
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.bottom.equalTo(self.movieIV.mas_bottom);
    }];
    
    [self.shadomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.statusLabel);
    }];
}

- (void)ht_updateCellWithData{
    if ([self.model isKindOfClass:MovieModel.class]) {
        MovieModel *var_movieModel = (MovieModel*)self.model;
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[LKFPrivateFunction lgjeropj_stringFillEmpty:var_movieModel.var_rate]];
        mstr.yy_color = [UIColor ht_colorWithHexString:@"#FF6D1C"];
        mstr.yy_font = [UIFont boldSystemFontOfSize:20];
        if (mstr.string.length > 1) {
            [mstr yy_setFont:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(1, mstr.string.length - 1)];
        }
        self.nameLabel.attributedText = mstr;
        self.contenLabel.text = [LKFPrivateFunction lgjeropj_stringFillEmpty:var_movieModel.var_title];
        [self.movieIV ht_setImageWithURL:[NSURL URLWithString:var_movieModel.var_cover]];
        self.camLabel.hidden = ![var_movieModel.var_quality isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"CAM"]];
        self.playIV.hidden = !var_movieModel.var_showPlay;
        NSMutableAttributedString *statusStr = [[NSMutableAttributedString alloc] init];
        BOOL flag = NO;
        if ([LKFPrivateFunction lgjeropj_isNotEmpty:var_movieModel.var_ss_eps]) {
            if ([var_movieModel.var_new_flag isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"NEW"]]) {
                NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc]initWithString:var_movieModel.var_new_flag];
                newStr.yy_font = [UIFont boldSystemFontOfSize:12];
                newStr.yy_color = [UIColor ht_colorWithHexString:@"#FF6D1C"];
                [statusStr appendAttributedString:newStr];

                NSMutableAttributedString *lineStr = [[NSMutableAttributedString alloc]initWithString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@" | "]];
                lineStr.yy_color = [UIColor ht_colorWithHexString:@"#ECECEC"];
                lineStr.yy_font = [UIFont boldSystemFontOfSize:12];
                [statusStr appendAttributedString:lineStr];
            }
            NSMutableAttributedString *newStr = [[NSMutableAttributedString alloc]initWithString:var_movieModel.var_ss_eps];
            newStr.yy_font = [UIFont boldSystemFontOfSize:12];
            newStr.yy_color = [UIColor ht_colorWithHexString:@"#ECECEC"];
            [statusStr appendAttributedString:newStr];
            flag = YES;
        }
        if (flag) {
            UIView *imgView3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HTNumB(5), HTNumB(5))];
            NSMutableAttributedString *attchText3 = [NSMutableAttributedString yy_attachmentStringWithContent:imgView3  contentMode:UIViewContentModeScaleAspectFit attachmentSize:imgView3.frame.size alignToFont:[UIFont boldSystemFontOfSize:12] alignment:YYTextVerticalAlignmentCenter];
            [statusStr appendAttributedString:attchText3];
        }
        self.shadomView.hidden = !flag;
        self.statusLabel.hidden = !flag;
        statusStr.yy_alignment = NSTextAlignmentRight;
        self.statusLabel.attributedText = statusStr;
        [self setNeedsUpdateConstraints];
    }
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)camLabel{
    if (!_camLabel) {
        _camLabel = [[UILabel alloc] init];
        _camLabel.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#000000"].CGColor;
        _camLabel.textAlignment = NSTextAlignmentCenter;
        _camLabel.layer.cornerRadius = 2;
        _camLabel.textColor = [UIColor ht_colorWithHexString:@"#ffffff"];
        _camLabel.font = [UIFont systemFontOfSize:13];
        _camLabel.hidden = YES;
        _camLabel.text = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"CAM"];
    }
    return _camLabel;
}

- (UILabel *)contenLabel{
    if (!_contenLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12];
        label.numberOfLines = 2;
        label.textColor = [UIColor ht_colorWithHexString:@"#828386"];
        _contenLabel = label;
    }
    return _contenLabel;
}

- (YYLabel *)statusLabel{
    if (!_statusLabel) {
        YYLabel *label = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, HTNumB(24))];
        label.hidden = YES;
        _statusLabel = label;
    }
    return _statusLabel;
}

@end
