

#import <Foundation/Foundation.h>
#import "SROrientationObserver.h"
#import "SRLandscapeWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRLandscapeRotationManager : NSObject

@property (nonatomic, copy, nullable) void(^orientationWillChange)(UIInterfaceOrientation orientation);

@property (nonatomic, copy, nullable) void(^orientationDidChanged)(UIInterfaceOrientation orientation);

@property (nonatomic, weak) UIView *contentView;

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, strong, nullable) SRLandscapeWindow *window;

@property (nonatomic, assign) BOOL allowOrientationRotation;

@property (nonatomic, getter=isLockedScreen) BOOL lockedScreen;

@property (nonatomic, assign) BOOL disableAnimations;

@property (nonatomic, assign) SRInterfaceOrientationMask supportInterfaceOrientation;

@property (nonatomic, assign) UIInterfaceOrientation currentOrientation;

@property (nonatomic, strong, readonly, nullable) SRLandscapeViewController *landscapeViewController;

@property (nonatomic, assign) BOOL activeDeviceObserver;

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation completion:(void(^ __nullable)(void))completion;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;

- (UIInterfaceOrientation)getCurrentOrientation;

- (void)handleDeviceOrientationChange;

- (void)updateRotateView:(SRPeriodView *)rotateView
           containerView:(UIView *)containerView;

- (UIView *)fullScreenContainerView;

- (BOOL)isSuppprtInterfaceOrientation:(UIInterfaceOrientation)orientation;

+ (SRInterfaceOrientationMask)supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window;

@end

NS_ASSUME_NONNULL_END
