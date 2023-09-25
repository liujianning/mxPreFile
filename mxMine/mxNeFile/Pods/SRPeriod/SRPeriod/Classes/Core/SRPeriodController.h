
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SRPeriodStateWithback.h"
#import "SROrientationObserver.h"
#import "SRPrimaryViewControl.h"
#import "SRPeriodGestureControl.h"
#import "SRPeriodNotification.h"
#import "SRFloatView.h"
#import "UIScrollView+conditions.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRPeriodController : NSObject

@property (nonatomic, weak, nullable) UIView *containerView;

@property (nonatomic, strong) id<SRPeriodStateWithback> periodManager;

@property (nonatomic, strong, nullable) UIView<SRPrimaryViewControl> *controlView;

@property (nonatomic, strong, readonly, nullable) SRPeriodNotification *notification;

@property (nonatomic, assign, readonly) SRPrimaryStageContainerType containerType;

@property (nonatomic, strong, readonly, nullable) SRFloatView *smallFloatView;

@property (nonatomic, assign, readonly) BOOL smallFloatViewShow;

@property (nonatomic, weak, nullable) UIScrollView *scrollView;

+ (instancetype)presentManager:(id<SRPeriodStateWithback>)playerManager containerView:(UIView *)containerView;

- (instancetype)initWithPlayerManager:(id<SRPeriodStateWithback>)playerManager containerView:(UIView *)containerView;

+ (instancetype)playerWithScrollView:(UIScrollView *)scrollView playerManager:(id<SRPeriodStateWithback>)playerManager containerViewTag:(NSInteger)containerViewTag;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView playerManager:(id<SRPeriodStateWithback>)playerManager containerViewTag:(NSInteger)containerViewTag;

+ (instancetype)playerWithScrollView:(UIScrollView *)scrollView playerManager:(id<SRPeriodStateWithback>)playerManager containerView:(UIView *)containerView;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView playerManager:(id<SRPeriodStateWithback>)playerManager containerView:(UIView *)containerView;

@end

@interface SRPeriodController (SRPrimaryStageTimeControl)

@property (nonatomic, readonly) NSTimeInterval currentTime;

@property (nonatomic, readonly) NSTimeInterval tableTime;

@property (nonatomic, readonly) NSTimeInterval presentTime;

@property (nonatomic, readonly) float percent;

@property (nonatomic, readonly) float bufferProfile;

- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^ __nullable)(BOOL finished))completionHandler;

@end

@interface SRPeriodController (SRPrimaryStagePlaybackControl)

@property (nonatomic, assign) BOOL resumeRecord;

@property (nonatomic) float vehicle;

@property (nonatomic, getter=isMethod) BOOL method;

@property (nonatomic) float brightness;

@property (nonatomic, nullable) NSURL *assetUsing;

@property (nonatomic, copy, nullable) NSArray <NSURL *>*assetURLs;

@property (nonatomic) NSInteger currentPlayIndex;

@property (nonatomic, readonly) BOOL isLastAssetURL;

@property (nonatomic, readonly) BOOL isFirstAssetURL;

@property (nonatomic) BOOL pauseWhenAppResignActive;

@property (nonatomic, getter=isPauseByEvent) BOOL pauseByEvent;

@property (nonatomic, getter=isViewControllerDisappear) BOOL viewControllerDisappear;

@property (nonatomic, assign) BOOL customAudioSession;

@property (nonatomic, copy, nullable) void(^presentPrepareToBegin)(id<SRPeriodStateWithback> asset, NSURL *assetUsing);

@property (nonatomic, copy, nullable) void(^readyActiveToHave)(id<SRPeriodStateWithback> asset, NSURL *assetUsing);

@property (nonatomic, copy, nullable) void(^prettyTimeChanged)(id<SRPeriodStateWithback> asset, NSTimeInterval currentTime, NSTimeInterval duration);

@property (nonatomic, copy, nullable) void(^prettyBreadChanged)(id<SRPeriodStateWithback> asset, NSTimeInterval presentTime);

@property (nonatomic, copy, nullable) void(^presentStateChanged)(id<SRPeriodStateWithback> asset, SRPrimaryStagePeriodState state);

@property (nonatomic, copy, nullable) void(^LoadNoteStateChanged)(id<SRPeriodStateWithback> asset, SRPrimaryStageLoadState loadState);

@property (nonatomic, copy, nullable) void(^purpleFailed)(id<SRPeriodStateWithback> asset, id error);

@property (nonatomic, copy, nullable) void(^prettyDidToEnd)(id<SRPeriodStateWithback> asset);

@property (nonatomic, copy, nullable) void(^presentChangedSize)(id<SRPeriodStateWithback> asset, CGSize size);

- (void)periodTheNext;

- (void)periodThePrevious;

- (void)periodTheIndex:(NSInteger)index;

- (void)stop;

- (void)replaceCurrentManager:(id<SRPeriodStateWithback>)manager;

- (void)addPlayerViewToCell;

- (void)addPlayerViewToContainerView:(UIView *)containerView;

- (void)addPlayerViewToSmallFloatView;

- (void)stopCurrentView;

- (void)stopCurrentCell;

@end

@interface SRPeriodController (SRPrimaryStageOrientationRotation)

@property (nonatomic, readonly) SROrientationObserver *orientationObserver;

@property (nonatomic, readonly) BOOL shouldAutorotate;

@property (nonatomic) BOOL allowOrentitaionRotation;

@property (nonatomic, readonly) BOOL isFullScreen;

@property (nonatomic, assign) BOOL exitFullScreenWhenStop;

@property (nonatomic, getter=isLockedScreen) BOOL lockedScreen;

@property (nonatomic, copy, nullable) void(^orientationWillChange)(SRPeriodController *player, BOOL isFullScreen);

@property (nonatomic, copy, nullable) void(^orientationDidChanged)(SRPeriodController *player, BOOL isFullScreen);

@property (nonatomic, assign) UIStatusBarStyle fullScreenStatusBarStyle;

@property (nonatomic, assign) UIStatusBarAnimation fullScreenStatusBarAnimation;

@property (nonatomic, getter=isStatusBarHidden) BOOL statusBarHidden;

- (void)addDeviceOrientationObserver;

- (void)removeDeviceOrientationObserver;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated;

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;

- (void)enterPortraitFineExample:(BOOL)example animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;

- (void)enterPortraitFineExample:(BOOL)example animated:(BOOL)animated;

- (void)enterFineExample:(BOOL)example animated:(BOOL)animated completion:(void(^ __nullable)(void))completion;

- (void)enterFineExample:(BOOL)example animated:(BOOL)animated;

@end

@interface SRPeriodController (SRPeriodViewGesture)

@property (nonatomic, readonly) SRPeriodGestureControl *gestureControl;

@property (nonatomic, assign) SRPrimaryStageDisableGestureTypes disableGestureTypes;

@property (nonatomic) SRPrimaryStageDisablePanMovingDirection disablePanMovingDirection;

@end

@interface SRPeriodController (SRPrimaryStageScrollView)

@property (nonatomic) BOOL shouldPractice;

@property (nonatomic, getter=isWWANAutoPlay) BOOL WWANAutoPlay;

@property (nonatomic, readonly, nullable) NSIndexPath *playingIndexPath;

@property (nonatomic, readonly, nullable) NSIndexPath *shouldPlayIndexPath;

@property (nonatomic, readonly) NSInteger containerViewTag;

@property (nonatomic) BOOL stopWhileNotVisible;

@property (nonatomic) CGFloat playerDisapperaPercent;

@property (nonatomic) CGFloat playerApperaPercent;

@property (nonatomic, copy, nullable) NSArray <NSArray <NSURL *>*>*sectionAssetURLs;

@property (nonatomic, copy, nullable) void(^presentStateAppearingInScrollView)(NSIndexPath *indexPath, CGFloat playerApperaPercent);

@property (nonatomic, copy, nullable) void(^presentStateDisappearingInScrollView)(NSIndexPath *indexPath, CGFloat playerDisapperaPercent);

@property (nonatomic, copy, nullable) void(^presentStateWillAppearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateDidAppearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateWillDisappearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateDidDisappearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateShouldPlayInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^zf_scrollViewDidEndScrollingCallback)(NSIndexPath *indexPath);

- (void)zf_filterShouldPlayCellWhileScrolled:(void (^ __nullable)(NSIndexPath *indexPath))handler;

- (void)zf_filterShouldPlayCellWhileScrolling:(void (^ __nullable)(NSIndexPath *indexPath))handler;

- (void)periodTheIndexPath:(NSIndexPath *)indexPath;

- (void)periodTheIndexPath:(NSIndexPath *)indexPath
          scrollPosition:(SRPrimaryStageScrollViewScrollPosition)scrollPosition
                animated:(BOOL)animated;

- (void)periodTheIndexPath:(NSIndexPath *)indexPath
          scrollPosition:(SRPrimaryStageScrollViewScrollPosition)scrollPosition
                animated:(BOOL)animated
       completionHandler:(void (^ __nullable)(void))completionHandler;

- (void)periodTheIndexPath:(NSIndexPath *)indexPath assetUsing:(NSURL *)assetUsing;

- (void)periodTheIndexPath:(NSIndexPath *)indexPath
                assetUsing:(NSURL *)assetUsing
          scrollPosition:(SRPrimaryStageScrollViewScrollPosition)scrollPosition
                animated:(BOOL)animated;

- (void)periodTheIndexPath:(NSIndexPath *)indexPath
                assetUsing:(NSURL *)assetUsing
          scrollPosition:(SRPrimaryStageScrollViewScrollPosition)scrollPosition
                animated:(BOOL)animated
       completionHandler:(void (^ __nullable)(void))completionHandler;


@end

@interface SRPeriodController (SRPrimaryStageDeprecated)

- (void)updateScrollViewPlayerToCell  __attribute__((deprecated("use `addPlayerViewToCell:` instead.")));

- (void)updateNoramlPlayerWithContainerView:(UIView *)containerView __attribute__((deprecated("use `addPlayerViewToContainerView:` instead.")));

- (void)periodTheIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop  __attribute__((deprecated("use `periodTheIndexPath:scrollPosition:animated:` instead.")));

- (void)periodTheIndexPath:(NSIndexPath *)indexPath assetUsing:(NSURL *)assetUsing scrollToTop:(BOOL)scrollToTop  __attribute__((deprecated("use `periodTheIndexPath:assetURL:scrollPosition:animated:` instead.")));

- (void)periodTheIndexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop completionHandler:(void (^ __nullable)(void))completionHandler  __attribute__((deprecated("use `periodTheIndexPath:scrollPosition:animated:completionHandler:` instead.")));

- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation animated:(BOOL)animated completion:(void(^ __nullable)(void))completion __attribute__((deprecated("use `rotateToOrientation:animated:completion:` instead.")));

- (void)enterLandscapeFullScreen:(UIInterfaceOrientation)orientation animated:(BOOL)animated __attribute__((deprecated("use `rotateToOrientation:animated:` instead.")));

- (void)addPlayerViewToKeyWindow __attribute__((deprecated("use `addPlayerViewToSmallFloatView` instead.")));;

@end

NS_ASSUME_NONNULL_END
