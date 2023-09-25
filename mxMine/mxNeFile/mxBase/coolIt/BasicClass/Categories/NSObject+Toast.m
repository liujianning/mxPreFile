//
//  NSObject+Toast.m
 
//
//  Created by 李雪健 on 2023/7/6.
//

#import "NSObject+Toast.h"
#import "UIView+Toast.h"

@implementation NSObject (Toast)

- (void)lgjeropj_showHint:(NSString *)message {
    
    [self lgjeropj_showHint:message superView:HTWindow];
}

- (void)lgjeropj_showHint:(NSString *)message superView:(UIView *)superView {
    
    CSToastStyle *style = [CSToastManager sharedStyle];
    style.titleAlignment = NSTextAlignmentCenter;
    style.messageAlignment = NSTextAlignmentCenter;
    [CSToastManager setSharedStyle:style];
    [superView makeToast:message duration:3.0 position:CSToastPositionCenter];
}

- (void)lgjeropj_showLoading {
    
    [self lgjeropj_showLoadingForSuperView:HTWindow];
}

- (void)lgjeropj_showLoadingForSuperView:(UIView *)superView {
    
    [CSToastManager setTapToDismissEnabled:NO];
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 12;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    CGSize size = CGSizeMake(60, 60);
    view.frame = CGRectMake(0, 0, size.width, size.height);
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityView startAnimating];
    activityView.frame = CGRectMake(5, 5, 50, 50);
    [view addSubview:activityView];
    [superView showToast:view duration:[[NSDate date] timeIntervalSince1970] position:CSToastPositionCenter completion:nil];
}

- (void)lgjeropj_hideLoading {
    
    [self lgjeropj_hideLoadingForSuperView:HTWindow];
}

- (void)lgjeropj_hideLoadingForSuperView:(UIView *)superView {
    
    [superView hideAllToasts];
}

@end
