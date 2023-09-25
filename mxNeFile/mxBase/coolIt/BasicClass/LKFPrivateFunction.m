//
//  LKFPrivateFunction.m
//  Movie
//
//  Created by wmz on 2023/5/15.
//

#import "LKFPrivateFunction.h"

@implementation LKFPrivateFunction

//埋点转数字
+ (NSString *)htMethodStringToInt:(NSString *)string {
    return string;
}
// Ascii转字符串
+ (NSString *)htMethodAsciiToStringButNotMulti:(id)var_Object {
    if ([var_Object isKindOfClass:[NSString class]]) {
        NSString *var_Result = var_Object;
        return var_Result;
    } else if ([var_Object isKindOfClass:[NSArray class]])  {
        NSString *var_Result = [self htMethodStringFromAsciiArray:var_Object];
        return var_Result;
    }
    return @"";
}
// Ascii转字符串
+ (NSString *)htMethodStringFromAsciiArray:(NSArray *)var_CodeArr {
    NSMutableString *var_NormalStr = [NSMutableString string];
    for (NSNumber *var_Code in var_CodeArr) {
        /*
         测试
         */
        int var_CodeInt = var_Code.intValue - 271;
        NSString *var_String = [NSString stringWithFormat:@"%c", var_CodeInt];
        [var_NormalStr appendString:var_String];
    }
    return var_NormalStr;
}
//图标数字
+ (NSURL *)htMethodImageUrlFromNumber:(NSInteger)var_Number {
    NSString *var_Base = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_imageDomain"];
    NSString *var_Scale = [self htMethodAsciiToStringButNotMulti:@"@3x"];
    NSString *var_Suffix = [self htMethodAsciiToStringButNotMulti:@".png"];
    NSString *var_Picture = [NSString stringWithFormat:@"%@%ld%@%@", var_Base, var_Number, var_Scale, var_Suffix];
    return [NSURL URLWithString:var_Picture];
}
//图标数字
+ (NSString *)htMethodImageStringFromNumber:(NSInteger)var_Number {
    NSString *var_Base = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_imageDomain"];
    NSString *var_Scale = [self htMethodAsciiToStringButNotMulti:@"@3x"];
    NSString *var_Suffix = [self htMethodAsciiToStringButNotMulti:@".png"];
    NSString *var_Picture = [NSString stringWithFormat:@"%@%ld%@%@", var_Base, var_Number, var_Scale, var_Suffix];
    return var_Picture;
}
// 判断电影开关是否打开
+ (BOOL)lgjeropj_judgeMovieSwitchStatus {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger var_Mtghjknm = [userDefaults integerForKey:@"udf_mtghjknm"];
    NSInteger var_CoverDefinition = [userDefaults integerForKey:@"udf_coverDefinition"];
    BOOL status = NO;
    if (!var_Mtghjknm || var_Mtghjknm != 100) {
        status = NO;
    } else if (![self lgjeropj_judgeMusicSwitchStatus]) {
        status = NO;
    } else if ([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_movuygiuda"] == 100
        ||([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_movuygiuda"] == 400 && [userDefaults boolForKey:@"udf_msword"])
        ||(var_CoverDefinition == 200 && [userDefaults boolForKey:@"udf_msword"])
        ||(var_CoverDefinition == 400 && [userDefaults boolForKey:@"udf_msword"])) {
        status = YES;
    }
    return status;
}

// 判断音乐开关是否打开
+ (BOOL)lgjeropj_judgeMusicSwitchStatus {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger var_movuygiuda = [userDefaults integerForKey:@"udf_movuygiuda"];
    NSInteger var_coverDefinition = [userDefaults integerForKey:@"udf_coverDefinition"];
    BOOL status = NO;
    if (!var_coverDefinition ||!var_movuygiuda) {
        status = NO;
    } else if (var_coverDefinition == 100
        ||var_coverDefinition == 300
        ||(var_coverDefinition == 200 &&[userDefaults boolForKey:@"udf_msword"])
        ||var_coverDefinition == 400
        ||var_movuygiuda == 400) {
        status = YES;
    }
    
    return status;
}

+ (BOOL)lgjeropj_judgeMovieSwitchStatus7 {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger var_mtghjknm = [userDefaults integerForKey:@"udf_mtghjknm"];
    NSInteger var_coverDefinition = [userDefaults integerForKey:@"udf_coverDefinition"];
    BOOL status = NO;
    if (!var_coverDefinition ||![[NSUserDefaults standardUserDefaults] integerForKey:@"udf_movuygiuda"] ||!var_mtghjknm ||var_mtghjknm != 100) {
        status = NO;
    } else if (([[NSUserDefaults standardUserDefaults] integerForKey:@"udf_movuygiuda"] == 400 &&[userDefaults boolForKey:@"udf_msword"])
        ||(var_coverDefinition == 200 &&[userDefaults boolForKey:@"udf_msword"])
        ||(var_coverDefinition == 400 &&[userDefaults boolForKey:@"udf_msword"])) {
        status = YES;
    }
    return status;
}

// 保存搜索状态
+ (BOOL)lgjeropj_saveSearchStatus:(NSString *)string {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger var_coverDefinition = [userDefaults integerForKey:@"udf_coverDefinition"];
    if ((var_coverDefinition == 200
         || var_coverDefinition == 400
         || [[NSUserDefaults standardUserDefaults] integerForKey:@"udf_movuygiuda"] == 400)
        && ![self lgjeropj_judgeMovieSwitchStatus]
        && [userDefaults stringForKey:@"udf_searchWord"]
        && [userDefaults boolForKey:@"udf_msword"] == NO) {
        if ([string caseInsensitiveCompare:[userDefaults stringForKey:@"udf_searchWord"]] == NSOrderedSame) {
            [userDefaults setBool:YES forKey:@"udf_msword"];
            [userDefaults synchronize];
            [NSUserDefaults.standardUserDefaults setObject:@"udf_white" forKey:@"udf_white"];
            [NSUserDefaults.standardUserDefaults setObject:@"2" forKey:@"udf_op_type"];
            [[HTMutilangManager sharedInstance] lgjeropj_getLangWithNetwork];
            return YES;
        }
        return NO;
    }
    return NO;
}
+ (void)lgjeropj_verifyInviteCode:(NSString *)var_codeStr {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([var_codeStr caseInsensitiveCompare:[userDefaults stringForKey:@"udf_searchWord"]] != NSOrderedSame) {
        NSDictionary *var_dict = @{[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"sig"]:var_codeStr};
        //测试-待处理
//        [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/318/"] andParams:var_dict andViewController:nil andBlock:^(id  _Nullable data, BOOL result) {
//            if (result) {
//                NSString *var_resolution = [NSString stringWithFormat:@"%@",[data objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"resolution"]]];
//                [[NSUserDefaults standardUserDefaults] setInteger:var_resolution.integerValue forKey:@"udf_coverDefinition"];
//                [[NSUserDefaults standardUserDefaults] setInteger:var_resolution.integerValue forKey:@"udf_movuygiuda"];
//                [[NSUserDefaults standardUserDefaults] setInteger:var_resolution.integerValue forKey:@"udf_mtghjknm"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//
//                if ([LKFPrivateFunction lgjeropj_judgeMovieSwitchStatus]) {
//                    [NSUserDefaults.standardUserDefaults setObject:@"udf_white" forKey:@"udf_white"];
//                    [NSUserDefaults.standardUserDefaults setObject:@"2" forKey:@"udf_op_type"];
//                    [[HTMutilangManager sharedInstance] lgjeropj_getLangWithNetwork];
//                }
//            }
//        }];
    }
}

+ (BOOL)lgjeropj_isNotEmpty:(NSString *)string
{
    return string != nil && [string isKindOfClass:NSString.class] && string.length > 0;
}

+ (BOOL)lgjeropj_isEmpty:(NSString *)string
{
    return string == nil || ![string isKindOfClass:NSString.class] || string.length == 0;
}

+ (NSString *)lgjeropj_stringFillEmpty:(NSString *)string
{
    return [self lgjeropj_isNotEmpty:string] ? string : @"";
}

+ (BOOL)lgjeropj_isNotEmptyArray:(NSArray *)array
{
    return array != nil && [array isKindOfClass:[NSArray class]] && [array count] > 0;
}

@end
