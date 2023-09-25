//
//  SessionTModel.h
//  Movie
//
//  Created by wmz on 2023/5/14.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"

@class MovieModel;
NS_ASSUME_NONNULL_BEGIN

@interface SessionTModel : HTBaseModel
@property (nonatomic,copy)  NSArray *var_eps_list;
@property (nonatomic,copy) NSString *var_id;
@property (nonatomic,copy) NSString *var_title;
@property (nonatomic,assign) BOOL var_select;
@property (nonatomic,assign) BOOL var_tempSelect;
@end

NS_ASSUME_NONNULL_END
