//
//  BaseIconTextView.m
 
//
//  Created by 昊天 on 2023/7/12.
//

#import "BaseIconTextView.h"
#import "UIImageView+HTWebImage.h"
@interface BaseIconTextView ()

@property (nonatomic, assign) UIEdgeInsets var_iconInsets;
@property (nonatomic, assign) CGSize var_iconSize;
@property (nonatomic, assign) UIEdgeInsets var_titleInsets;
///0 左 1上 3右
@property (nonatomic, assign) NSInteger var_position;
@property (nonatomic, copy) NSString *var_image;
@property (nonatomic, copy) NSString *var_text;
@property (nonatomic, strong) UIColor *var_textColor;
@property (nonatomic, strong) UIFont *var_textFont;
@property (nonatomic, assign) NSTextAlignment var_textAligment;

@end

@implementation BaseIconTextView

- (instancetype)initWithFrame:(CGRect)frame andPosition:(NSInteger)var_position andTextAligment:(NSTextAlignment)var_aligment andTextFont:(UIFont *)var_font andTextColor:(UIColor *)var_color andText:(NSString *)var_text andImage:(NSString *)var_image andIconInsets:(UIEdgeInsets)var_iconInsets andTextInsets:(UIEdgeInsets)var_textInsets andIconSize:(CGSize)var_iconSize {
    self = [super initWithFrame:frame];
    if (self) {
        self.var_position = var_position;
        self.var_textAligment = var_aligment;
        self.var_textFont = var_font;
        self.var_textColor = var_color;
        self.var_text = var_text;
        self.var_image = var_image;
        self.var_iconInsets = var_iconInsets;
        self.var_titleInsets = var_textInsets;
        self.var_iconSize = var_iconSize;
        
        [self ht_setupViews];
    }
    return self;
}
- (void)ht_setupViews{
    self.icon = [[UIImageView alloc] init];
    [self addSubview:self.icon];
    
    self.label = [[UILabel alloc] init];
    [self addSubview:self.label];
    self.label.textAlignment = self.var_textAligment;
    self.label.font = self.var_textFont;
    self.label.textColor = self.var_textColor;
    self.label.numberOfLines = 0;
    
    if ([self.var_image hasPrefix:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"http"]]) {
        self.label.text = self.var_text;
        [self.icon ht_setImageWithURL:[NSURL URLWithString:self.var_image]];
    } else {
        self.label.text = self.var_text;
        self.icon.image = [UIImage imageNamed:self.var_image];
    }

    if (self.var_position == 1) {
        [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.var_iconInsets.top);
            make.bottom.mas_lessThanOrEqualTo(-self.var_iconInsets.bottom);
            make.size.mas_equalTo(self.var_iconSize);
        }];
        
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.var_titleInsets.left);
            make.right.mas_equalTo(-self.var_titleInsets.right);
            make.top.equalTo(self.icon.mas_bottom).offset(self.var_titleInsets.top);
            make.bottom.mas_lessThanOrEqualTo(-self.var_titleInsets.bottom);
        }];
    }else if (self.var_position == 3) {
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.var_titleInsets.left);
            make.right.equalTo(self.icon.mas_left).offset(-self.var_titleInsets.right);
            make.top.mas_equalTo(self.var_titleInsets.bottom);
            make.bottom.mas_lessThanOrEqualTo(-self.var_titleInsets.bottom);
        }];
        
        [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-self.var_iconInsets.right);
            make.size.mas_equalTo(self.var_iconSize);
        }];
    }else{
        [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.var_iconInsets.left);
            make.top.mas_equalTo(self.var_iconInsets.top);
            make.bottom.mas_lessThanOrEqualTo(-self.var_iconInsets.bottom);
            make.size.mas_equalTo(self.var_iconSize);
        }];
        
        [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(self.var_titleInsets.left);
            make.right.mas_equalTo(-self.var_titleInsets.right);
            make.top.mas_equalTo(self.var_titleInsets.top);
            make.height.mas_greaterThanOrEqualTo(self.var_iconSize.height);
            make.bottom.mas_lessThanOrEqualTo(-self.var_titleInsets.bottom);
        }];
    }
}

@end
