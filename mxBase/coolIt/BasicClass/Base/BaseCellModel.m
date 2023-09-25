//
//  BaseCellModel.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "BaseCellModel.h"

@implementation BaseCellModel
+ (BaseCellModel*)ht_nomal:(NSString*)var_className{
    BaseCellModel *model = [[BaseCellModel alloc] init];
    model.var_className = var_className;
    return model;
}

- (NSInteger)var_pageNum{
    if (!_var_pageNum) {
        _var_pageNum = 1;
    }
    return _var_pageNum;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end
