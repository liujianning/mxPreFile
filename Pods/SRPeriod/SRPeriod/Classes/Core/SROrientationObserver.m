
//  SROrentationObserver.m
//  SRPrimaryStage
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SROrientationObserver.h"
#import "SRLandscapeWindow.h"
#import "SRPortraitViewController.h"
#import "SRPrimaryConst.h"
#import <objc/runtime.h>
#import "SRLandscapeRotationManager_iOS15.h"
#import "SRLandscapeRotationManager_iOS16.h"

@interface UIWindow (CurrentViewController)

/*!
 @method currentViewController
 @return Returns the topViewController in stack of topMostController.
 */
+ (UIViewController*)zf_currentViewController;

@end

@implementation UIWindow (CurrentViewController)

+ (UIViewController*)zf_currentViewController {
    __block UIWindow *window;
    if (@available(iOS 13, *)) {
        [[UIApplication sharedApplication].connectedScenes enumerateObjectsUsingBlock:^(UIScene * _Nonnull scene, BOOL * _Nonnull scenesStop) {
            if ([scene isKindOfClass: [UIWindowScene class]]) {
                UIWindowScene * windowScene = (UIWindowScene *)scene;
                [windowScene.windows enumerateObjectsUsingBlock:^(UIWindow * _Nonnull windowTemp, NSUInteger idx, BOOL * _Nonnull windowStop) {
                    if (windowTemp.isKeyWindow) {
                        window = windowTemp;
                        *windowStop = YES;
                        *scenesStop = YES;
                    }
                }];
            }
        }];
    } else {
        window = [[UIApplication sharedApplication].delegate window];
    }
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController *)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

@end

@interface SROrientationObserver ()  

@property (nonatomic, weak) SRPeriodView *view;

@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;

@property (nonatomic, strong) SRPortraitViewController *portraitViewController;

@property (nonatomic, strong) SRLandscapeRotationManager *landscapeRotationManager;

/// current device orientation observer is activie.
@property (nonatomic, assign) BOOL activeDeviceObserver;

@end

@implementation SROrientationObserver
@synthesize verySize = _verySize;

- (instancetype)init {
    self = [super init];
    if (self) {
        _duration = 0.30;
        _fulfilledMode = SRFineScheduleModeLandscape;
        _portraitFulfilledMode = SRPortraitFineScheduleModeScaleToFill;
        _disablePortraitGestureTypes = SRDecidePeriodGardenTypesAll;
        self.supportInterfaceOrientation = SRInterfaceOrientationMaskAllButUpsideDown;
        self.allowOrientationRotation = YES;
        self.activeDeviceObserver = YES;
    }
    return self;
}

- (void)updateRotateView:(SRPeriodView *)rotateView
           containerView:(UIView *)containerView {
    self.view = rotateView;
    self.containerView = containerView;
    [self.landscapeRotationManager updateRotateView:rotateView containerView:containerView];
}


- (void)dealloc {
    [self removeDeviceOrientationObserver];
}

- (void)addDeviceOrientationObserver {
    if (self.allowOrientationRotation) {
        self.activeDeviceObserver = YES;
        if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
            [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

- (void)removeDeviceOrientationObserver {
    self.activeDeviceObserver = NO;
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)handleDeviceOrientationChange {
    if (self.fulfilledMode == SRFineScheduleModePortrait || !self.allowOrientationRotation) return;
    [self.landscapeRotationManager handleDeviceOrientationChange];
}

#pragma mark - public

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated {
    [self rotateToOrientation:orientation animated:animated completion:nil];
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion {
    if (self.fulfilledMode == SRFineScheduleModePortrait) return;
    [self.landscapeRotationManager rotateToOrientation:orientation animated:animated completion:completion];
}

- (void)enterPortraitFineExample:(BOOL)example animated:(BOOL)animated {
    [self enterPortraitFineExample:example animated:animated completion:nil];
}

- (void)enterPortraitFineExample:(BOOL)example animated:(BOOL)animated completion:(void(^ __nullable)(void))completion {
    self.fullScreen = example;
    if (example) {
        self.portraitViewController.contentView = self.view;
        self.portraitViewController.containerView = self.containerView;
        self.portraitViewController.duration = self.duration;
        if (self.portraitFulfilledMode == SRPortraitFineScheduleModeScaleAspectFit) {
            self.portraitViewController.verySize = self.verySize;
        } else if (self.portraitFulfilledMode == SRPortraitFineScheduleModeScaleToFill) {
            self.portraitViewController.verySize = CGSizeMake(SRPrimaryStageScreenWidth, SRPrimaryStageScreenHeight);
        }
        self.portraitViewController.fullScreenAnimation = animated;
        [[UIWindow zf_currentViewController] presentViewController:self.portraitViewController animated:NO completion:^{
            if (completion) completion();
        }];
    } else {
        self.portraitViewController.fullScreenAnimation = animated;
        [self.portraitViewController dismissViewControllerAnimated:NO completion:^{
            if (completion) completion();
        }];
    }
}

- (void)enterFineExample:(BOOL)example animated:(BOOL)animated {
    [self enterFineExample:example animated:animated completion:nil];
}

- (void)enterFineExample:(BOOL)example animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion {
    if (self.fulfilledMode == SRFineScheduleModePortrait) {
        [self enterPortraitFineExample:example animated:animated completion:completion];
    } else {
        UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
        orientation = example? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait;
        [self rotateToOrientation:orientation animated:animated completion:completion];
    }
}

#pragma mark - getter

- (SRPortraitViewController *)portraitViewController {
    if (!_portraitViewController) {
        @zf_weakify(self)
        _portraitViewController = [[SRPortraitViewController alloc] init];
        if (@available(iOS 9.0, *)) {
            [_portraitViewController loadViewIfNeeded];
        } else {
            [_portraitViewController view];
        }
        _portraitViewController.orientationWillChange = ^(BOOL isFullScreen) {
            @zf_strongify(self)
            self.fullScreen = isFullScreen;
            if (self.orientationWillChange) self.orientationWillChange(self, isFullScreen);
        };
        _portraitViewController.orientationDidChanged = ^(BOOL isFullScreen) {
            @zf_strongify(self)
            self.fullScreen = isFullScreen;
            if (self.orientationDidChanged) self.orientationDidChanged(self, isFullScreen);
        };
    }
    return _portraitViewController;
}

- (SRLandscapeRotationManager *)landscapeRotationManager {
    if (!_landscapeRotationManager) {
        if (@available(iOS 16.0, *)) {
            _landscapeRotationManager = [[SRLandscapeRotationManager_iOS16 alloc] init];
        } else {
            _landscapeRotationManager = [[SRLandscapeRotationManager_iOS15 alloc] init];
        }
        @zf_weakify(self)
        _landscapeRotationManager.orientationWillChange = ^(UIInterfaceOrientation orientation) {
            @zf_strongify(self)
            self.fullScreen = UIInterfaceOrientationIsLandscape(orientation);
            if (self.orientationWillChange) self.orientationWillChange(self, self.fullScreen);
        };
        _landscapeRotationManager.orientationDidChanged = ^(UIInterfaceOrientation orientation) {
            @zf_strongify(self)
            self.fullScreen = UIInterfaceOrientationIsLandscape(orientation);
            if (self.orientationDidChanged) self.orientationDidChanged(self, self.fullScreen);
        };
    }
    return _landscapeRotationManager;
}

- (UIView *)fullScreenContainerView {
    if (self.fulfilledMode == SRFineScheduleModeLandscape) {
        return self.landscapeRotationManager.fullScreenContainerView;
    } else if (self.fulfilledMode == SRFineScheduleModePortrait) {
        return self.portraitViewController.view;
    }
    return nil;
}

- (UIInterfaceOrientation)currentOrientation {
    if (self.fulfilledMode == SRFineScheduleModeLandscape) {
        return self.landscapeRotationManager.currentOrientation;
    }
    return [self.landscapeRotationManager getCurrentOrientation];
}

#pragma mark - setter

- (void)setLockedScreen:(BOOL)lockedScreen {
    _lockedScreen = lockedScreen;
    self.landscapeRotationManager.lockedScreen = lockedScreen;
    if (lockedScreen) {
        [self removeDeviceOrientationObserver];
    } else {
        [self addDeviceOrientationObserver];
    }
}

- (void)setFullScreen:(BOOL)fullScreen {
    _fullScreen = fullScreen;
    [self.landscapeRotationManager.landscapeViewController setNeedsStatusBarAppearanceUpdate];
    [UIViewController attemptRotationToDeviceOrientation];
}

- (void)setFullScreenStatusBarHidden:(BOOL)fullScreenStatusBarHidden {
    _fullScreenStatusBarHidden = fullScreenStatusBarHidden;
    if (self.fulfilledMode == SRFineScheduleModePortrait) {
        self.portraitViewController.statusBarHidden = fullScreenStatusBarHidden;
        [self.portraitViewController setNeedsStatusBarAppearanceUpdate];
    } else if (self.fulfilledMode == SRFineScheduleModeLandscape) {
        self.landscapeRotationManager.landscapeViewController.statusBarHidden = fullScreenStatusBarHidden;
        [self.landscapeRotationManager.landscapeViewController setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)setFullScreenStatusBarStyle:(UIStatusBarStyle)fullScreenStatusBarStyle {
    _fullScreenStatusBarStyle = fullScreenStatusBarStyle;
    if (self.fulfilledMode == SRFineScheduleModePortrait) {
        self.portraitViewController.statusBarStyle = fullScreenStatusBarStyle;
        [self.portraitViewController setNeedsStatusBarAppearanceUpdate];
    } else if (self.fulfilledMode == SRFineScheduleModeLandscape) {
        self.landscapeRotationManager.landscapeViewController.statusBarStyle = fullScreenStatusBarStyle;
        [self.landscapeRotationManager.landscapeViewController setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)setFullScreenStatusBarAnimation:(UIStatusBarAnimation)fullScreenStatusBarAnimation {
    _fullScreenStatusBarAnimation = fullScreenStatusBarAnimation;
    if (self.fulfilledMode == SRFineScheduleModePortrait) {
        self.portraitViewController.statusBarAnimation = fullScreenStatusBarAnimation;
        [self.portraitViewController setNeedsStatusBarAppearanceUpdate];
    } else if (self.fulfilledMode == SRFineScheduleModeLandscape) {
        self.landscapeRotationManager.landscapeViewController.statusBarAnimation = fullScreenStatusBarAnimation;
        [self.landscapeRotationManager.landscapeViewController setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)setDisablePortraitGestureTypes:(SRDecidePeriodGardenTypes)disablePortraitGestureTypes {
    _disablePortraitGestureTypes = disablePortraitGestureTypes;
    self.portraitViewController.disablePortraitGestureTypes = disablePortraitGestureTypes;
}

- (void)setVerySize:(CGSize)verySize {
    _verySize = verySize;
    if (self.fulfilledMode == SRFineScheduleModePortrait && self.portraitFulfilledMode == SRPortraitFineScheduleModeScaleAspectFit) {
        self.portraitViewController.verySize = verySize;
    }
}

- (void)setView:(SRPeriodView *)view {
    if (view == _view) { return; }
    _view = view;
    if (self.fulfilledMode == SRFineScheduleModeLandscape) {
        self.landscapeRotationManager.contentView = view;
    } else if (self.fulfilledMode == SRFineScheduleModePortrait) {
        self.portraitViewController.contentView = view;
    }
}

- (void)setContainerView:(UIView *)containerView {
    if (containerView == _containerView) { return; }
    _containerView = containerView;
    if (self.fulfilledMode == SRFineScheduleModeLandscape) {
        self.landscapeRotationManager.containerView = containerView;
    } else if (self.fulfilledMode == SRFineScheduleModePortrait) {
        self.portraitViewController.containerView = containerView;
    }
}

- (void)setAllowOrientationRotation:(BOOL)allowOrientationRotation {
    _allowOrientationRotation = allowOrientationRotation;
    self.landscapeRotationManager.allowOrientationRotation = allowOrientationRotation;
}

- (void)setSupportInterfaceOrientation:(SRInterfaceOrientationMask)supportInterfaceOrientation {
    _supportInterfaceOrientation = supportInterfaceOrientation;
    self.landscapeRotationManager.supportInterfaceOrientation = supportInterfaceOrientation;
}

- (void)setActiveDeviceObserver:(BOOL)activeDeviceObserver {
    _activeDeviceObserver = activeDeviceObserver;
    self.landscapeRotationManager.activeDeviceObserver = activeDeviceObserver;
}

@end
