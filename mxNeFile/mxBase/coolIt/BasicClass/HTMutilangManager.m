//
//  HTMutilangManager.m
//  Cubohue
//
//  Created by 昊天 on 2022/9/9.
//

#import "HTMutilangManager.h"

@interface HTMutilangManager ()
@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation HTMutilangManager
+ (instancetype)sharedInstance{
    static HTMutilangManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)lgjeropj_getLangWithNetwork {
    //测试-待处理
//    if ([self lgjeropj_judgeIfneedRequestLanguage] && [LKFPrivateFunction lgjeropj_judgeMovieSwitchStatus]) {
//        [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/192/"] andParams:@{} andViewController:nil andBlock:^(id  _Nullable data, BOOL result) {
//            if (result) {
//                NSDictionary *dict = data[@"iOS"];
//                if (dict != nil && dict.count > 0) {
//                    BOOL isDirectory;
//                    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Language"]];
//                    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
//                        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//                    }
//                    path = [self lgjeropj_getLangPathString];
//                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//                    if (jsonData) {
//                        if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]) {
//                            if ([[NSFileManager defaultManager] createFileAtPath:path contents:jsonData attributes:nil]) {
//                                [self lgjeropj_upDataLanguage];
//                            }
//                        } else {
//                            if ([jsonData writeToFile:path atomically:YES]) {
//                                [self lgjeropj_upDataLanguage];
//                            }
//                        }
//                    }
//                }
//            }
//            [(AppDelegate *)[UIApplication sharedApplication].delegate lgjeropj_updateRootWithChange:YES];
//        }];
//    } else {
//        [(AppDelegate *)[UIApplication sharedApplication].delegate lgjeropj_updateRootWithChange:NO];
//    }
}

- (void)lgjeropj_upDataLanguage {
    [self lgjeropj_getLangfileData];
    NSDictionary *dictionary = [[NSBundle mainBundle] infoDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:[dictionary objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"CFBundleShortVersionString"]] forKey:@"udf_budnum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)lgjeropj_judgeIfneedRequestLanguage {
    BOOL result = NO;
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self lgjeropj_getLangPathString] isDirectory:&isDirectory]) {
        NSString *string = [[[NSBundle mainBundle] infoDictionary] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"CFBundleShortVersionString"]];
        NSString *budnumStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_budnum"];
        if (![budnumStr isEqualToString:string]) {
            result = YES;
        }
    } else {
        result = YES;
    }
    return result;
}
- (NSString *)lgjeropj_getLangPathString {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"AppleLanguages"]];
    NSString *string = [array objectAtIndex:0];
    NSRange range = [string rangeOfString:@"-" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        string = [string substringToIndex:range.location];
    } else {
        string = string.length > 1?[string substringToIndex:2]:@"";
    }
    NSString *name = [NSString stringWithFormat:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Language/%@.txt"], string];
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [paths stringByAppendingPathComponent:name];
    return path;
}

- (void)lgjeropj_getLangfileData {
    NSString *pathStr = [self lgjeropj_getLangfilePathString:[self lgjeropj_getLangPathString]];
    NSData *jsonData = nil;
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathStr isDirectory:&isDirectory]) {
        jsonData = [NSData dataWithContentsOfFile:pathStr];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        [self.dictionary removeAllObjects];
        [self.dictionary addEntriesFromDictionary:jsonDict];
    }
}

- (NSString *)lgjeropj_getLangfilePathString:(NSString *)langStr {
    NSString *var_langPathStr = langStr;
    NSString *var_lastLangStr = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_lastLangPath"];
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:var_langPathStr isDirectory:&isDirectory]) {
        [[NSUserDefaults standardUserDefaults] setObject:var_langPathStr forKey:@"udf_lastLangPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else if ([[NSFileManager defaultManager] fileExistsAtPath:var_lastLangStr isDirectory:&isDirectory]) {
        var_langPathStr = var_lastLangStr;
    } else {
        var_langPathStr = nil;
    }
    return var_langPathStr;
}

- (NSString *)lgjeropj_stringWithKid:(id)text {
    NSString *string = @"";
    if ([text isKindOfClass:[NSString class]]) {
        string = text;
    } else {
        string = [NSString stringWithFormat:@"%@%@",[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"string"],text];
    }
    NSString *str = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text"];
    if (self.dictionary.count > 0 && [self.dictionary.allKeys containsObject:string]) {
        str = [self.dictionary objectForKey:string];
    } else if (![string hasPrefix:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"string"]]) {
        str = string;
    }
    return str;
}


- (NSMutableDictionary *)dictionary {
    if (_dictionary == nil) {
        _dictionary = [NSMutableDictionary dictionary];
    }
    return _dictionary;
}
@end
