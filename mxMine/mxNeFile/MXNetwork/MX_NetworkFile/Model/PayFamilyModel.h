//
//  PayFamilyModel.h
//  Klashfly
//
//  Created by 李雪健 on 2023/5/30.
//

#import "HTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayFamilyModel : HTBaseModel

@property (nonatomic, copy) NSString *var_auto_renew_status;
@property (nonatomic, copy) NSString *var_fid;
@property (nonatomic, copy) NSString *var_is_in_intro_offer_period;
@property (nonatomic, copy) NSString *var_is_trial_period;
@property (nonatomic, copy) NSString *var_k6;
@property (nonatomic, copy) NSString *var_k7;
@property (nonatomic, copy) NSString *var_k5;
@property (nonatomic, copy) NSString *var_master;
@property (nonatomic, copy) NSString *var_pid;
@property (nonatomic, copy) NSString *var_val;

@end

NS_ASSUME_NONNULL_END
