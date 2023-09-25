//
//  PreiumBottomItemView.m
//  Movie
//
//  Created by wmz on 2023/2/21.
//

#import "PreiumBottomItemView.h"
#import "HTCommonConfiguration.h"

@implementation PreiumBottomItemView

- (void)ht_setupViews{
    self.pointView = [[UIView alloc] init];
    self.pointView.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#ECECEC"].CGColor;
    self.pointView.layer.cornerRadius = HTNum(3);
    [self addSubview:self.pointView];
    [self.pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_lessThanOrEqualTo(HTNum(3));
        make.width.height.mas_equalTo(HTNum(6));
    }];
    
    self.nameLabel = [[YYLabel alloc] init];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.preferredMaxLayoutWidth = HTNum(327);
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pointView.mas_right).offset(HTNum(6));
        make.right.top.mas_equalTo(0);
        make.bottom.mas_lessThanOrEqualTo(-HTNum(10));
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:self.content];
        mstr.yy_color = [UIColor ht_colorWithHexString:@"#999999"];
        mstr.yy_lineSpacing = HTNum(4);
        mstr.yy_font = [UIFont systemFontOfSize:12];
        if (self.freStr) {
            NSRange range = [mstr.string rangeOfString:self.freStr];
            [mstr yy_setFont:[UIFont systemFontOfSize:12] range:range];
            [mstr yy_setColor:[UIColor ht_colorWithHexString:@"#ECECEC"] range:range];
            if (self.pushWeb) {
                [mstr yy_setUnderlineStyle:NSUnderlineStyleSingle range:range];
            }
            __weak typeof(self) weakSelf = self;
            [mstr yy_setTextHighlightRange:range color:[UIColor ht_colorWithHexString:@"#FFFFFF"] backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if (weakSelf.pushWeb && weakSelf.webTitle) {
                    HTCommonConfiguration.lgjeropj_shared.BLOCK_toWebUrlBlock(weakSelf.webTitle);
                }
            }];
        }
        self.nameLabel.attributedText = mstr;
    }
}

@end
