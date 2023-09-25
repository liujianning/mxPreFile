//
//  SRAdManager.h
//  SRInterimCode
//
//  Created by admin on 2023/5/19.
//

#import <Foundation/Foundation.h>
#import "SRPeriodProtocol.h"
#import "SRBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRPeriodManager : NSObject

+ (SRPeriodManager *)shared;

@property (nonatomic, strong) id <SRPeriodProtocol> ad;

@property (nonatomic, strong) SRBaseView *bannerView;

@end

NS_ASSUME_NONNULL_END
