

#import <UIKit/UIKit.h>
#import "SRPeriodView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SRFineScheduleMode) {
    SRFineScheduleModeAutomatic,
    SRFineScheduleModeLandscape,
    SRFineScheduleModePortrait
};

typedef NS_ENUM(NSUInteger, SRPortraitFineScheduleMode) {
    SRPortraitFineScheduleModeScaleToFill,
    SRPortraitFineScheduleModeScaleAspectFit
};

typedef NS_ENUM(NSUInteger, SRRotateType) {
    SRRotateTypeNormal,
    SRRotateTypeCell
};

typedef NS_OPTIONS(NSUInteger, SRInterfaceOrientationMask) {
    SRInterfaceOrientationMaskUnknow = 0,
    SRInterfaceOrientationMaskPortrait = (1 << 0),
    SRInterfaceOrientationMaskLandscapeLeft = (1 << 1),
    SRInterfaceOrientationMaskLandscapeRight = (1 << 2),
    SRInterfaceOrientationMaskPortraitUpsideDown = (1 << 3),
    SRInterfaceOrientationMaskLandscape = (SRInterfaceOrientationMaskLandscapeLeft | SRInterfaceOrientationMaskLandscapeRight),
    SRInterfaceOrientationMaskAll = (SRInterfaceOrientationMaskPortrait | SRInterfaceOrientationMaskLandscape | SRInterfaceOrientationMaskPortraitUpsideDown),
    SRInterfaceOrientationMaskAllButUpsideDown = (SRInterfaceOrientationMaskPortrait | SRInterfaceOrientationMaskLandscape),
};

typedef NS_OPTIONS(NSUInteger, SRDecidePeriodGardenTypes) {
    SRDecidePeriodGardenTypesNone         = 0,
    SRDecidePeriodGardenTypesTap          = 1 << 0,
    SRDecidePeriodGardenTypesPan          = 1 << 1,
    SRDecidePeriodGardenTypesAll          = (SRDecidePeriodGardenTypesTap | SRDecidePeriodGardenTypesPan)
};

@protocol SRPortraitOrientationDelegate <NSObject>

- (void)zf_orientationWillChange:(BOOL)fullScreen;

- (void)zf_orientationDidChanged:(BOOL)fullScreen;

- (void)zf_interationState:(BOOL)dragging;

@end

@interface SROrientationObserver : NSObject

- (void)updateRotateView:(SRPeriodView *)rotateView
           containerView:(UIView *)containerView;

@property (nonatomic, strong, readonly, nullable) UIView *fullScreenContainerView;

@property (nonatomic, weak) UIView *containerView;

@property (nonatomic, copy, nullable) void(^orientationWillChange)(SROrientationObserver *observer, BOOL isFullScreen);

@property (nonatomic, copy, nullable) void(^orientationDidChanged)(SROrientationObserver *observer, BOOL isFullScreen);

@property (nonatomic) SRFineScheduleMode fulfilledMode;

@property (nonatomic, assign) SRPortraitFineScheduleMode portraitFulfilledMode;

@property (nonatomic) NSTimeInterval duration;

@property (nonatomic, readonly, getter=isFullScreen) BOOL fullScreen;

@property (nonatomic, getter=isLockedScreen) BOOL lockedScreen;

@property (nonatomic, assign) BOOL fullScreenStatusBarHidden;

@property (nonatomic, assign) UIStatusBarStyle fullScreenStatusBarStyle;

@property (nonatomic, assign) UIStatusBarAnimation fullScreenStatusBarAnimation;

@property (nonatomic, assign) CGSize verySize;

@property (nonatomic, assign) SRDecidePeriodGardenTypes disablePortraitGestureTypes;

@property (nonatomic, readonly) UIInterfaceOrientation currentOrientation;

@property (nonatomic, assign) BOOL allowOrientationRotation;

@property (nonatomic, assign) SRInterfaceOrientationMask supportInterfaceOrientation;

- (void)addDeviceOrientationObserver;

- (void)removeDeviceOrientationObserver;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;

- (void)enterPortraitFineExample:(BOOL)example animated:(BOOL)animated;

- (void)enterPortraitFineExample:(BOOL)example animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;

- (void)enterFineExample:(BOOL)example animated:(BOOL)animated;

- (void)enterFineExample:(BOOL)example animated:(BOOL)animated completion:(void (^ _Nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END


