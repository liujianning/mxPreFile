//
//  HistoryCell.m
//  Movie
//
//  Created by wmz on 2023/2/13.
//

#import "HistoryCell.h"
#import "MovieModel.h"
#import "LKFPrivateFunction.h"
#import "UIImageView+HTWebImage.h"
#import "YYText.h"
#import "UIButton+ImagePosition.h"
#import "HTMutilangManager.h"
#import "HTCommonConfiguration.h"

@interface HistoryCell()

@property (nonatomic,strong) UILabel *stepLabel;
@property (nonatomic,strong) UILabel *contenLabel;
@property (nonatomic,strong) UIImageView *playIV;
@property (nonatomic,strong) UIImageView *movieIV;
@property (nonatomic,strong) UIButton *selectBTN;

@end

@implementation HistoryCell

- (void)ht_addCellSubViews
{
    self.playIV = [[UIImageView alloc] init];
    self.movieIV = [[UIImageView alloc] init];
    self.movieIV.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#23252A"].CGColor;
    self.movieIV.contentMode = UIViewContentModeScaleAspectFill;
    self.movieIV.clipsToBounds = YES;
    self.movieIV.layer.cornerRadius = 6;
    self.playIV.backgroundColor = [UIColor ht_colorWithHexString:@"#23252A" andAlpha:0.5];
    [self.playIV ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:103] andComplete:^(UIImage * _Nullable image) {
        self.playIV.layer.cornerRadius = 17.5;
        self.playIV.clipsToBounds = YES;
    }];
    [self.contentView addSubview:self.stepLabel];
    [self.contentView addSubview:self.contenLabel];
    [self.contentView addSubview:self.movieIV];
    [self.contentView addSubview:self.playIV];
    [self.contentView addSubview:self.selectBTN];
    UITapGestureRecognizer *ta = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ht_tapAction)];
    [self.contentView addGestureRecognizer:ta];
}

- (void)ht_tapAction{
    HTCommonConfiguration.lgjeropj_shared.BLOCK_toPlayMovieBlock(self.model, self.source);
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.movieIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNum(10));
        make.top.mas_equalTo(HTNum(15));
        make.width.mas_equalTo(HTNum(93));
        make.height.mas_equalTo(self.model.var_itemSize.height ? : HTNum(120));
        make.bottom.mas_lessThanOrEqualTo(0);
    }];
    
    [self.playIV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.movieIV);
        make.width.height.mas_equalTo(35);
    }];
    
    [self.stepLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contenLabel);
        make.bottom.equalTo(self.movieIV.mas_bottom).offset(HTNum(-10));
    }];
    
    [self.contenLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.movieIV.mas_right).offset(HTNum(10));
        make.right.mas_equalTo(-HTNum(10));
        make.top.equalTo(self.movieIV.mas_top).offset(HTNum(10));
        make.bottom.mas_lessThanOrEqualTo(0);
    }];
    
    [self.selectBTN sizeToFit];
    [self.selectBTN mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.selectBTN.isHidden) {
            make.right.mas_equalTo(-HTNum(10));
            make.centerY.mas_equalTo(0);
        }
    }];
}

- (void)ht_updateCellWithData{
    if ([self.model isKindOfClass:MovieModel.class]) {
        MovieModel *var_movieModel = (MovieModel*)self.model;
        NSString *step = [NSString stringWithFormat:@"%zd%@",var_movieModel.var_step,@"%"];
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",LocalString(@"Watched", nil),step]];
        mstr.yy_color = [UIColor ht_colorWithHexString:@"#828386"];
        mstr.yy_font = [UIFont systemFontOfSize:12];
        NSRange range = [mstr.string rangeOfString:step];
        [mstr yy_setColor:[UIColor ht_colorWithHexString:@"#3CDEF4"] range:range];
        [mstr yy_setFont:[UIFont boldSystemFontOfSize:14] range:range];
        self.stepLabel.attributedText = mstr;
        self.contenLabel.text = var_movieModel.var_title;
        [self.movieIV ht_setImageWithURL:[NSURL URLWithString:var_movieModel.var_cover]];
        self.selectBTN.hidden = !self.model.var_show;
        self.selectBTN.selected = self.model.var_select;
        self.stepLabel.hidden = self.model.var_hideStatus;
        [self setNeedsUpdateConstraints];
    }
}

- (void)ht_selectAction{
    self.model.var_select = !self.model.var_select;
    self.selectBTN.selected = self.model.var_select;
    if (self.block) {
        self.block(self.model);
    }
}

- (UIButton *)selectBTN{
    if (!_selectBTN) {
        _selectBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBTN ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:82] forState:UIControlStateNormal];
        [_selectBTN ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:81] forState:UIControlStateSelected];
        _selectBTN.hidden = true;
        _selectBTN.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        [_selectBTN addTarget:self action:@selector(ht_selectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBTN;
}

- (UILabel *)stepLabel{
    if (!_stepLabel) {
        UILabel *label = [[UILabel alloc] init];
        _stepLabel = label;
    }
    return _stepLabel;
}

- (UILabel *)contenLabel{
    if (!_contenLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 2;
        label.textColor = [UIColor ht_colorWithHexString:@"#ECECEC"];
        _contenLabel = label;
    }
    return _contenLabel;
}

@end
