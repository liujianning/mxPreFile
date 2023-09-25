

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Masonry.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ((NSInteger)(([[UIScreen mainScreen] currentMode].size.height/[[UIScreen mainScreen] currentMode].size.width)*100) == 216) : NO)

#define SRPrimaryStage_Image(file)                 [SRUtilities imageNamed:file]

#define UIColorFromHex(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SRIPhoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})

#define SRNavigationStatusBar (SRIPhoneX ? 44 : 20)

@interface SRUtilities : NSObject

+ (NSString *)convertTimeSecond:(NSInteger)timeSecond;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageNamed:(NSString *)name;

@end

