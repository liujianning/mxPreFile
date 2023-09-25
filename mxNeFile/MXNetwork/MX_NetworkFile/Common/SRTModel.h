//
//  SRTModel.h
//  Movie
//
//  Created by wmz on 2023/3/5.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SRTModel : HTBaseModel
@property (nonatomic,assign) BOOL var_show;
@property (nonatomic,assign) NSInteger var_index;
@property (nonatomic,assign) NSInteger var_began;
@property (nonatomic,assign) NSInteger end;
@property (nonatomic,copy) NSString *var_subtitle;
@end

NS_ASSUME_NONNULL_END
