//
//  NSObject+Toast.h
 
//
//  Created by 李雪健 on 2023/7/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Toast)

- (void)lgjeropj_showHint:(NSString *)message;

- (void)lgjeropj_showLoading;

- (void)lgjeropj_hideLoading;

- (void)lgjeropj_showHint:(NSString *)message superView:(UIView *)superView;

- (void)lgjeropj_showLoadingForSuperView:(UIView *)superView;

- (void)lgjeropj_hideLoadingForSuperView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
