//
//  HTManage.h
//  Movie
//
//  Created by wmz on 2023/2/13.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "MovieModel.h"
#import "ShareModel.h"
#import "ConfigModel.h"
#import "PayModel.h"
#import "HTPointRequest.h"
#import "PostCommon_Enum.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^BLOCK_UserModelBlock)( UserModel * _Nullable var_userModel);
typedef void (^BLOCK_PayModelBlock)( PayModel * _Nullable var_payModel);

@interface HTManage : NSObject

@property (nonatomic,strong) UserModel *model2;
@property (nonatomic,strong) ShareModel *model3;
@property (nonatomic,strong) ConfigModel *model4;
@property (nonatomic,strong) SubscribeModel *model5;
@property (nonatomic,strong) PayModel *model6;

+ (instancetype)sharedInstance;
///检测订阅
- (BOOL)ht_checkSub;
- (void)ht_getUserInfoWithUid:(NSString*)uid andBlock:(BLOCK_UserModelBlock)block;
- (void)ht_getUserInfo:(nullable BLOCK_UserModelBlock)block;
///检测订阅状态
- (void)ht_updateVipWithBlock:(nullable BLOCK_PayModelBlock)block source:(NSString*)source;

- (void)ht_getAllConfig;
///  105 获取默认搜索词
///  84 获取广告配置和冷却时间
///  78 获取分享链接
- (void)ht_getConfig:(NSString*)key andParams:(NSDictionary *)dict andBlock:(nullable BLOCK_EventViewBlock)block;

/// 历史搜索
- (void)ht_saveSearchModel:(BaseCellModel*)model;
- (NSArray<BaseCellModel*>*)ht_getSearchDatasource;
- (void)ht_deleteAllSearch;

///解锁过的电影
- (void)ht_saveLockIds:(NSString*)ids;
- (NSArray<NSString*>*)ht_getLockIds;
- (BOOL)ht_checkLockIds:(NSString*)ids;

/// 收藏存储
- (BOOL)ht_saveCollectModel:(MovieModel*)model andDele:(BOOL)del;
- (nullable MovieModel*)ht_checkCollect:(NSString*)ids;
- (NSArray<MovieModel*>*)ht_getCollectDatasource;
- (void)ht_updateCollect:(MovieModel*)model;

///播放历史
- (nullable MovieModel*)ht_checkHistory:(NSString*)ids;
- (BOOL)ht_saveHistoryModel:(MovieModel*)model;
- (BOOL)ht_saveHistoryModel:(MovieModel*)model andDele:(BOOL)del;
- (NSArray<MovieModel*>*)ht_getHistoryDatasource;

+ (UIActivityViewController*)ht_shareTitle:(nullable NSString*)title andURL:(nullable NSString*)url andImage:(nullable NSString*)image;
+ (UIActivityViewController*)ht_shareTitle:(nullable NSString*)title andURL:(nullable NSString*)url andImage:(nullable NSString*)image andBlock:(nullable BLOCK_EventViewBlock)block;
@end

NS_ASSUME_NONNULL_END
