//
//  ApplovinModel.h
//  Movie
//
//  Created by wmz on 2023/5/15.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ApplovinModel : HTBaseModel
@property (nonatomic,copy) NSString *var_account;
@property (nonatomic,copy) NSString *var_start;
@property (nonatomic,copy) NSString *var_inter;
@property (nonatomic,copy) NSString *var_reward;
@property (nonatomic,copy) NSString *var_mrec;
@property (nonatomic,copy) NSString *var_banner;
@end

NS_ASSUME_NONNULL_END
