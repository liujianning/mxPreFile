//
//  SessionTModel.m
//  Movie
//
//  Created by wmz on 2023/5/14.
//

#import "SessionTModel.h"
#import "MovieModel.h"

@implementation SessionTModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    NSDictionary *params = [self modelCustomPropertyMapper];
    __block NSString *var_list = @"var_eps_list";
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:var_list]) {
            var_list = key;
            *stop = YES;
        }
    }];
    return @{var_list : [MovieModel class]};
}

- (NSArray *)var_eps_list{
    if (!_var_eps_list) {
        _var_eps_list = @[];
    }
    return _var_eps_list;
}
@end
