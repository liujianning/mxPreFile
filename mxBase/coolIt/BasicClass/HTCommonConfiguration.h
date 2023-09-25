//
//  HTCommonConfiguration.h
//  PostTest
//
//  Created by 李雪健 on 2023/7/27.
//

#import <Foundation/Foundation.h>
//#import "ZQAccountModel.h"//测试
#import "BaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonConfiguration : NSObject

+ (HTCommonConfiguration *)lgjeropj_shared;

// vip状态
@property (nonatomic, copy) BOOL (^BLOCK_vipBlock) (void);
// baseURL
@property (nonatomic, copy) NSString * (^BLOCK_baseURLBlock) (void);
// 埋点URL
@property (nonatomic, copy) NSString * (^BLOCK_dataURLBlock) (void);
// app_id
@property (nonatomic, copy) NSString * (^BLOCK_appIdBlock) (void);
// appleId
@property (nonatomic, copy) NSString * (^BLOCK_appleIdBlock) (void);
// airDict
@property (nonatomic, copy) NSDictionary * (^BLOCK_airDictBlock) (void);
// 多语言
@property (nonatomic, copy) NSDictionary * (^BLOCK_mutilLanguageBlock) (void);
// 导量 gd_dictionary
@property (nonatomic, copy) NSDictionary * (^BLOCK_gdBlock) (void);
// 开关状态
@property (nonatomic, copy) BOOL (^BLOCK_switchStateBlock) (void);
// 深链公参
@property (nonatomic, copy) NSMutableDictionary * (^BLOCK_deepLinkParamsBlock) (void);
// 停止广告
@property (nonatomic, copy) void (^BLOCK_stopAdBlock) (BOOL stop);
// 是否广告
@property (nonatomic, copy) BOOL (^BLOCK_getStopAdBlock) (void);
// 检测强制登录
@property (nonatomic, copy) void (^BLOCK_checkLoginBlock) (void);
// 跳转登录
@property (nonatomic, copy) void (^BLOCK_toLoginBlock) (NSString *source);
// 退出登录
@property (nonatomic, copy) void (^BLOCK_toLogoutBlock) (void);
// 订阅验证
@property (nonatomic, copy) void (^BLOCK_subscribeVerifyBlock) (void);
// 显示tabbar订阅红点
@property (nonatomic, copy) void (^BLOCK_showRedBlock) (void);
// applovin
@property (nonatomic, copy) id (^BLOCK_appLovinSDKBlock) (void);
// 引导页
@property (nonatomic, copy) void (^BLOCK_showGuidePageBlock) (void);

@property (nonatomic, copy) void (^BLOCK_commonMovieItemCellTapActionBlock) (BaseCellModel *model, NSIndexPath *indexPath, NSString *var_movielist_id, NSString *list_type, NSString *var_source, BOOL var_like);
//跳转播放页
@property (nonatomic, copy) void (^BLOCK_toPlayMovieBlock) (BaseCellModel *model, NSString *source);
// 订阅事件
@property (nonatomic, copy) void (^BLOCK_querryPurchaseWithIDBlock) (NSString *var_purchID);
// 前往订阅页
@property (nonatomic, copy) void (^BLOCK_toPayBlock) (UIViewController * _Nullable var_currentVC, NSString *source);
// 前往
@property (nonatomic, copy) void (^BLOCK_windowPushToVCBlock) (UIViewController * _Nullable var_toVC, UIViewController * _Nullable var_currentVC, BOOL var_hide);
//打开web
@property (nonatomic, copy) void (^BLOCK_toWebUrlBlock) (NSString *var_key);
// 订阅页导量深链
@property (nonatomic, copy) void (^BLOCK_prelumDeepLinkBlock) (void);
// takePartInfo公参
@property (nonatomic, copy) NSDictionary * (^BLOCK_takePartInfoParamsBlock) (void);

@property (nonatomic, copy) void (^BLOCK_updateRootBlock) (BOOL var_key);

@property (nonatomic, copy) void (^BLOCK_LanguageBlock) (void);

//邀请码
@property (nonatomic, copy) void (^BLOCK_verifyInviteCodeBlock) (NSString *var_key);
@property (nonatomic, copy) void (^BLOCK_baseBackBlock) (void);
@property (nonatomic, copy) void (^BLOCK_remindMeBlock) (void);
@property (nonatomic, copy) void (^BLOCK_allowRotationBlock) (NSInteger var_key);
@property (nonatomic, copy) UIViewController * (^BLOCK_currentVCBlock) (void);

@property (nonatomic, copy) void (^BLOCK_enterActivityBlock) (BOOL var_activity);
@property (nonatomic, copy) void (^BLOCK_enterPreVCBlock) (BOOL var_PreVC);
// 深链
@property (nonatomic, copy) void (^BLOCK_deepLinkBlock) (NSDictionary *params);
// openAd
@property (nonatomic, copy) void (^BLOCK_AppDelegateOpenAdBlock) (void);
@end

NS_ASSUME_NONNULL_END
