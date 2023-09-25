//
//  UIView+UIViewController.m
 
//  Created by admin on 2020/12/21.
//

#import "UIView+UIViewController.h"

@implementation UIView (UIViewController)

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer
{
    objc_setAssociatedObject(self, &STATIC_GradientKey, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientLayer
{
    return objc_getAssociatedObject(self, &STATIC_GradientKey);
}

- (CAGradientLayer*)ht_setGradualChangingColors:(NSArray<UIColor *> *)colors
{
   return [self ht_setGradualChangingColors:colors andStartPoint:CGPointMake(0, 0) andEndPoint:CGPointMake(1, 0)];
}

- (CAGradientLayer*)ht_setGradualChangingColors:(NSArray<UIColor *> *)colors andStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint
{
    [self layoutIfNeeded];
    if (!self.gradientLayer && self.bounds.size.width)
    {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.name = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"bg"];
        gradientLayer.frame = self.bounds;
        NSMutableArray *cgColors = [NSMutableArray array];
        [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [cgColors addObject:(__bridge id)obj.CGColor];
        }];
        gradientLayer.colors = cgColors;
        gradientLayer.startPoint = startPoint;
        gradientLayer.endPoint = endPoint;
        gradientLayer.locations = @[@0, @1];
        self.gradientLayer = gradientLayer;
    }
    [self.layer insertSublayer:self.gradientLayer atIndex:0];
    return self.gradientLayer;
}

- (UIViewController *)viewController {
    
    //通过响应者链关系，取得此视图的下一个响应者
    UIResponder *next = self.nextResponder;
    
    do {
        
        //判断响应者对象是否是视图控制器类型
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
        
    }while(next != nil);
    
    
    return nil;
}

+ (instancetype)viewWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor toView:(UIView *)toView
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    if (toView) {
        [toView addSubview:view];
    }
    
    return view;
}

@end
