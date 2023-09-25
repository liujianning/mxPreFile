//
//  HDDevice.m
//  Movie
//
//  Created by wmz on 2023/2/26.
//

#import "HDDevice.h"
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <sys/types.h>
#import <sys/utsname.h>
#import <mach/mach.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation HDDevice

- (NSString *)version {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = infoDictionary[@"CFBundleShortVersionString"];
    return version;
}

- (NSString *)name {
    return UIDevice.currentDevice.name;
}

- (NSString *)model {
    return [[UIDevice currentDevice] model];
}

- (NSString *)systemName {
    return  [[UIDevice currentDevice] systemName];
}

- (NSString *)systemVersion {
    return  [[UIDevice currentDevice] systemVersion];
}

- (NSString *)identifier {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

- (NSString *)language {
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSArray  *array = [language componentsSeparatedByString:@"-"];
    NSString *currentLanguage = array[0];
    return currentLanguage;
}

- (NSString *)modelName {
    size_t size;
    int number = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    number = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *string = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return (string ?: @"Unknown");
}

- (NSString *)getIMSIInfo {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = nil;
    NSString *radioType = nil;
    if (@available(iOS 12.1, *)) {
        if (info && [info respondsToSelector:@selector(serviceSubscriberCellularProviders)]) {
            NSDictionary *dic = [info serviceSubscriberCellularProviders];
            if (dic.allKeys.count) {
                carrier = [dic objectForKey:dic.allKeys[0]];
            }
        }
        if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
            NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
            if (radioDic.allKeys.count) {
                radioType = [radioDic objectForKey:radioDic.allKeys[0]];
            }
        }
    }
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    return [NSString stringWithFormat:@"%@%@",mcc ?: @"", mnc ?: @""];
}

@end
