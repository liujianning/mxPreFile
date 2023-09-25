//
//  PayServerModel.h
//  Movie
//
//  Created by wmz on 2023/5/14.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PayServerModel : HTBaseModel
///1vip 0非vip
@property(nonatomic,copy)NSString *var_val2;
@property(nonatomic,copy)NSString *var_app_os;
@property(nonatomic,copy)NSString *var_shelf;
@property(nonatomic,copy)NSString *var_mail;
@property(nonatomic,copy)NSString *var_app_id;
@property(nonatomic,copy)NSString *var_app_name;
@property(nonatomic,copy)NSString *var_k6;
@property(nonatomic,copy)NSString *var_k7;
@property(nonatomic,copy)NSString *var_k5;
// 是否工具包订阅用户 1=电影 2=工具
@property(nonatomic,copy)NSString *var_t1;
@property(nonatomic,assign)BOOL var_ubt;
@property(nonatomic,assign)int var_logout;
@property(nonatomic,copy)NSString *var_pid;
@property(nonatomic,copy)NSString *var_is_trial_period;
@property(nonatomic,copy)NSString *var_is_in_intro_offer_period;
@property(nonatomic,copy)NSString *var_auto_renew_status;

@end

NS_ASSUME_NONNULL_END
