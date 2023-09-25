//
//  SRReachabilityManager.m
//  SRPrimaryStage
//
// Copyright (c) 2016年 任子丰 ( http://github.com/renzifeng )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "SRReachabilityManager.h"
#if !TARGET_OS_WATCH
#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

NSString * const SRReachabilityDidChangeNotification = @"com.SRPrimaryStage.reachability.change";
NSString * const SRReachabilityNotificationStatusItem = @"SRNetworkingReachabilityNotificationStatusItem";

typedef void (^SRReachabilityStatusBlock)(SRReachabilityStatus status);

NSString * SRStringFromNetworkReachabilityStatus(SRReachabilityStatus status) {
    switch (status) {
        case SRReachabilityStatusNotReachable:
            return @"Not Reachable";
        case SRReachabilityStatusReachableViaWiFi:
            return @"Reachable via WiFi";
        case SRReachabilityStatusReachableVia2G:
            return @"Reachable via 2G";
        case SRReachabilityStatusReachableVia3G:
            return @"Reachable via 3G";
        case SRReachabilityStatusReachableVia4G:
            return @"Reachable via 4G";
        case SRReachabilityStatusReachableVia5G:
            return @"Reachable via 5G";
        case SRReachabilityStatusUnknown:
        default:
            return @"Unknown";
    }
}

static SRReachabilityStatus SRReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    
    SRReachabilityStatus status = SRReachabilityStatusUnknown;
    if (isNetworkReachable == NO) {
        status = SRReachabilityStatusNotReachable;
    }
#if TARGET_OS_IPHONE
    else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        CTTelephonyNetworkInfo * info = [[CTTelephonyNetworkInfo alloc] init];
        NSString *currentRadioAccessTechnology = info.currentRadioAccessTechnology;
        if (@available(iOS 12.1, *)) {
            if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
                NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
                if (radioDic.allKeys.count) {
                    currentRadioAccessTechnology = [radioDic objectForKey:radioDic.allKeys[0]];
                }
            }
        }
        if (currentRadioAccessTechnology) {
            if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]
                || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]
                || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
                status = SRReachabilityStatusReachableVia2G;
            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSDPA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyHSUPA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]
                       || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
                status = SRReachabilityStatusReachableVia3G;
            } else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                status = SRReachabilityStatusReachableVia4G;
            } else if (@available(iOS 14.1, *)) {
                if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNRNSA]
                    || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyNR]) {
                    status = SRReachabilityStatusReachableVia5G;
                }
            } else {
                status = SRReachabilityStatusUnknown;
            }
        }
    }
#endif
    else {
        status = SRReachabilityStatusReachableViaWiFi;
    }
    return status;
    
}

/**
 * Queue a status change notification for the main thread.
 *
 * This is done to ensure that the notifications are received in the same order
 * as they are sent. If notifications are sent directly, it is possible that
 * a queued notification (for an earlier status condition) is processed after
 * the later update, resulting in the listener being left in the wrong state.
 */
static void SRPostReachabilityStatusChange(SCNetworkReachabilityFlags flags, SRReachabilityStatusBlock block) {
    SRReachabilityStatus status = SRReachabilityStatusForFlags(flags);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (block) block(status);
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        NSMutableDictionary *userInfo = @{}.mutableCopy;
        userInfo[SRReachabilityNotificationStatusItem] = @(status);
        
        [notificationCenter postNotificationName:SRReachabilityDidChangeNotification object:nil userInfo:userInfo];
    });
}

static void SRPrimaryStageReachabilityCallback(SCNetworkReachabilityRef __unused target, SCNetworkReachabilityFlags flags, void *info) {
    SRPostReachabilityStatusChange(flags, (__bridge SRReachabilityStatusBlock)info);
}


static const void * SRReachabilityRetainCallback(const void *info) {
    return Block_copy(info);
}

static void SRReachabilityReleaseCallback(const void *info) {
    if (info) {
        Block_release(info);
    }
}

@interface SRReachabilityManager ()

@property (readonly, nonatomic, assign) SCNetworkReachabilityRef networkReachability;
@property (readwrite, nonatomic, assign) SRReachabilityStatus networkReachabilityStatus;
@property (readwrite, nonatomic, copy) SRReachabilityStatusBlock networkReachabilityStatusBlock;

@end

@implementation SRReachabilityManager

+ (instancetype)sharedManager {
    static SRReachabilityManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [self manager];
    });
    return _sharedManager;
}

+ (instancetype)managerForDomain:(NSString *)domain {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, [domain UTF8String]);
    SRReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}

+ (instancetype)managerForAddress:(const void *)address {
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)address);
    SRReachabilityManager *manager = [[self alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return manager;
}

+ (instancetype)manager {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self managerForAddress:&address];
}

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability {
    self = [super init];
    if (!self) {
        return nil;
    }
    _networkReachability = CFRetain(reachability);
    self.networkReachabilityStatus = SRReachabilityStatusUnknown;
    
    return self;
}

- (instancetype)init NS_UNAVAILABLE
{
    return nil;
}

- (void)dealloc {
    [self stopMonitoring];
    if (_networkReachability != NULL) {
        CFRelease(_networkReachability);
    }
}

#pragma mark -

- (BOOL)isReachable {
    return [self isReachableViaWWAN] || [self isReachableViaWiFi];
}

- (BOOL)isReachableViaWWAN {
    return (self.networkReachabilityStatus == SRReachabilityStatusReachableVia2G ||self.networkReachabilityStatus == SRReachabilityStatusReachableVia3G || self.networkReachabilityStatus == SRReachabilityStatusReachableVia4G);
}

- (BOOL)isReachableViaWiFi {
    return self.networkReachabilityStatus == SRReachabilityStatusReachableViaWiFi;
}

#pragma mark -

- (void)startMonitoring {
    [self stopMonitoring];
    if (!self.networkReachability) {
        return;
    }
    
    __weak __typeof(self)weakSelf = self;
    SRReachabilityStatusBlock callback = ^(SRReachabilityStatus status) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.networkReachabilityStatus = status;
        if (strongSelf.networkReachabilityStatusBlock) {
            strongSelf.networkReachabilityStatusBlock(status);
        }
    };
    
    SCNetworkReachabilityContext context = {0, (__bridge void *)callback, SRReachabilityRetainCallback, SRReachabilityReleaseCallback, NULL};
    SCNetworkReachabilitySetCallback(self.networkReachability, SRPrimaryStageReachabilityCallback, &context);
    SCNetworkReachabilityScheduleWithRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(self.networkReachability, &flags)) {
            SRPostReachabilityStatusChange(flags, callback);
        }
    });
}

- (void)stopMonitoring {
    if (!self.networkReachability) {
        return;
    }
    
    SCNetworkReachabilityUnscheduleFromRunLoop(self.networkReachability, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

#pragma mark -

- (NSString *)localizedNetworkReachabilityStatusString {
    return SRStringFromNetworkReachabilityStatus(self.networkReachabilityStatus);
}

#pragma mark -

- (void)setReachabilityStatusChangeBlock:(void (^)(SRReachabilityStatus status))block {
    self.networkReachabilityStatusBlock = block;
}

#pragma mark - NSKeyValueObserving

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    if ([key isEqualToString:@"reachable"] || [key isEqualToString:@"reachableViaWWAN"] || [key isEqualToString:@"reachableViaWiFi"]) {
        return [NSSet setWithObject:@"networkReachabilityStatus"];
    }
    return [super keyPathsForValuesAffectingValueForKey:key];
}

@end
#endif
