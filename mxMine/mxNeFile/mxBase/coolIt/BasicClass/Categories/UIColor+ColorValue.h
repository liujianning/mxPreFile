//
//  UIColor+ColorValue.h
 
//  Created by admin on 13-7-10.
//  Copyright (c) 2013年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorValue)

typedef NS_ENUM(NSInteger, ENUM_ShadeChangeDirection) {
    
    ENUM_ShadeChangeDirectionLevel,
    ENUM_ShadeChangeDirectionVertical,
    ENUM_ShadeChangeDirectionUpwardDiagonalLine,
    ENUM_ShadeChangeDirectionDownDiagonalLine,
};

+ (UIColor *)colorGradientChangeWithSize:(CGSize)size
                            andDirection:(ENUM_ShadeChangeDirection)direction
                           andStartColor:(UIColor *)startcolor
                             andEndColor:(UIColor *)endColor;

+ (UIColor *)ht_colorWithHexString:(NSString *)color;
+ (UIColor *)ht_colorWithHexString:(NSString *)color andAlpha:(CGFloat)alpha;

@end
