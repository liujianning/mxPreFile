
#import <Foundation/Foundation.h>
#import "SRPeriodStateWithback.h"
#import "SROrientationObserver.h"
#import "SRPeriodGestureControl.h"
#import "SRReachabilityManager.h"
@class SRPeriodController;

NS_ASSUME_NONNULL_BEGIN

@protocol SRPrimaryViewControl <NSObject>

@required

@property (nonatomic, weak) SRPeriodController *primaryPretty;

@optional

- (void)veryPractice:(SRPeriodController *)practiceScreen prepareToPlay:(NSURL *)assetUsing;

- (void)veryPractice:(SRPeriodController *)practiceScreen presentPoliteStateChanged:(SRPrimaryStagePeriodState)state;

- (void)veryPractice:(SRPeriodController *)practiceScreen stateLoadChanged:(SRPrimaryStageLoadState)state;

- (void)veryPractice:(SRPeriodController *)practiceScreen
        currentTime:(NSTimeInterval)currentTime
          tableTime:(NSTimeInterval)tableTime;

- (void)veryPractice:(SRPeriodController *)practiceScreen
         presentTime:(NSTimeInterval)presentTime;

- (void)veryPractice:(SRPeriodController *)practiceScreen
       draggingTime:(NSTimeInterval)sleepTime
          tableTime:(NSTimeInterval)tableTime;

- (void)veryPracticePointEnd:(SRPeriodController *)practiceScreen;

- (void)veryPracticePointFailed:(SRPeriodController *)practiceScreen error:(id)error;

- (void)lockedVeryPractice:(SRPeriodController *)practiceScreen practiced:(BOOL)locked;

- (void)veryPractice:(SRPeriodController *)practiceScreen orientationWillChange:(SROrientationObserver *)observer;

- (void)veryPractice:(SRPeriodController *)practiceScreen orientationDidChanged:(SROrientationObserver *)observer;

#pragma mark - The network changed

- (void)veryPractice:(SRPeriodController *)practiceScreen reachabilityChanged:(SRReachabilityStatus)status;

- (void)veryPractice:(SRPeriodController *)practiceScreen presentChangedSize:(CGSize)size;

- (BOOL)gestureTriggerCondition:(SRPeriodGestureControl *)gestureControl
                    gestureType:(SRPrimaryStageGestureType)gestureType
              gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
                          touch:(UITouch *)touch;

- (void)gestureSingleTapped:(SRPeriodGestureControl *)gestureControl;

- (void)gestureDoubleTapped:(SRPeriodGestureControl *)gestureControl;

- (void)gestureBeganPan:(SRPeriodGestureControl *)gestureControl
           panDirection:(SRPanDirection)direction
            panLocation:(SRPanLocation)location;

- (void)gestureChangedPan:(SRPeriodGestureControl *)gestureControl
             panDirection:(SRPanDirection)direction
              panLocation:(SRPanLocation)location
             withVelocity:(CGPoint)velocity;

- (void)gestureEndedPan:(SRPeriodGestureControl *)gestureControl
           panDirection:(SRPanDirection)direction
            panLocation:(SRPanLocation)location;

- (void)gesturePinched:(SRPeriodGestureControl *)gestureControl
                 scale:(float)scale;

- (void)longPressed:(SRPeriodGestureControl *)gestureControl state:(SRLongPressGestureRecognizerState)state;

#pragma mark - scrollview

- (void)playerWillAppearInScrollView:(SRPeriodController *)practiceScreen;

- (void)primaryStageDidAppearInScrollView:(SRPeriodController *)practiceScreen;

- (void)playerWillDisappearInScrollView:(SRPeriodController *)practiceScreen;

- (void)primaryStageDidDisappearInScrollView:(SRPeriodController *)practiceScreen;

- (void)playerAppearingInScrollView:(SRPeriodController *)practiceScreen playerApperaPercent:(CGFloat)playerApperaPercent;

- (void)playerDisappearingInScrollView:(SRPeriodController *)practiceScreen playerDisapperaPercent:(CGFloat)playerDisapperaPercent;

- (void)veryPractice:(SRPeriodController *)practiceScreen floatViewShow:(BOOL)show;

@end

NS_ASSUME_NONNULL_END

