//
//  BaseSectionModel.h
//  Movie
//
//  Created by wmz on 2023/5/14.
//

#import <Foundation/Foundation.h>
#import "HTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseSectionModel : HTBaseModel

@property (nonatomic, copy) NSString *tag;
@property (nonatomic, strong) NSMutableArray *var_rows;

@end

NS_ASSUME_NONNULL_END
