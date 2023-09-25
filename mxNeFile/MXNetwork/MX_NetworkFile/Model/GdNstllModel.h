//
//  GdNstllModel.h
//  Movie
//
//  Created by wmz on 2023/5/14.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GdNstllModel : HTBaseModel
//接收导量包的bundleid
@property (nonatomic,copy) NSString *var_a1;
//接收导量包的深链
@property (nonatomic,copy) NSString *var_l1;
//接收导量包的商店地址
@property (nonatomic,copy) NSString *var_l2;
//老版本接收导量包链接
@property (nonatomic,copy) NSString *var_link;
//0不导量 1强制导量 2非强制导量
@property (nonatomic,assign) int status;
//0只弹一次 1每次都弹
@property (nonatomic,copy) NSString *var_k1;
//文案 gd
@property (nonatomic,copy) NSString *var_title;
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *var_t3;
@property (nonatomic,copy) NSString *var_t4;
@property (nonatomic,copy) NSString *var_update;
@property (nonatomic,copy) NSString *cancel;
//文案 d2
@property (nonatomic,copy) NSString *var_t1;
@property (nonatomic,copy) NSString *var_t2;
@property (nonatomic,copy) NSString *var_b1;
@property (nonatomic,copy) NSString *var_b2;

//深链中间页是否跳过，1跳过，0不跳过
@property (nonatomic,copy) NSString *var_k2;
//导量包的深链中间页标题
@property (nonatomic,copy) NSString *var_c4;
//导量包的深链中间页描述
@property (nonatomic,copy) NSString *var_c5;
//深链中间页显示的包logo
@property (nonatomic,copy) NSString *var_logo;
@end

NS_ASSUME_NONNULL_END
