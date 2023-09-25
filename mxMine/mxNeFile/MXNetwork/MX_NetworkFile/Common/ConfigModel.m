//
//  ConfigMdoel.m
//  Movie
//
//  Created by wmz on 2023/3/4.
//

#import "ConfigModel.h"
#import "HTBaseModel.h"
@implementation ConfigModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {

    return @{@"var_applovin" : [ApplovinModel class]};
}

@end
