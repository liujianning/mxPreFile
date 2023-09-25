//
//  UIButton+ImagePosition.h
 
//  Created by admin on 2019/8/21.
//  Copyright © 2019年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, ENUM_HTButtonImagePositionStyle) {
    ENUM_HTButtonImagePositionStyleTop, // image在上，label在下
    ENUM_HTButtonImagePositionStyleLeft, // image在左，label在右
    ENUM_HTButtonImagePositionStyleBottom, // image在下，label在上
    ENUM_HTButtonImagePositionStyleRight // image在右，label在左
};
//使用需设置button的宽高
@interface UIButton (ImagePosition)

/* 设置button的titleLabel和imageView的布局样式，及间距 */
- (void)ht_layoutButtonWithImagePositionStyle:(ENUM_HTButtonImagePositionStyle)style andImageTitleSpace:(CGFloat)space;

- (void)ht_setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state;

- (void)ht_setImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state andComplete:(void(^_Nullable)(UIImage  * _Nullable image))completed;

- (void)ht_setBackgroundImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state;

- (void)ht_setBackgroundImageWithURL:(NSURL * _Nullable)url forState:(UIControlState)state andComplete:(void(^_Nullable)(UIImage  * _Nullable image))completed;
@end
