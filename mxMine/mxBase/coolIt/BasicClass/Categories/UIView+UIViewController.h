//
//  UIView+UIViewController.h
 
//  Created by admin on 2020/12/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (UIViewController)

@property (nonatomic,strong) CAGradientLayer *gradientLayer;

- (UIViewController *)viewController;

+ (instancetype)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor toView:(UIView *)toView;

- (CAGradientLayer*)ht_setGradualChangingColors:(NSArray<UIColor *> *)colors;

- (CAGradientLayer*)ht_setGradualChangingColors:(NSArray<UIColor *> *)colors andStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
