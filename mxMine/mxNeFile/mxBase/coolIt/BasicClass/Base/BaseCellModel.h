//
//  BaseCellModel.h
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"
#import "PostCommon_Enum.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseCellModel : HTBaseModel

/// 自定义 是否假卡片数据
@property (nonatomic, assign) BOOL var_fake;
/// 自定义 支付价格
@property (nonatomic, copy) NSString *var_pay;
/// 自定义 是否活动
@property (nonatomic, assign) BOOL var_activity;
/// 记录接口数据
@property (nonatomic, strong) NSDictionary *var_params;

@property (nonatomic,copy) NSString *var_title;
@property (nonatomic,copy) NSString *var_tag;
@property (nonatomic,copy) NSString *var_detail;
@property (nonatomic,strong) UIColor *var_titleColor;
@property (nonatomic,strong) UIColor *var_detailColor;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *var_className;
@property (nonatomic,strong) NSIndexPath *var_indexPath;

@property (nonatomic,assign) CGSize var_itemSize;

@property (nonatomic,strong) id data;

@property (nonatomic,assign) BOOL var_select;
@property (nonatomic,assign) BOOL var_show;
@property (nonatomic,assign) BOOL var_showPlay;
@property (nonatomic,assign) BOOL var_hideStatus;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) NSInteger var_pageNum;
@property (nonatomic, strong,nullable) id image;

@property (nonatomic,assign) BOOL var_hide;

@property (nonatomic,copy) NSString *var_path;
@property (nonatomic,copy) NSString *var_name2;
@property (nonatomic,copy) NSString *var_s3;
@property (nonatomic,copy) NSString *var_s3img;
@property (nonatomic,copy) NSString *var_appleid;
@property (nonatomic,copy) NSString *var_bundleid;
@property (nonatomic,copy) NSString *var_k2;
@property (nonatomic,copy) NSString *var_l1;
@property (nonatomic,copy) NSString *var_icon1;
@property (nonatomic,copy) NSString *var_iconType;
@property (nonatomic,copy) NSString *var_channelType;
@property (nonatomic,copy) NSString *var_text1;
@property (nonatomic,copy) NSString *var_text2;
///埋点
@property (nonatomic,copy) NSString *var_kid;

+ (BaseCellModel*)ht_nomal:(NSString*)var_className;

@end

NS_ASSUME_NONNULL_END
