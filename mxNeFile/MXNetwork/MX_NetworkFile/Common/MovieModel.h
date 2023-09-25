//
//  MovieModel.h
//  Movie
//
//  Created by wmz on 2023/3/3.
//

#import "BaseCellModel.h"
#import "SRTModel.h"
#import "SessionTModel.h"
#import "LinkModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MovieModel : BaseCellModel
@property (nonatomic,assign) int var_medit;
@property (nonatomic,copy) NSString *var_id;
@property (nonatomic,copy) NSString *var_cover;
@property (nonatomic,copy) NSString *var_rate;
@property (nonatomic,copy) NSString *var_data_type;
@property (nonatomic,copy) NSString *var_eps_cnts;
@property (nonatomic,copy) NSString *var_pub_date;
@property (nonatomic,copy) NSString *var_ssn_id;
@property (nonatomic,copy) NSArray *var_eps_list;
@property (nonatomic,copy) NSString *var_stars;
@property (nonatomic,copy) NSString *var_tags;
@property (nonatomic,copy) NSString *var_country;
@property (nonatomic,copy) NSString *var_quality;
@property (nonatomic,copy) NSString *var_ss_eps;
@property (nonatomic,copy) NSString *var_new_flag;
@property (nonatomic,copy) NSString *var_nw_flag;
@property (nonatomic,assign) int var_best;
@property (nonatomic,copy) NSString *var_board;
@property (nonatomic,copy) NSString *var_sub;
@property (nonatomic,copy) NSString *var_dub;
@property (nonatomic,copy) NSString *var_ep;
@property (nonatomic,copy) NSString *var_age;
@property (nonatomic,copy) NSString *var_m_type_2;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *var_desc;
@property (nonatomic,assign) NSInteger var_play_lock;

@property (nonatomic,copy) NSString *var_v_360p;
@property (nonatomic,copy) NSString *var_v_720p;
@property (nonatomic,copy) NSString *var_v_1080p;
@property (nonatomic,copy) NSString *var_star_name;

@property (nonatomic,copy) NSString *var_tt_id;
@property (nonatomic,strong) LinkModel *var_hd;
@property (nonatomic,strong) LinkModel *var_sd;
@property (nonatomic,copy)  NSArray *var_ssn_list;
@property (nonatomic,assign) NSInteger var_eps_num;

///custom
@property (nonatomic,strong) NSMutableDictionary *var_rctInfo;
@property (nonatomic,strong) SRTModel *var_currentSRTModel;
/// 默认0
@property (nonatomic,assign) NSInteger var_subtitleTime;
/// 默认当前
@property (nonatomic,assign) NSInteger var_subtitleIndex;

///历史相关参数
@property (nonatomic,assign) NSInteger var_step;
@property (nonatomic,assign) NSTimeInterval var_stepCurrentTime;
@property (nonatomic,copy,nullable) NSString* var_stepMovieId;
@property (nonatomic,copy,nullable) NSString* var_stepSessionId;
@property (nonatomic,copy,nullable) NSString* var_stepLanguage;

@property (nonatomic,strong) BaseCellModel *var_currentLanguageMdoel;
@property (nonatomic,assign) BOOL var_timeshow;
@property (nonatomic,assign) BOOL var_subtitleShow;
@property (nonatomic,strong) NSMutableArray *var_languageDatasource;
@property (nonatomic,assign) BOOL var_shouldOpen;

@end


NS_ASSUME_NONNULL_END
