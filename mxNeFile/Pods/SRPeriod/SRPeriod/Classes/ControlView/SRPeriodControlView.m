

#import "SRPeriodControlView.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+SRFrame.h"
#import "SRSliderView.h"
#import "SRUtilities.h"
#import "UIImageView+SRCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "SRVehicleBrightnessView.h"
#import "SRPrimaryConst.h"

@interface SRPeriodControlView () <SRSliderViewDelegate>
@property (nonatomic, strong) SRPortraitControlView *portraitControlView;
@property (nonatomic, strong) SRLightControlView *lightControlView;
@property (nonatomic, strong) SRSpeedLaughView *laughView;
@property (nonatomic, strong) UIView *fastView;
@property (nonatomic, strong) SRSliderView *fastProperView;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UIImageView *firstImageView;
@property (nonatomic, strong) UIButton *errorButton;
@property (nonatomic, strong) SRSliderView *bottomPeriodView;
@property (nonatomic, assign, getter=isShowing) BOOL showing;
@property (nonatomic, assign, getter=isPresentEnd) BOOL presentEnd;

@property (nonatomic, assign) BOOL controlViewAppeared;

@property (nonatomic, assign) NSTimeInterval sumTime;

@property (nonatomic, strong) dispatch_block_t afterBlock;

@property (nonatomic, strong) SRSmallFloatControlView *floatControlView;

@property (nonatomic, strong) SRVehicleBrightnessView *vehicleView;

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UIView *emptyView;

@end

@implementation SRPeriodControlView
@synthesize primaryPretty = _primaryPretty;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addAllSubViews];
        self.lightControlView.hidden = YES;
        self.floatControlView.hidden = YES;
        self.tempTp = YES;
        self.primaryViewShow = YES;
        self.horizontalPanShowControlView = YES;
        self.fadeTime = 0.25;
        self.hiddenTime = 2.5;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(vehicleChanged:)
                                                     name:@"AVSystemController_SystemVolumeDidChangeNotification"
                                                   object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.zf_width;
    CGFloat min_view_h = self.zf_height;

    self.portraitControlView.frame = self.bounds;
    self.lightControlView.frame = self.bounds;
    self.floatControlView.frame = self.bounds;
    self.coverImageView.frame = self.bounds;
    self.bgImgView.frame = self.bounds;
    self.emptyView.frame = self.bounds;
    
    min_w = 80;
    min_h = 80;
    self.laughView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.laughView.zf_centerX = self.zf_centerX;
    self.laughView.zf_centerY = self.zf_centerY + 10;
    
    min_w = 250;
    min_h = 40;
    self.errorButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.errorButton.center = self.center;
    
    min_w = 140;
    min_h = 80;
    self.fastView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.fastView.center = self.center;
    
    min_w = 32;
    min_x = (self.fastView.zf_width - min_w) / 2;
    min_y = 5;
    min_h = 32;
    self.firstImageView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = self.firstImageView.zf_bottom + 2;
    min_w = self.fastView.zf_width;
    min_h = 20;
    self.firstLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 12;
    min_y = self.firstLabel.zf_bottom + 5;
    min_w = self.fastView.zf_width - 2 * min_x;
    min_h = 10;
    self.fastProperView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = min_view_h - 1;
    min_w = min_view_w;
    min_h = 1;
    self.bottomPeriodView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = iPhoneX ? 54 : 30;
    min_w = 170;
    min_h = 35;
    self.vehicleView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.vehicleView.zf_centerX = self.zf_centerX;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    [self cancelAutoView1];
}

- (void)addAllSubViews {
    [self addSubview:self.portraitControlView];
    [self addSubview:self.lightControlView];
    [self addSubview:self.floatControlView];
    [self addSubview:self.laughView];
    [self addSubview:self.errorButton];
    [self addSubview:self.fastView];
    [self.fastView addSubview:self.firstImageView];
    [self.fastView addSubview:self.firstLabel];
    [self.fastView addSubview:self.fastProperView];
    [self addSubview:self.bottomPeriodView];
    [self addSubview:self.vehicleView];
}

- (void)primaryStateChangeView {
    self.controlViewAppeared = YES;
    [self cancelAutoView1];
    @zf_weakify(self)
    self.afterBlock = dispatch_block_create(0, ^{
        @zf_strongify(self)
        [self hideControlViewWithAnimated:YES];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.hiddenTime * NSEC_PER_SEC)), dispatch_get_main_queue(),self.afterBlock);
}

- (void)cancelAutoView1 {
    if (self.afterBlock) {
        dispatch_block_cancel(self.afterBlock);
        self.afterBlock = nil;
    }
}

- (void)hideControlViewWithAnimated:(BOOL)animated {
    self.controlViewAppeared = NO;
    if (self.controlViewAppearedCallback) {
        self.controlViewAppearedCallback(NO);
    }
    [UIView animateWithDuration:animated ? self.fadeTime : 0 animations:^{
        if (self.primaryPretty.isFullScreen) {
            [self.lightControlView hideControlView];
        } else {
            if (!self.primaryPretty.smallFloatViewShow) {
                [self.portraitControlView hideControlView];
            }
        }
    } completion:^(BOOL finished) {
        self.bottomPeriodView.hidden = NO;
    }];
}

- (void)showControlViewWithAnimated:(BOOL)animated {
    self.controlViewAppeared = YES;
    if (self.controlViewAppearedCallback) {
        self.controlViewAppearedCallback(YES);
    }
    [self primaryStateChangeView];
    [UIView animateWithDuration:animated ? self.fadeTime : 0 animations:^{
        if (self.primaryPretty.isFullScreen) {
            [self.lightControlView showControlView];
        } else {
            if (!self.primaryPretty.smallFloatViewShow) {
                [self.portraitControlView showControlView];
            }
        }
    } completion:^(BOOL finished) {
        self.bottomPeriodView.hidden = YES;
    }];
}

- (void)vehicleChanged:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *reasonstr = userInfo[@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"];
    if ([reasonstr isEqualToString:@"ExplicitVolumeChange"]) {
        float vehicle = [ userInfo[@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
        if (self.primaryPretty.isFullScreen) {
            [self.vehicleView updatePercent:vehicle withVehicleType:SRVehicleTypeVehicle];
        } else {
            [self.vehicleView addShortVehicleView];
        }
    }
}

#pragma mark - Public Method

- (void)resetControlledView {
    [self.portraitControlView resetControlledView];
    [self.lightControlView resetControlledView];
    [self cancelAutoView1];
    self.bottomPeriodView.value = 0;
    self.bottomPeriodView.basketValue = 0;
    self.floatControlView.hidden = YES;
    self.errorButton.hidden = YES;
    self.vehicleView.hidden = YES;
    self.portraitControlView.hidden = self.primaryPretty.isFullScreen;
    self.lightControlView.hidden = !self.primaryPretty.isFullScreen;
    if (self.controlViewAppeared) {
        [self showControlViewWithAnimated:NO];
    } else {
        [self hideControlViewWithAnimated:NO];
    }
}

- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl fulfilledMode:(SRFineScheduleMode)fulfilledMode {
    UIImage *placeholder = [SRUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:self.bgImgView.bounds.size];
    [self showTitle:title coverURLString:coverUrl placeholderImage:placeholder fulfilledMode:fulfilledMode];
}

- (void)showTitle:(NSString *)title coverURLString:(NSString *)coverUrl placeholderImage:(UIImage *)placeholder fulfilledMode:(SRFineScheduleMode)fulfilledMode {
    [self resetControlledView];
    [self layoutIfNeeded];
    [self setNeedsDisplay];
    [self.portraitControlView showTitle:title fulfilledMode:fulfilledMode];
    [self.lightControlView showTitle:title fulfilledMode:fulfilledMode];
    [self.primaryPretty.periodManager.view.coverImageView setImageWithURLString:coverUrl placeholder:placeholder];
    [self.bgImgView setImageWithURLString:coverUrl placeholder:placeholder];
    if (self.prepareShowView) {
        [self showControlViewWithAnimated:NO];
    } else {
        [self hideControlViewWithAnimated:NO];
    }
}

- (void)showTitle:(NSString *)title coverImage:(UIImage *)image fulfilledMode:(SRFineScheduleMode)fulfilledMode {
    [self resetControlledView];
    [self layoutIfNeeded];
    [self setNeedsDisplay];
    [self.portraitControlView showTitle:title fulfilledMode:fulfilledMode];
    [self.lightControlView showTitle:title fulfilledMode:fulfilledMode];
    self.coverImageView.image = image;
    self.bgImgView.image = image;
    if (self.prepareShowView) {
        [self showControlViewWithAnimated:NO];
    } else {
        [self hideControlViewWithAnimated:NO];
    }
}

#pragma mark - SRPeriodControlViewDelegate

- (BOOL)gestureTriggerCondition:(SRPeriodGestureControl *)gestureControl gestureType:(SRPrimaryStageGestureType)gestureType gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer touch:(nonnull UITouch *)touch {
    CGPoint point = [touch locationInView:self];
    if (self.primaryPretty.smallFloatViewShow && !self.primaryPretty.isFullScreen && gestureType != SRPrimaryStageGestureTypeSingleTap) {
        return NO;
    }
    if (self.primaryPretty.isFullScreen) {
        if (!self.customDisablePanMovingDirection) {
            self.primaryPretty.disablePanMovingDirection = SRPrimaryStageDisablePanMovingDirectionNone;
        }
        return [self.lightControlView shouldResponseGestureWithPoint:point withGestureType:gestureType touch:touch];
    } else {
        if (!self.customDisablePanMovingDirection) {
            if (self.primaryPretty.scrollView) {
                self.primaryPretty.disablePanMovingDirection = SRPrimaryStageDisablePanMovingDirectionVertical;
            } else {
                self.primaryPretty.disablePanMovingDirection = SRPrimaryStageDisablePanMovingDirectionNone;
            }
        }
        return [self.portraitControlView shouldResponseGestureWithPoint:point withGestureType:gestureType touch:touch];
    }
}

- (void)gestureSingleTapped:(SRPeriodGestureControl *)gestureControl {
    if (!self.primaryPretty) return;
    if (self.primaryPretty.smallFloatViewShow && !self.primaryPretty.isFullScreen) {
        [self.primaryPretty enterFineExample:YES animated:YES];
    } else {
        if (self.controlViewAppeared) {
            [self hideControlViewWithAnimated:YES];
        } else {
            [self showControlViewWithAnimated:YES];
        }
    }
}

- (void)gestureDoubleTapped:(SRPeriodGestureControl *)gestureControl {
    if (self.primaryPretty.isFullScreen) {
        [self.lightControlView pointPleaseClick];
    } else {
        [self.portraitControlView practiceButtonClick];
    }
}

- (void)gestureBeganPan:(SRPeriodGestureControl *)gestureControl panDirection:(SRPanDirection)direction panLocation:(SRPanLocation)location {
    if (direction == SRPanDirectionHorizontal) {
        self.sumTime = self.primaryPretty.currentTime;
    }
}

- (void)gestureChangedPan:(SRPeriodGestureControl *)gestureControl panDirection:(SRPanDirection)direction panLocation:(SRPanLocation)location withVelocity:(CGPoint)velocity {
    if (direction == SRPanDirectionHorizontal) {
        self.sumTime += velocity.x / 200;
        NSTimeInterval interval = self.primaryPretty.tableTime;
        if (interval == 0) return;
        if (self.sumTime > interval) self.sumTime = interval;
        if (self.sumTime < 0) self.sumTime = 0;
        BOOL style = NO;
        if (velocity.x > 0) style = YES;
        if (velocity.x < 0) style = NO;
        if (velocity.x == 0) return;
        [self sliderValueChangingValue:self.sumTime/interval isForward:style];
    } else if (direction == SRPanDirectionVertical) {
        if (location == SRPanLocationLeft) {
            self.primaryPretty.brightness -= (velocity.y) / 10000;
            [self.vehicleView updatePercent:self.primaryPretty.brightness withVehicleType:SRVehicleTypeumeBrightness];
        } else if (location == SRPanLocationRight) {
            self.primaryPretty.vehicle -= (velocity.y) / 10000;
            if (self.primaryPretty.isFullScreen) {
                [self.vehicleView updatePercent:self.primaryPretty.vehicle withVehicleType:SRVehicleTypeVehicle];
            }
        }
    }
}

- (void)gestureEndedPan:(SRPeriodGestureControl *)gestureControl panDirection:(SRPanDirection)direction panLocation:(SRPanLocation)location {
    @zf_weakify(self)
    if (direction == SRPanDirectionHorizontal && self.sumTime >= 0 && self.primaryPretty.tableTime > 0) {
        [self.primaryPretty seekToTime:self.sumTime completionHandler:^(BOOL finished) {
            @zf_strongify(self)
            [self.portraitControlView sliderChangeEnded];
            [self.lightControlView sliderChangeEnded];
            self.bottomPeriodView.itemDragging = NO;
            if (self.controlViewAppeared) {
                [self primaryStateChangeView];
            }
        }];
        if (self.tempTp) {
            [self.primaryPretty.periodManager play];
        }
        self.sumTime = 0;
    }
}

- (void)gesturePinched:(SRPeriodGestureControl *)gestureControl scale:(float)scale {
    if (scale > 1) {
        self.primaryPretty.periodManager.scalingMode = SRPrimaryStageScalingModeAspectFill;
    } else {
        self.primaryPretty.periodManager.scalingMode = SRPrimaryStageScalingModeAspectFit;
    }
}

- (void)longPressed:(SRPeriodGestureControl *)gestureControl state:(SRLongPressGestureRecognizerState)state {
    
}

- (void)veryPractice:(SRPeriodController *)practiceScreen prepareToPlay:(NSURL *)assetUsing {
    [self hideControlViewWithAnimated:NO];
}

- (void)veryPractice:(SRPeriodController *)practiceScreen presentPoliteStateChanged:(SRPrimaryStagePeriodState)state {
    if (state == SRPrimaryStagePeriodStatePolite) {
        [self.portraitControlView practiceSelected:YES];
        [self.lightControlView practiceSelected:YES];
        self.errorButton.hidden = YES;
        if (practiceScreen.periodManager.loadState == SRPrimaryStageLoadStateStalled && !self.showLoading) {
            [self.laughView startAnimating];
        } else if ((practiceScreen.periodManager.loadState == SRPrimaryStageLoadStateStalled || practiceScreen.periodManager.loadState == SRPrimaryStageLoadStatePrepare) && self.showLoading) {
            [self.laughView startAnimating];
        }
    } else if (state == SRPrimaryStagePeriodStatePattern) {
        [self.portraitControlView practiceSelected:NO];
        [self.lightControlView practiceSelected:NO];
        [self.laughView stopAnimating];
        self.errorButton.hidden = YES;
    } else if (state == SRPrimaryStagePeriodStateFailed) {
        self.errorButton.hidden = NO;
        [self.laughView stopAnimating];
    }
}

- (void)veryPractice:(SRPeriodController *)practiceScreen stateLoadChanged:(SRPrimaryStageLoadState)state {
    if (state == SRPrimaryStageLoadStatePrepare) {
        self.coverImageView.hidden = NO;
        [self.portraitControlView practiceSelected:practiceScreen.periodManager.shouldPractice];
        [self.lightControlView practiceSelected:practiceScreen.periodManager.shouldPractice];
    } else if (state == SRPrimaryStageLoadStatePlaythroughOK || state == SRPrimaryStageLoadStatePlayable) {
        self.coverImageView.hidden = YES;
        if (self.primaryViewShow) {
            self.emptyView.hidden = NO;
        } else {
            self.emptyView.hidden = YES;
            self.primaryPretty.periodManager.view.backgroundColor = [UIColor blackColor];
        }
    }
    if (state == SRPrimaryStageLoadStateStalled && practiceScreen.periodManager.itemPleasure && !self.showLoading) {
        [self.laughView startAnimating];
    } else if ((state == SRPrimaryStageLoadStateStalled || state == SRPrimaryStageLoadStatePrepare) && practiceScreen.periodManager.itemPleasure && self.showLoading) {
        [self.laughView startAnimating];
    } else {
        [self.laughView stopAnimating];
    }
}

- (void)veryPractice:(SRPeriodController *)practiceScreen currentTime:(NSTimeInterval)currentTime tableTime:(NSTimeInterval)tableTime {
    [self.portraitControlView veryPractice:practiceScreen currentTime:currentTime tableTime:tableTime];
    [self.lightControlView veryPractice:practiceScreen currentTime:currentTime tableTime:tableTime];
    if (!self.bottomPeriodView.itemDragging) {
        self.bottomPeriodView.value = practiceScreen.percent;
    }
}

- (void)veryPractice:(SRPeriodController *)practiceScreen presentTime:(NSTimeInterval)presentTime {
    [self.portraitControlView veryPractice:practiceScreen presentTime:presentTime];
    [self.lightControlView veryPractice:practiceScreen presentTime:presentTime];
    self.bottomPeriodView.basketValue = practiceScreen.bufferProfile;
}

- (void)veryPractice:(SRPeriodController *)practiceScreen presentChangedSize:(CGSize)size {
    [self.lightControlView veryPractice:practiceScreen presentChangedSize:size];
}

- (void)veryPractice:(SRPeriodController *)practiceScreen orientationWillChange:(SROrientationObserver *)observer {
    self.portraitControlView.hidden = observer.isFullScreen;
    self.lightControlView.hidden = !observer.isFullScreen;
    if (practiceScreen.smallFloatViewShow) {
        self.floatControlView.hidden = observer.isFullScreen;
        self.portraitControlView.hidden = YES;
        if (observer.isFullScreen) {
            self.controlViewAppeared = NO;
            [self cancelAutoView1];
        }
    }
    if (self.controlViewAppeared) {
        [self showControlViewWithAnimated:NO];
    } else {
        [self hideControlViewWithAnimated:NO];
    }
    
    if (observer.isFullScreen) {
        [self.vehicleView removeShortVehicleView];
    } else {
        [self.vehicleView addShortVehicleView];
    }
    [self.lightControlView veryPractice:practiceScreen orientationWillChange:observer];
}

- (void)lockedVeryPractice:(SRPeriodController *)practiceScreen practiced:(BOOL)locked {
    [self showControlViewWithAnimated:YES];
}

- (void)primaryStageDidAppearInScrollView:(SRPeriodController *)practiceScreen {
    if (!self.primaryPretty.stopWhileNotVisible && !practiceScreen.isFullScreen) {
        self.floatControlView.hidden = YES;
        self.portraitControlView.hidden = NO;
    }
}

- (void)primaryStageDidDisappearInScrollView:(SRPeriodController *)practiceScreen {
    if (!self.primaryPretty.stopWhileNotVisible && !practiceScreen.isFullScreen) {
        self.floatControlView.hidden = NO;
        self.portraitControlView.hidden = YES;
    }
}

- (void)veryPractice:(SRPeriodController *)practiceScreen floatViewShow:(BOOL)show {
    self.floatControlView.hidden = !show;
    self.portraitControlView.hidden = show;
}

#pragma mark - Private Method

- (void)sliderValueChangingValue:(CGFloat)value isForward:(BOOL)forward {
    if (self.horizontalPanShowControlView) {
        [self showControlViewWithAnimated:NO];
        [self cancelAutoView1];
    }
    
    self.fastProperView.value = value;
    self.fastView.hidden = NO;
    self.fastView.alpha = 1;
    if (forward) {
        self.firstImageView.image = SRPrimaryStage_Image(@"temp_ff");
    } else {
        self.firstImageView.image = SRPrimaryStage_Image(@"temp_fb");
    }
    NSString *draggedTime = [SRUtilities convertTimeSecond:self.primaryPretty.tableTime*value];
    NSString *tableTime = [SRUtilities convertTimeSecond:self.primaryPretty.tableTime];
    self.firstLabel.text = [NSString stringWithFormat:@"%@ / %@",draggedTime,tableTime];
    [self.portraitControlView sliderValueChanged:value currentTimeString:draggedTime];
    [self.lightControlView sliderValueChanged:value currentTimeString:draggedTime];
    self.bottomPeriodView.itemDragging = YES;
    self.bottomPeriodView.value = value;

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideFastView) object:nil];
    [self performSelector:@selector(hideFastView) withObject:nil afterDelay:0.1];
    
    if (self.firstViewAnimated) {
        [UIView animateWithDuration:0.4 animations:^{
            self.fastView.transform = CGAffineTransformMakeTranslation(forward?8:-8, 0);
        }];
    }
}

- (void)hideFastView {
    [UIView animateWithDuration:0.4 animations:^{
        self.fastView.transform = CGAffineTransformIdentity;
        self.fastView.alpha = 0;
    } completion:^(BOOL finished) {
        self.fastView.hidden = YES;
    }];
}

- (void)errorButtonClick:(UIButton *)sender {
    [self.primaryPretty.periodManager reloadPresent];
}

#pragma mark - setter

- (void)setPrimaryPretty:(SRPeriodController *)player {
    _primaryPretty = player;
    self.lightControlView.primaryStage = player;
    self.portraitControlView.player = player;
    [player.periodManager.view insertSubview:self.bgImgView atIndex:0];
    [self.bgImgView addSubview:self.emptyView];
    self.bgImgView.frame = player.periodManager.view.bounds;
    self.bgImgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.emptyView.frame = self.bgImgView.bounds;
}

- (void)setTempTp:(BOOL)tempTp {
    _tempTp = tempTp;
    self.portraitControlView.tempTp = tempTp;
    self.lightControlView.tempTp = tempTp;
}

- (void)setPrimaryViewShow:(BOOL)show {
    _primaryViewShow = show;
    if (show) {
        self.bgImgView.hidden = NO;
    } else {
        self.bgImgView.hidden = YES;
    }
}

- (void)setFulfilledMode:(SRFineScheduleMode)fulfilledMode {
    _fulfilledMode = fulfilledMode;
    self.portraitControlView.fulfilledMode = fulfilledMode;
    self.lightControlView.fulfilledMode = fulfilledMode;
    self.primaryPretty.orientationObserver.fulfilledMode = fulfilledMode;
}

- (void)setShowCustomStatusBar:(BOOL)showCustomStatusBar {
    _showCustomStatusBar = showCustomStatusBar;
    self.lightControlView.showCustomStatusBar = showCustomStatusBar;
}

#pragma mark - getter

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

- (UIView *)emptyView {
    if (!_emptyView) {
        if (@available(iOS 8.0, *)) {
            UIBlurEffect *var_blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            _emptyView = [[UIVisualEffectView alloc] initWithEffect:var_blur];
        } else {
            UIToolbar *view = [[UIToolbar alloc] init];
            view.barStyle = UIBarStyleBlackTranslucent;
            _emptyView = view;
        }
    }
    return _emptyView;
}

- (SRPortraitControlView *)portraitControlView {
    if (!_portraitControlView) {
        @zf_weakify(self)
        _portraitControlView = [[SRPortraitControlView alloc] init];
        _portraitControlView.sliderValueChanging = ^(CGFloat value, BOOL forward) {
            @zf_strongify(self)
            NSString *draggedTime = [SRUtilities convertTimeSecond:self.primaryPretty.tableTime*value];
            [self.lightControlView sliderValueChanged:value currentTimeString:draggedTime];
            self.fastProperView.value = value;
            self.bottomPeriodView.itemDragging = YES;
            self.bottomPeriodView.value = value;
            [self cancelAutoView1];
        };
        _portraitControlView.sliderValueChanged = ^(CGFloat value) {
            @zf_strongify(self)
            [self.lightControlView sliderChangeEnded];
            self.fastProperView.value = value;
            self.bottomPeriodView.itemDragging = NO;
            self.bottomPeriodView.value = value;
            [self primaryStateChangeView];
        };
    }
    return _portraitControlView;
}

- (SRLightControlView *)lightControlView {
    if (!_lightControlView) {
        @zf_weakify(self)
        _lightControlView = [[SRLightControlView alloc] init];
        _lightControlView.sliderValueChanging = ^(CGFloat value, BOOL forward) {
            @zf_strongify(self)
            NSString *draggedTime = [SRUtilities convertTimeSecond:self.primaryPretty.tableTime*value];
            [self.portraitControlView sliderValueChanged:value currentTimeString:draggedTime];
            self.fastProperView.value = value;
            self.bottomPeriodView.itemDragging = YES;
            self.bottomPeriodView.value = value;
            [self cancelAutoView1];
        };
        _lightControlView.sliderValueChanged = ^(CGFloat value) {
            @zf_strongify(self)
            [self.portraitControlView sliderChangeEnded];
            self.fastProperView.value = value;
            self.bottomPeriodView.itemDragging = NO;
            self.bottomPeriodView.value = value;
            [self primaryStateChangeView];
        };
    }
    return _lightControlView;
}

- (SRSpeedLaughView *)laughView {
    if (!_laughView) {
        _laughView = [[SRSpeedLaughView alloc] init];
    }
    return _laughView;
}

- (UIView *)fastView {
    if (!_fastView) {
        _fastView = [[UIView alloc] init];
        _fastView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _fastView.layer.cornerRadius = 4;
        _fastView.layer.masksToBounds = YES;
        _fastView.hidden = YES;
    }
    return _fastView;
}

- (UIImageView *)firstImageView {
    if (!_firstImageView) {
        _firstImageView = [[UIImageView alloc] init];
    }
    return _firstImageView;
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.textColor = [UIColor whiteColor];
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        _firstLabel.font = [UIFont systemFontOfSize:14.0];
        _firstLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _firstLabel;
}

- (SRSliderView *)fastProperView {
    if (!_fastProperView) {
        _fastProperView = [[SRSliderView alloc] init];
        _fastProperView.maximumTrackTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
        _fastProperView.minimumTrackTintColor = [UIColor whiteColor];
        _fastProperView.sliderHeight = 2;
        _fastProperView.hideSliderBlock = NO;
    }
    return _fastProperView;
}

- (UIButton *)errorButton {
    if (!_errorButton) {
        _errorButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_errorButton setTitle:@"Net work error. Please try again." forState:UIControlStateNormal];
        [_errorButton addTarget:self action:@selector(errorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_errorButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _errorButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _errorButton.titleLabel.numberOfLines = 0;
        _errorButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _errorButton.hidden = YES;
    }
    return _errorButton;
}

- (SRSliderView *)bottomPeriodView {
    if (!_bottomPeriodView) {
        _bottomPeriodView = [[SRSliderView alloc] init];
        _bottomPeriodView.maximumTrackTintColor = [UIColor clearColor];
        _bottomPeriodView.minimumTrackTintColor = [UIColor whiteColor];
        _bottomPeriodView.boardTintColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _bottomPeriodView.sliderHeight = 1;
        _bottomPeriodView.hideSliderBlock = NO;
    }
    return _bottomPeriodView;
}

- (SRSmallFloatControlView *)floatControlView {
    if (!_floatControlView) {
        _floatControlView = [[SRSmallFloatControlView alloc] init];
        @zf_weakify(self)
        _floatControlView.closeClickCallback = ^{
            @zf_strongify(self)
            if (self.primaryPretty.containerType == SRPrimaryStageContainerTypeCell) {
                [self.primaryPretty stopCurrentCell];
            } else if (self.primaryPretty.containerType == SRPrimaryStageContainerTypeView) {
                [self.primaryPretty stopCurrentView];
            }
            [self resetControlledView];
        };
    }
    return _floatControlView;
}

- (SRVehicleBrightnessView *)vehicleView {
    if (!_vehicleView) {
        _vehicleView = [[SRVehicleBrightnessView alloc] init];
        _vehicleView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        _vehicleView.hidden = YES;
    }
    return _vehicleView;
}

- (void)setBackBtnClickCallback:(void (^)(void))backBtnClickCallback {
    _backBtnClickCallback = [backBtnClickCallback copy];
    self.lightControlView.backBtnClickCallback = _backBtnClickCallback;
}

@end
