//
//  BaseSectionModel.m
//  Movie
//
//  Created by wmz on 2023/5/14.
//

#import "BaseSectionModel.h"

@implementation BaseSectionModel

- (NSMutableArray *)var_rows {
    
    if (!_var_rows) {
        _var_rows = [[NSMutableArray alloc] init];
    }
    return _var_rows;
}

@end
