//
//  LKFPrivateFunction.h
//  Movie
//
//  Created by wmz on 2023/5/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKFPrivateFunction : NSObject

// 埋点转数字
+ (NSString *)htMethodStringToInt:(NSString *)string;
// Ascii转字符串
+ (NSString *)htMethodAsciiToStringButNotMulti:(id)object;
// 图标数字
+ (NSURL *)htMethodImageUrlFromNumber:(NSInteger)number;
+ (NSString *)htMethodImageStringFromNumber:(NSInteger)var_Number;

// 判断电影开关是否打开
+ (BOOL)lgjeropj_judgeMovieSwitchStatus;
+ (BOOL)lgjeropj_judgeMovieSwitchStatus7;
+ (BOOL)lgjeropj_saveSearchStatus:(NSString *)string;
+ (void)lgjeropj_verifyInviteCode:(NSString *)var_codeStr;

+ (BOOL)lgjeropj_isEmpty:(NSString *)string;
+ (BOOL)lgjeropj_isNotEmpty:(NSString *)string;
+ (BOOL)lgjeropj_isNotEmptyArray:(NSArray *)array;
+ (NSString *)lgjeropj_stringFillEmpty:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
