//
//  ConfigMdoel.h
//  Movie
//
//  Created by wmz on 2023/3/4.
//

#import <Foundation/Foundation.h>
#import "ApplovinModel.h"
#import "SubscribeModel.h"
#import "HTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ConfigModel : HTBaseModel
/// 插屏时间间隔（启动插屏、后台切前台插屏），45s内插屏广告不重复弹
@property (nonatomic,copy) NSString *var_inter_screen_ad_secs;
/// 播放页激励视频时间间隔，每隔9分钟自动弹一次激励视频
@property (nonatomic,copy) NSString *var_banner_ad_secs;
/// 播放页横屏顶部Banner时间间隔，手动关闭后180s后自动弹出
@property (nonatomic,copy) NSString *var_mbanner_secs;
/// 锁电影时间间隔，若该电影下发了锁，则免费观看6分钟后弹出提示框
@property (nonatomic,copy) NSString *var_play_lock_tlimit;
/// 横屏关闭时间 默认5秒
@property (nonatomic,copy) NSString *var_m1;
/// 订阅引导图
@property (nonatomic,strong) NSArray *var_i3;

/// 广告相关
@property (nonatomic,strong) ApplovinModel *var_applovin;
/// airplay
@property (nonatomic,strong) NSDictionary *var_airplay;

@end

NS_ASSUME_NONNULL_END
