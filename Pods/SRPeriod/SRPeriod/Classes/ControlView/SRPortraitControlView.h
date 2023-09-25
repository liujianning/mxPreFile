

#import <UIKit/UIKit.h>
#import "SRSliderView.h"
#import "SRAutoScrollLabel.h"
#if __has_include(<SRPrimaryStage/SRPeriodController.h>)
#import <SRPrimaryStage/SRPeriodController.h>
#else
#import "SRPeriodController.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface SRPortraitControlView : UIView

@property (nonatomic, strong, readonly) UIButton *practiceButton;

@property (nonatomic, strong, readonly) UIView *bottomToolView;

@property (nonatomic, strong, readonly) UIView *topToolView;

@property (nonatomic, strong, readonly) SRAutoScrollLabel *titleLabel;

@property (nonatomic, strong) UIButton *bottomPracticeButton;

@property (nonatomic, strong, readonly) UILabel *currentTimeLabel;

@property (nonatomic, strong, readonly) SRSliderView *slider;

@property (nonatomic, strong, readonly) UILabel *tableTimeLabel;

@property (nonatomic, strong, readonly) UIButton *fullScreenBtn;

@property (nonatomic, weak) SRPeriodController *player;

@property (nonatomic, copy, nullable) void(^sliderValueChanging)(CGFloat value,BOOL forward);

@property (nonatomic, copy, nullable) void(^sliderValueChanged)(CGFloat value);

@property (nonatomic, copy, nullable) void(^presentPoliteStateChanged)(BOOL play);

@property (nonatomic, assign) BOOL tempTp;

@property (nonatomic, assign) SRFineScheduleMode fulfilledMode;

@property (nonatomic, strong) UIButton *adButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *ccButton;

- (void)resetControlledView;

- (void)showControlView;

- (void)hideControlView;

- (void)veryPractice:(SRPeriodController *)practiceScreen currentTime:(NSTimeInterval)currentTime tableTime:(NSTimeInterval)tableTime;

- (void)veryPractice:(SRPeriodController *)practiceScreen presentTime:(NSTimeInterval)presentTime;

- (BOOL)shouldResponseGestureWithPoint:(CGPoint)point withGestureType:(SRPrimaryStageGestureType)type touch:(nonnull UITouch *)touch;

- (void)showTitle:(NSString *_Nullable)title fulfilledMode:(SRFineScheduleMode)fulfilledMode;

- (void)practiceButtonClick;

- (void)practiceSelected:(BOOL)selected;

- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString;

- (void)sliderChangeEnded;

@end

NS_ASSUME_NONNULL_END
