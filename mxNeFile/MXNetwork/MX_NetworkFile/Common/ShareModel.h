//
//  ShareModel.h
//  Movie
//
//  Created by wmz on 2023/3/4.
//

#import <Foundation/Foundation.h>
#import "GdNstllModel.h"
#import "HTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ShareModel : HTBaseModel
@property (nonatomic,copy) NSString *var_link;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *var_song_link;
@property (nonatomic,copy) NSString *var_song_text;
@property (nonatomic,copy) NSString *var_mtext;// 播放页-电影分享文案
@property (nonatomic,copy) NSString *var_mlink;// 播放页-电影分享链接
@property (nonatomic,copy) NSString *var_tttext;// 播放页-电视剧分享链接
@property (nonatomic,copy) NSString *var_ttlink;// 播放页-电视剧分享链接
@property (nonatomic,copy) NSString *var_text1;// 播放页-电影锁电影的分享文案
@property (nonatomic,copy) NSString *var_mlocklink;// 播放页-电影锁电影的分享链接
@property (nonatomic,copy) NSString *var_text2;// 播放页-电影锁电视剧的分享文案
@property (nonatomic,copy) NSString *var_ttlocklink;// 播放页-电影锁电视剧的分享链接
@property (nonatomic,copy) NSString *var_app_link;
@property (nonatomic,copy) NSString *var_app_text;
@property (nonatomic,copy) NSString *var_appm_link;//app分享链接
@property (nonatomic,copy) NSString *var_appm_text;// app分享文案
///导量
@property (nonatomic,strong)GdNstllModel *var_gd_nstll;
@property (nonatomic,strong)GdNstllModel *var_d2;
@end

NS_ASSUME_NONNULL_END
