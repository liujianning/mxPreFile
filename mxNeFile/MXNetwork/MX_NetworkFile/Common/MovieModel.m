//
//  MovieModel.m
//  Movie
//
//  Created by wmz on 2023/3/3.
//

#import "MovieModel.h"
//#import "YYModel.h"
//#include <objc/objc.h>

@implementation MovieModel

- (instancetype)init{
    if (self = [super init]) {
        self.var_subtitleShow = YES;
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    NSDictionary *params = [self modelCustomPropertyMapper];
    __block NSString *var_list = @"var_ssn_list";
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:var_list]) {
            var_list = key;
            *stop = YES;
        }
    }];
    return @{var_list : [SessionTModel class]};
}

- (NSArray *)var_ssn_list{
    if (!_var_ssn_list) {
        _var_ssn_list = @[];
    }
    return _var_ssn_list;
}

- (NSMutableDictionary *)var_rctInfo{
    if (!_var_rctInfo) {
        _var_rctInfo = [[NSMutableDictionary alloc] init];
    }
    return _var_rctInfo;
}

- (NSMutableArray *)var_languageDatasource{
    if (!_var_languageDatasource) {
        _var_languageDatasource = [[NSMutableArray alloc] init];
    }
    return _var_languageDatasource;
}

@end


