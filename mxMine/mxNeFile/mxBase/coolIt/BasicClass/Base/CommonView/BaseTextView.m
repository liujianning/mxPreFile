//
//  BaseTextView.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "BaseTextView.h"
@interface BaseTextView()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *placeLabel;
@end

@implementation BaseTextView
- (void)ht_setupViews{
    self.itemHeight = HTNum(185);
    
    self.nameLabel = [[UILabel alloc] init];
    [self addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
    self.nameLabel.textColor = UIColor.whiteColor;
    self.nameLabel.hidden = YES;
    
    self.textView = [[UITextView alloc] init];
    [self addSubview:self.textView];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.scrollEnabled = NO;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.textColor = UIColor.whiteColor;
    self.textView.backgroundColor = UIColor.clearColor;
    self.textView.delegate = self;
    
    self.placeLabel = [[UILabel alloc] init];
    [self addSubview:self.placeLabel];
    self.placeLabel.font = [UIFont boldSystemFontOfSize:14];
    self.placeLabel.textColor = [UIColor ht_colorWithHexString:@"#969696"];
    self.placeLabel.numberOfLines = 0;
    self.placeLabel.hidden = YES;
    
    self.layer.backgroundColor = [UIColor ht_colorWithHexString:@"#23252A"].CGColor;
    self.layer.cornerRadius = HTNum(6);
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.nameLabel.isHidden) {
            make.top.mas_equalTo(HTNum(20));
            make.left.mas_equalTo(HTNum(10));
        }
    }];
    
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.nameLabel.isHidden) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(HTNum(3));
        } else {
            make.top.mas_equalTo(HTNum(20));
        }
        make.left.mas_equalTo(HTNum(3));
        make.right.mas_equalTo(-HTNum(10));
        make.height.mas_greaterThanOrEqualTo(self.itemHeight);
        make.bottom.mas_lessThanOrEqualTo(0);
    }];
    
    [self.placeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HTNum(10));
        make.right.mas_equalTo(-HTNum(10));
        make.top.equalTo(self.textView.mas_top).offset(HTNum(7));
    }];
    
}

- (void)textViewDidChange:(UITextView *)textView{
    self.placeLabel.hidden = textView.text ? YES : NO;
    if (self.var_textChangeBlock) {
        self.var_textChangeBlock(textView);
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.nameLabel.text = title;
    self.nameLabel.hidden = title?NO:YES;
    [self setNeedsUpdateConstraints];
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    self.placeLabel.text = placeHolder;
    self.placeLabel.hidden = placeHolder ? NO : YES;
    [self setNeedsUpdateConstraints];
}

@end
