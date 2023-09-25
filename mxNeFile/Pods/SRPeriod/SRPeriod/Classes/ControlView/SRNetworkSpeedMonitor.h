

#import <Foundation/Foundation.h>

extern NSString *const SRDownloadNetworkSpeedNotificationKey;
extern NSString *const SRUploadNetworkSpeedNotificationKey;
extern NSString *const SRNetworkSpeedNotificationKey;

@interface SRNetworkSpeedMonitor : NSObject

@property (nonatomic, copy, readonly) NSString *downloadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString *uploadNetworkSpeed;

- (void)startNetworkSpeedMonitor;
- (void)stopNetworkSpeedMonitor;

@end
