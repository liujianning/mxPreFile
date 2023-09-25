#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SRBaseView.h"
#import "SRLightControlView.h"
#import "SRLoadingView.h"
#import "SRNetworkSpeedMonitor.h"
#import "SRPeriodActionManager.h"
#import "SRPeriodControlView.h"
#import "SRPeriodManager.h"
#import "SRPeriodProtocol.h"
#import "SRPeriodStatusBar.h"
#import "SRPortraitControlView.h"
#import "SRSliderView.h"
#import "SRSmallFloatControlView.h"
#import "SRSpeedLaughView.h"
#import "SRUtilities.h"
#import "SRVehicleBrightnessView.h"
#import "UIImageView+SRCache.h"
#import "UIView+SRFrame.h"
#import "SRAutoScrollLabel.h"
#import "SRFloatView.h"
#import "SRKVOController.h"
#import "SRLandscapeRotationManager.h"
#import "SRLandscapeRotationManager_iOS15.h"
#import "SRLandscapeRotationManager_iOS16.h"
#import "SRLandscapeViewController.h"
#import "SRLandscapeViewController_iOS15.h"
#import "SRLandscapeWindow.h"
#import "SROrientationObserver.h"
#import "SRPeriodController.h"
#import "SRPeriodGestureControl.h"
#import "SRPeriodLogManager.h"
#import "SRPeriodNotification.h"
#import "SRPeriodStateWithback.h"
#import "SRPeriodTransition.h"
#import "SRPeriodView.h"
#import "SRPersentInteractiveTransition.h"
#import "SRPortraitViewController.h"
#import "SRPrimaryConst.h"
#import "SRPrimaryStage.h"
#import "SRPrimaryViewControl.h"
#import "SRReachabilityManager.h"
#import "UIScrollView+conditions.h"

FOUNDATION_EXPORT double SRPeriodVersionNumber;
FOUNDATION_EXPORT const unsigned char SRPeriodVersionString[];

