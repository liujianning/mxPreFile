//
//  SRAdManager.m
//  SRInterimCode
//
//  Created by admin on 2023/5/19.
//

#import "SRPeriodManager.h"

@implementation SRPeriodManager

+ (SRPeriodManager *)shared {
    
    static SRPeriodManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SRPeriodManager alloc] init];
    });
    return manager;
}

@end
