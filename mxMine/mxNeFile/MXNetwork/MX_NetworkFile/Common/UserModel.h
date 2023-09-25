//
//  UserModel.h
//  Movie
//
//  Created by wmz on 2023/3/1.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : HTBaseModel
@property (nonatomic,copy) NSString *var_phone;
@property (nonatomic,copy) NSString *var_user_face;
@property (nonatomic,assign) int var_user_gender;
@property (nonatomic,copy) NSString *var_user_birth;
@property (nonatomic,copy) NSString *var_email;
@property (nonatomic,copy) NSString *var_user_issync2;
@property (nonatomic,copy) NSString *var_user_name;
@property (nonatomic,copy) NSString *var_msync;

@property (nonatomic,copy) NSString *var_app_id;
@property (nonatomic,copy) NSString *var_uid;
@property (nonatomic,copy) NSString *var_master;
@property (nonatomic,copy) NSString *var_fav_plid;
@property (nonatomic,copy) NSString *var_s1;
@property (nonatomic,copy) NSString *var_val;
@property (nonatomic,copy) NSString *var_fid;
@property (nonatomic,copy) NSString *var_pid;
@property (nonatomic,copy) NSString *var_vp;
@end

NS_ASSUME_NONNULL_END
