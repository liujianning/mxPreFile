//
//  PayLocalModel.h
//  Movie
//
//  Created by wmz on 2023/5/14.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PayLocalModel : HTBaseModel
@property(nonatomic,copy)NSString *var_pid;

@property(nonatomic,copy)NSString *var_k5;
///1vip 0 非vip
@property(nonatomic,assign)NSInteger var_value;
///vip失效时间
@property(nonatomic,copy)NSString *var_k6;
///vip购买时间
@property(nonatomic,copy)NSString *var_k7;
///21003
@property(nonatomic,copy)NSString *var_apple_server_status;
//是否有试用
@property(nonatomic,copy)NSString *var_is_trial_period;
///是否自动续订 1续订  0不续订
@property(nonatomic,copy)NSString *var_auto_renew_status;
@property(nonatomic,copy)NSString *var_tbu;
@end

NS_ASSUME_NONNULL_END
