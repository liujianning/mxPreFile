

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SRVehicleBrightnessType) {
    SRVehicleTypeVehicle,
    SRVehicleTypeumeBrightness
};

@interface SRVehicleBrightnessView : UIView

@property (nonatomic, assign, readonly) SRVehicleBrightnessType vehicleType;
@property (nonatomic, strong, readonly) UIProgressView *progressView;
@property (nonatomic, strong, readonly) UIImageView *iconImageView;

- (void)updatePercent:(CGFloat)percent withVehicleType:(SRVehicleBrightnessType)vehicleType;

- (void)addShortVehicleView;

- (void)removeShortVehicleView;

@end
