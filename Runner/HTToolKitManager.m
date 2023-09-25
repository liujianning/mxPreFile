//
//  HTToolKitManager.m
//  Ziven
//
//  Created by 李雪健 on 2023/5/29.
//

#import "HTToolKitManager.h"
#import "HTPointRequest.h"

@implementation HTToolKitManager

+ (HTToolKitManager *)shared
{
    static HTToolKitManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTToolKitManager alloc] init];
    });
    return manager;
}

- (void)lgjeropj_save_strip_product:(NSDictionary *)dic
{
    if (dic == nil || dic.count == 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"udf_strip_product_data"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 埋点
    NSInteger var_k12 = [dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k12"]] integerValue];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@(1) forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
    [params setValue:@(var_k12 == 1 ? 1 : 2) forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
    [[HTPointRequest sharedInstance] ht_point:[LKFPrivateFunction htMethodStringToInt:@"tool_switch"] params:params];
}

- (NSDictionary *)lgjeropj_strip_product
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_strip_product_data"];
}

- (NSDictionary *)lgjeropj_server_products
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data2"]];
}

- (NSArray *)lgjeropj_hidden_products
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"h1"]];
}

- (NSDictionary *)lgjeropj_strip_p1
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"p1"]];
}

- (NSDictionary *)lgjeropj_strip_p2
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"p2"]];
}

- (NSArray *)lgjeropj_strip_k3
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k3"]];
}

- (BOOL)lgjeropj_strip_k12
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    NSInteger var_k12 = [dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k12"]] integerValue];
    return [[self lgjeropj_airplay] count] > 0 && var_k12 > 0;
}

- (NSInteger)lgjeropj_strip_k13
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_strip_product];
    return [dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"k13"]] integerValue];
}

- (void)lgjeropj_save_airplay:(NSDictionary *)dic
{
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"udf_airplay"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)lgjeropj_airplay
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_airplay"];
}

- (BOOL)lgjeropj_installed
{
    NSDictionary *dic = [[HTToolKitManager shared] lgjeropj_airplay];
    if (dic.count == 0) {
        return NO;
    }
    NSString *var_scheme = [NSString stringWithFormat:@"%@%@", dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"scheme"]], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"://"]];
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:var_scheme]];
}

@end
