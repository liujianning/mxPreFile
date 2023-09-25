//
//  BaseCustomNaviView.m
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import "BaseCustomNaviView.h"
@implementation BaseCustomNaviView
{
    CGFloat _customContentH;
}

- (void)ht_setupViews
{
    [self addSubview:self.contentView];
    self.useStatusBar = YES;
    self.backgroundColor = [UIColor ht_colorWithHexString:@"#1A1C21"];
    [self.contentView addSubview:self.backBTN];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBTN.mas_right).offset(HTNum(10));
        make.right.mas_equalTo(-HTNum(44));
        make.centerY.mas_equalTo(0);
    }];
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.useStatusBar?HTNavigationStatusBar:0);
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(self.useStatusBar? self.customContentH: self.customContentHH?:88);
    }];
    
    [self.backBTN mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HTNum(20), HTNum(20)));
        make.left.mas_equalTo(HTNum(10));
        make.centerY.mas_equalTo(0);
    }];
}

- (void)ht_backAction
{
    //测试-待处理
//    UIViewController *vc = [HTWindowManage ht_getCurrentVC];
//    if (vc.presentingViewController) {
//        [vc dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [vc.navigationController popViewControllerAnimated:YES];
//    }
}

- (void)setCustomContentH:(CGFloat)customContentH
{
    _customContentH = customContentH;
    [self setNeedsUpdateConstraints];
}

- (void)setUseStatusBar:(BOOL)useStatusBar{
    _useStatusBar = useStatusBar;
    [self setNeedsUpdateConstraints];
}

- (CGFloat)customContentH{
    if (!_customContentH) {
        _customContentH = 44;
    }
    return _customContentH;
}

- (UIImageView *)backBTN{
    if (!_backBTN) {
        _backBTN = [[UIImageView alloc] init];
        _backBTN.image = [UIImage imageNamed:@"icon_back"];
        _backBTN.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ht_backAction)];
        [_backBTN addGestureRecognizer:tap];
    }
    return _backBTN;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColor.whiteColor;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        _nameLabel = label;
    }
    return _nameLabel;
}


@end
