

#import "SRPeriodGestureControl.h"

@interface SRPeriodGestureControl ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;
@property (nonatomic, strong) UIPanGestureRecognizer *panGR;
@property (nonatomic, strong) UIPinchGestureRecognizer *pinchGR;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGR;
@property (nonatomic) SRPanDirection panDirection;
@property (nonatomic) SRPanLocation panLocation;
@property (nonatomic) SRPanMovingDirection panMovingDirection;
@property (nonatomic, weak) UIView *targetView;

@end

@implementation SRPeriodGestureControl

- (void)addGestureToView:(UIView *)view {
    self.targetView = view;
    self.targetView.multipleTouchEnabled = YES;
    [self.singleTap requireGestureRecognizerToFail:self.doubleTap];
    [self.singleTap  requireGestureRecognizerToFail:self.panGR];
    [self.targetView addGestureRecognizer:self.singleTap];
    [self.targetView addGestureRecognizer:self.doubleTap];
    [self.targetView addGestureRecognizer:self.panGR];
    [self.targetView addGestureRecognizer:self.pinchGR];
    [self.targetView addGestureRecognizer:self.longPressGR];
}

- (void)removeGestureToView:(UIView *)view {
    [view removeGestureRecognizer:self.singleTap];
    [view removeGestureRecognizer:self.doubleTap];
    [view removeGestureRecognizer:self.panGR];
    [view removeGestureRecognizer:self.pinchGR];
    [view removeGestureRecognizer:self.longPressGR];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.panGR) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.targetView];
        CGFloat x = fabs(translation.x);
        CGFloat y = fabs(translation.y);
        if (x < y && self.disablePanMovingDirection & SRPrimaryStageDisablePanMovingDirectionVertical) {
            return NO;
        } else if (x > y && self.disablePanMovingDirection & SRPrimaryStageDisablePanMovingDirectionHorizontal) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    SRPrimaryStageGestureType type = SRPrimaryStageGestureTypeUnknown;
    if (gestureRecognizer == self.singleTap) type = SRPrimaryStageGestureTypeSingleTap;
    else if (gestureRecognizer == self.doubleTap) type = SRPrimaryStageGestureTypeDoubleTap;
    else if (gestureRecognizer == self.panGR) type = SRPrimaryStageGestureTypePan;
    else if (gestureRecognizer == self.pinchGR) type = SRPrimaryStageGestureTypePinch;
    CGPoint locationPoint = [touch locationInView:touch.view];
    if (locationPoint.x > _targetView.bounds.size.width / 2) {
        self.panLocation = SRPanLocationRight;
    } else {
        self.panLocation = SRPanLocationLeft;
    }
    
    switch (type) {
        case SRPrimaryStageGestureTypeUnknown: break;
        case SRPrimaryStageGestureTypePan: {
            if (self.disableTypes & SRPrimaryStageDisableGestureTypesPan) {
                return NO;
            }
        }
            break;
        case SRPrimaryStageGestureTypePinch: {
            if (self.disableTypes & SRPrimaryStageDisableGestureTypesPinch) {
                return NO;
            }
        }
            break;
        case SRPrimaryStageGestureTypeDoubleTap: {
            if (self.disableTypes & SRPrimaryStageDisableGestureTypesDoubleTap) {
                return NO;
            }
        }
            break;
        case SRPrimaryStageGestureTypeSingleTap: {
            if (self.disableTypes & SRPrimaryStageDisableGestureTypesSingleTap) {
                return NO;
            }
        }
            break;
        case SRPrimaryStageDisableGestureTypesLongPress: {
            if (self.disableTypes & SRPrimaryStageDisableGestureTypesLongPress) {
                return NO;
            }
        }
    }
    
    if (self.triggerCondition) return self.triggerCondition(self, type, gestureRecognizer, touch);
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (otherGestureRecognizer != self.singleTap &&
        otherGestureRecognizer != self.doubleTap &&
        otherGestureRecognizer != self.panGR &&
        otherGestureRecognizer != self.pinchGR) return NO;
    
    if (gestureRecognizer == self.panGR) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self.targetView];
        CGFloat x = fabs(translation.x);
        CGFloat y = fabs(translation.y);
        if (x < y && self.disablePanMovingDirection & SRPrimaryStageDisablePanMovingDirectionVertical) {
            return YES;
        } else if (x > y && self.disablePanMovingDirection & SRPrimaryStageDisablePanMovingDirectionHorizontal) {
            return YES;
        }
    }
    if (gestureRecognizer.numberOfTouches >= 2) {
        return NO;
    }
    return YES;
}

- (UITapGestureRecognizer *)singleTap {
    if (!_singleTap){
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _singleTap.delegate = self;
        _singleTap.delaysTouchesBegan = YES;
        _singleTap.delaysTouchesEnded = YES;
        _singleTap.numberOfTouchesRequired = 1;
        _singleTap.numberOfTapsRequired = 1;
    }
    return _singleTap;
}

- (UITapGestureRecognizer *)doubleTap {
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTap.delegate = self;
        _doubleTap.delaysTouchesBegan = YES;
        _doubleTap.delaysTouchesEnded = YES;
        _doubleTap.numberOfTouchesRequired = 1;
        _doubleTap.numberOfTapsRequired = 2;
    }
    return _doubleTap;
}

- (UIPanGestureRecognizer *)panGR {
    if (!_panGR) {
        _panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        _panGR.delegate = self;
        _panGR.delaysTouchesBegan = YES;
        _panGR.delaysTouchesEnded = YES;
        _panGR.maximumNumberOfTouches = 1;
        _panGR.cancelsTouchesInView = YES;
    }
    return _panGR;
}

- (UIPinchGestureRecognizer *)pinchGR {
    if (!_pinchGR) {
        _pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        _pinchGR.delegate = self;
        _pinchGR.delaysTouchesBegan = YES;
    }
    return _pinchGR;
}

- (UILongPressGestureRecognizer *)longPressGR {
    if (!_longPressGR) {
        _longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        _longPressGR.delegate = self;
        _longPressGR.delaysTouchesBegan = YES;
    }
    return _longPressGR;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    if (self.singleTapped) self.singleTapped(self);
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    if (self.doubleTapped) self.doubleTapped(self);
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    CGPoint translate = [pan translationInView:pan.view];
    CGPoint velocity = [pan velocityInView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            self.panMovingDirection = SRPanMovingDirectionUnkown;
            CGFloat x = fabs(velocity.x);
            CGFloat y = fabs(velocity.y);
            if (x > y) {
                self.panDirection = SRPanDirectionHorizontal;
            } else if (x < y) {
                self.panDirection = SRPanDirectionVertical;
            } else {
                self.panDirection = SRPanDirectionUnknown;
            }
            
            if (self.beganPan) self.beganPan(self, self.panDirection, self.panLocation);
        }
            break;
        case UIGestureRecognizerStateChanged: {
            switch (_panDirection) {
                case SRPanDirectionHorizontal: {
                    if (translate.x > 0) {
                        self.panMovingDirection = SRPanMovingDirectionRight;
                    } else {
                        self.panMovingDirection = SRPanMovingDirectionLeft;
                    }
                }
                    break;
                case SRPanDirectionVertical: {
                    if (translate.y > 0) {
                        self.panMovingDirection = SRPanMovingDirectionBottom;
                    } else {
                        self.panMovingDirection = SRPanMovingDirectionTop;
                    }
                }
                    break;
                case SRPanDirectionUnknown:
                    break;
            }
            if (self.changedPan) self.changedPan(self, self.panDirection, self.panLocation, velocity);
        }
            break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded: {
            if (self.endedPan) self.endedPan(self, self.panDirection, self.panLocation);
        }
            break;
        default:
            break;
    }
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinch {
    switch (pinch.state) {
        case UIGestureRecognizerStateEnded: {
            if (self.pinched) self.pinched(self, pinch.scale);
        }
            break;
        default:
            break;
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            if (self.longPressed) self.longPressed(self, SRLongPressGestureRecognizerStateBegan);
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (self.longPressed) self.longPressed(self, SRLongPressGestureRecognizerStateChanged);
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            if (self.longPressed) self.longPressed(self, SRLongPressGestureRecognizerStateEnded);
        }
            break;
        default: break;
    }
}

@end
