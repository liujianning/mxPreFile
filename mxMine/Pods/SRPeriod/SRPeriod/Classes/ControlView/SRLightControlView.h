
#import "SRAutoScrollLabel.h"
#import <UIKit/UIKit.h>
#import "SRSliderView.h"
#import "SRPeriodController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRLightControlView : UIView
@property (nonatomic, strong, readonly) UIView *topToolView;

@property (nonatomic, strong, readonly) UIButton *backBtn;

@property (nonatomic, strong) SRAutoScrollLabel *titleLabel;

@property (nonatomic, strong, readonly) UIView *bottomToolView;

@property (nonatomic, strong, readonly) UIButton *pointPleaseBtn;

@property (nonatomic, strong) UIButton *playFullBack;

@property (nonatomic, strong, readonly) UILabel *currentTimeLabel;

@property (nonatomic, strong, readonly) SRSliderView *slider;

@property (nonatomic, strong, readonly) UILabel *tableTimeLabel;

@property (nonatomic, strong, readonly) UIButton *lockBtn;

@property (nonatomic, assign) BOOL showCustomStatusBar;

@property (nonatomic, weak) SRPeriodController *primaryStage;

@property (nonatomic, assign) BOOL centerAd;

@property (nonatomic, copy, nullable) void(^sliderValueChanging)(CGFloat value,BOOL forward);

@property (nonatomic, copy, nullable) void(^sliderValueChanged)(CGFloat value);

@property (nonatomic, copy) void(^backBtnClickCallback)(void);
@property (nonatomic, copy) void(^controlBlock)(void);
@property (nonatomic, copy, nullable) void(^presentPoliteStateChanged)(BOOL play);
@property (nonatomic, assign) BOOL tempTp;

@property (nonatomic, assign) SRFineScheduleMode fulfilledMode;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIStackView *centerTool;

@property (nonatomic, strong) UIStackView *topStasckView;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIStackView *leftStackView;

@property (nonatomic, strong) UIButton *adButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *ccButton;
@property (nonatomic, strong) UIButton *episodes;

@property (nonatomic, strong) UIButton *fullButton;
@property (nonatomic, strong) UIButton *toupingButton;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *skipButton;

- (void)resetControlledView;

- (void)showControlView;

- (void)hideControlView;

- (void)veryPractice:(SRPeriodController *)practiceScreen currentTime:(NSTimeInterval)currentTime tableTime:(NSTimeInterval)tableTime;

- (void)veryPractice:(SRPeriodController *)practiceScreen presentTime:(NSTimeInterval)presentTime;

- (BOOL)shouldResponseGestureWithPoint:(CGPoint)point withGestureType:(SRPrimaryStageGestureType)type touch:(nonnull UITouch *)touch;

- (void)veryPractice:(SRPeriodController *)practiceScreen presentChangedSize:(CGSize)size;

- (void)veryPractice:(SRPeriodController *)practiceScreen orientationWillChange:(SROrientationObserver *)observer;

- (void)showTitle:(NSString *_Nullable)title fulfilledMode:(SRFineScheduleMode)fulfilledMode;

- (void)pointPleaseClick;

- (void)practiceSelected:(BOOL)selected;

- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString;

- (void)sliderChangeEnded;
- (void)backAction;
@end

NS_ASSUME_NONNULL_END
