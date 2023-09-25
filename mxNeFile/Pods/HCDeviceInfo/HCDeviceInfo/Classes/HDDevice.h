//
//  HDDevice.h
//  Movie
//
//  Created by wmz on 2023/2/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface HDDevice : NSObject

@property (nonatomic, copy) NSString * token;

@property (nonatomic, copy) NSString * version;

@property (nonatomic, copy) NSString * name;

@property (nonatomic, copy) NSString * model;

@property (nonatomic, copy) NSString * systemName;

@property (nonatomic, copy) NSString * systemVersion;

@property (nonatomic, copy) NSString * identifier;

@property (nonatomic, copy) NSString * modelName;

@property (nonatomic, copy) NSString * language;

- (NSString *)getIMSIInfo;

@end

NS_ASSUME_NONNULL_END
