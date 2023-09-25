

#define SRPrimaryStageLog(format,...)  [SRPeriodLogManager logWithFunction:__FUNCTION__ lineNumber:__LINE__ formatString:[NSString stringWithFormat:format, ##__VA_ARGS__]]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SRPeriodLogManager : NSObject

+ (void)setLogEnable:(BOOL)enable;

+ (BOOL)getLogEnable;

+ (NSString *)version;

+ (void)logWithFunction:(const char *)function lineNumber:(int)lineNumber formatString:(NSString *)formatString;

@end
