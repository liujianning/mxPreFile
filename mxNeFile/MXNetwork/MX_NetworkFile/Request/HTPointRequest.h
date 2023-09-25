//
//  HTPointRequest.h
//  Movie
//
//  Created by wmz on 2023/4/25.
//
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN

@interface HTPointRequest : AFHTTPSessionManager
+ (instancetype)sharedInstance;
+ (void)ht_changeClient;
- (void)ht_point:(NSString*)name params:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
