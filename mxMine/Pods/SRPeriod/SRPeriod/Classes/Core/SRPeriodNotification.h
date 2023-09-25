
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SRPrimaryStageBackgroundState) {
    SRPrimaryStageBackgroundStateForeground,
    SRPrimaryStageBackgroundStateBackground,
};

@interface SRPeriodNotification : NSObject

@property (nonatomic, readonly) SRPrimaryStageBackgroundState backgroundState;

@property (nonatomic, copy, nullable) void(^willResignActive)(SRPeriodNotification *registrar);

@property (nonatomic, copy, nullable) void(^didBecomeActive)(SRPeriodNotification *registrar);

@property (nonatomic, copy, nullable) void(^newDeviceAvailable)(SRPeriodNotification *registrar);

@property (nonatomic, copy, nullable) void(^oldDeviceUnavailable)(SRPeriodNotification *registrar);

@property (nonatomic, copy, nullable) void(^categoryChange)(SRPeriodNotification *registrar);

@property (nonatomic, copy, nullable) void(^vehicleChanged)(float vehicle);

@property (nonatomic, copy, nullable) void(^audioInterruptionCallback)(AVAudioSessionInterruptionType interruptionType);

- (void)addNotification;

- (void)removeNotification;

@end

NS_ASSUME_NONNULL_END
