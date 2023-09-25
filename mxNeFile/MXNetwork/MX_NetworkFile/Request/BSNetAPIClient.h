
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN


typedef void (^BLOCK_PostNetWorkBockBlock)(id _Nullable data,BOOL result);

typedef enum {
    ENUM_Get = 0,
    ENUM_Post,
} ENUM_NetworkMethodType;

@interface BSNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedInstance;
+ (void)ht_changeClient;

- (NSMutableDictionary *)lgjeropj_apiParams:(NSDictionary *)params;

- (void)ht_requestWithPath:(nullable NSString *)aPath andParams:(nullable NSDictionary *)params andViewController:(nullable UIViewController*)vc andBlock:(nullable BLOCK_PostNetWorkBockBlock)block;

- (void)ht_requestWithPath:(nullable NSString *)aPath andParams:(nullable NSDictionary *)params andViewController:(nullable UIViewController*)vc andStatus:(BOOL)needStatus andBlock:(nullable BLOCK_PostNetWorkBockBlock)block;

- (void)ht_downloadWithUrl:(NSString*)url andBlock:(nullable BLOCK_PostNetWorkBockBlock)block;
    
@end

NS_ASSUME_NONNULL_END
