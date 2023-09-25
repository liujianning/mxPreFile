

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SRPrimaryStageGestureType) {
    SRPrimaryStageGestureTypeUnknown,
    SRPrimaryStageGestureTypeSingleTap,
    SRPrimaryStageGestureTypeDoubleTap,
    SRPrimaryStageGestureTypePan,
    SRPrimaryStageGestureTypePinch
};

typedef NS_ENUM(NSUInteger, SRPanDirection) {
    SRPanDirectionUnknown,
    SRPanDirectionVertical,
    SRPanDirectionHorizontal,
};

typedef NS_ENUM(NSUInteger, SRPanLocation) {
    SRPanLocationUnknown,
    SRPanLocationLeft,
    SRPanLocationRight,
};

typedef NS_ENUM(NSUInteger, SRPanMovingDirection) {
    SRPanMovingDirectionUnkown,
    SRPanMovingDirectionTop,
    SRPanMovingDirectionLeft,
    SRPanMovingDirectionBottom,
    SRPanMovingDirectionRight,
};

typedef NS_OPTIONS(NSUInteger, SRPrimaryStageDisableGestureTypes) {
    SRPrimaryStageDisableGestureTypesNone         = 0,
    SRPrimaryStageDisableGestureTypesSingleTap    = 1 << 0,
    SRPrimaryStageDisableGestureTypesDoubleTap    = 1 << 1,
    SRPrimaryStageDisableGestureTypesPan          = 1 << 2,
    SRPrimaryStageDisableGestureTypesPinch        = 1 << 3,
    SRPrimaryStageDisableGestureTypesLongPress    = 1 << 4,
    SRPrimaryStageDisableGestureTypesAll          = (SRPrimaryStageDisableGestureTypesSingleTap | SRPrimaryStageDisableGestureTypesDoubleTap | SRPrimaryStageDisableGestureTypesPan | SRPrimaryStageDisableGestureTypesPinch | SRPrimaryStageDisableGestureTypesLongPress)
};

typedef NS_OPTIONS(NSUInteger, SRPrimaryStageDisablePanMovingDirection) {
    SRPrimaryStageDisablePanMovingDirectionNone         = 0,
    SRPrimaryStageDisablePanMovingDirectionVertical     = 1 << 0,
    SRPrimaryStageDisablePanMovingDirectionHorizontal   = 1 << 1,
    SRPrimaryStageDisablePanMovingDirectionAll          = (SRPrimaryStageDisablePanMovingDirectionVertical | SRPrimaryStageDisablePanMovingDirectionHorizontal)
};

typedef NS_ENUM(NSUInteger, SRLongPressGestureRecognizerState) {
    SRLongPressGestureRecognizerStateBegan,
    SRLongPressGestureRecognizerStateChanged,
    SRLongPressGestureRecognizerStateEnded
};

@interface SRPeriodGestureControl : NSObject

@property (nonatomic, copy, nullable) BOOL(^triggerCondition)(SRPeriodGestureControl *control, SRPrimaryStageGestureType type, UIGestureRecognizer *gesture, UITouch *touch);

@property (nonatomic, copy, nullable) void(^singleTapped)(SRPeriodGestureControl *control);

@property (nonatomic, copy, nullable) void(^doubleTapped)(SRPeriodGestureControl *control);

@property (nonatomic, copy, nullable) void(^beganPan)(SRPeriodGestureControl *control, SRPanDirection direction, SRPanLocation location);

@property (nonatomic, copy, nullable) void(^changedPan)(SRPeriodGestureControl *control, SRPanDirection direction, SRPanLocation location, CGPoint velocity);

@property (nonatomic, copy, nullable) void(^endedPan)(SRPeriodGestureControl *control, SRPanDirection direction, SRPanLocation location);

@property (nonatomic, copy, nullable) void(^pinched)(SRPeriodGestureControl *control, float scale);

@property (nonatomic, copy, nullable) void(^longPressed)(SRPeriodGestureControl *control, SRLongPressGestureRecognizerState state);

@property (nonatomic, strong, readonly) UITapGestureRecognizer *singleTap;

@property (nonatomic, strong, readonly) UITapGestureRecognizer *doubleTap;

@property (nonatomic, strong, readonly) UIPanGestureRecognizer *panGR;

@property (nonatomic, strong, readonly) UIPinchGestureRecognizer *pinchGR;

@property (nonatomic, strong, readonly) UILongPressGestureRecognizer *longPressGR;

@property (nonatomic, readonly) SRPanDirection panDirection;

@property (nonatomic, readonly) SRPanLocation panLocation;

@property (nonatomic, readonly) SRPanMovingDirection panMovingDirection;

@property (nonatomic) SRPrimaryStageDisableGestureTypes disableTypes;

@property (nonatomic) SRPrimaryStageDisablePanMovingDirection disablePanMovingDirection;

- (void)addGestureToView:(UIView *)view;

- (void)removeGestureToView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
