

#import <UIKit/UIKit.h>
#import "SRPortraitControlView.h"
#import "SRLightControlView.h"
#import "SRSpeedLaughView.h"
#import "SRSmallFloatControlView.h"
#import "SRPrimaryViewControl.h"

@interface SRPeriodControlView : UIView <SRPrimaryViewControl>

@property (nonatomic, strong, readonly) SRPortraitControlView *portraitControlView;

@property (nonatomic, strong, readonly) SRLightControlView *lightControlView;

@property (nonatomic, strong, readonly) SRSpeedLaughView *laughView;

@property (nonatomic, strong, readonly) UIView *fastView;

@property (nonatomic, strong, readonly) SRSliderView *fastProperView;

@property (nonatomic, strong, readonly) UILabel *firstLabel;

@property (nonatomic, strong, readonly) UIImageView *firstImageView;

@property (nonatomic, strong, readonly) UIButton *errorButton;

@property (nonatomic, strong, readonly) SRSliderView *bottomPeriodView;

@property (nonatomic, strong, readonly) UIImageView *coverImageView;

@property (nonatomic, strong, readonly) UIImageView *bgImgView;

@property (nonatomic, strong, readonly) UIView *emptyView;

@property (nonatomic, strong, readonly) SRSmallFloatControlView *floatControlView;

@property (nonatomic, assign) BOOL firstViewAnimated;

@property (nonatomic, assign) BOOL primaryViewShow;

@property (nonatomic, assign) BOOL tempTp;

@property (nonatomic, copy) void(^backBtnClickCallback)(void);

@property (nonatomic, readonly) BOOL controlViewAppeared;

@property (nonatomic, copy) void(^controlViewAppearedCallback)(BOOL appeared);

@property (nonatomic, assign) NSTimeInterval hiddenTime;

@property (nonatomic, assign) NSTimeInterval fadeTime;

@property (nonatomic, assign) BOOL horizontalPanShowControlView;

@property (nonatomic, assign) BOOL prepareShowView;

@property (nonatomic, assign) BOOL showLoading;

@property (nonatomic, assign) BOOL customDisablePanMovingDirection;

@property (nonatomic, assign) BOOL showCustomStatusBar;

@property (nonatomic, assign) SRFineScheduleMode fulfilledMode;

- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl fulfilledMode:(SRFineScheduleMode)fulfilledMode;

- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl placeholderImage:(UIImage *)placeholder fulfilledMode:(SRFineScheduleMode)fulfilledMode;

- (void)showTitle:(NSString *)title coverImage:(UIImage *)image fulfilledMode:(SRFineScheduleMode)fulfilledMode;

- (void)resetControlledView;

@end
