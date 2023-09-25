//
//  BaseIconTextView.h
 
//
//  Created by 昊天 on 2023/7/12.
//

#import "SRBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseIconTextView : SRBaseView
@property (nonatomic,strong) UIImageView *icon;
@property (nonatomic,strong) UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame andPosition:(NSInteger)var_position andTextAligment:(NSTextAlignment)var_aligment andTextFont:(UIFont *)var_font andTextColor:(UIColor *)var_color andText:(NSString *)var_text andImage:(NSString *)var_image andIconInsets:(UIEdgeInsets)var_iconInsets andTextInsets:(UIEdgeInsets)var_textInsets andIconSize:(CGSize)var_iconSize;

@end

NS_ASSUME_NONNULL_END
