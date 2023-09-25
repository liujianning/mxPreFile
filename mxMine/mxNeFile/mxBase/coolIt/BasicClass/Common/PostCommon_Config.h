//
//  HTCommon_Config.h
//  HTDelivery
//
//  Created by wmz on 2020/6/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#ifndef HTCommon_Config_h
#define HTCommon_Config_h

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ViewWidth  [[UIScreen mainScreen] bounds].size.width
#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define StatusBarHeight                     (IS_IPHONE_X_orMore ? 44.f : 20.f)
#define LR_StatusBarAndNavigationBarHeight  (StatusBarHeight +  44.f)
#define ViewHeight [[UIScreen mainScreen] bounds].size.height - LR_TabbarSafeBottomMargin
#define LR_TabbarSafeBottomMargin           (IS_IPHONE_X_orMore ? 34.f : (IS_IPAD ? 15.f : 0.f))

#define IS_IPHONE_X_orMore ({\
    BOOL isxScreen = NO; \
    if (@available(iOS 11.0, *)) { \
        if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0) {\
            isxScreen = YES; \
        } \
    } \
    isxScreen; \
})
#define kWidthScale(a)                  [UIScreen mainScreen].bounds.size.width/375.0*(a)
#define k_IPHONE_8 ([UIScreen mainScreen].bounds.size.width <= 375 && !IS_IPHONE_X_orMore)

#define HT_IPAD (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
#define HTHeight [UIScreen mainScreen].bounds.size.height
#define HTWidth  [UIScreen mainScreen].bounds.size.width
#define HTFixWidth  ([[NSUserDefaults standardUserDefaults] doubleForKey:@"udf_screen_width"])
#define HTNavigationStatusBar (HTIsIphoneX ? 44 : 20)
#define HTNavigationBar (HTNavigationStatusBar + 44)
#define HTNumA(with)   (with)
#define HTNumB(with)   ((with) * (HT_IPAD ? (HTFixWidth / 768) : (HTFixWidth / 375.0)))
#define HTNum(with)   ((with) * (kWidthCoefficientTo6S))
#define kWidthCoefficientTo6S (HT_IPAD ? (HTWidth / 768) : (HTWidth / 375.0))
#define HTBottomSafeHeight (CGFloat)(HTIsIphoneX?(34.0):(0))
#define LocalString(string,comment) [[HTMutilangManager sharedInstance] lgjeropj_stringWithKid:string]
#define LocalInt(index) [[HTMutilangManager sharedInstance] lgjeropj_stringWithKid:@index]

#define HTIsIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})

/// window
#define  HTWindow \
({\
UIWindow *window = nil; \
for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) { \
    if (windowScene.activationState == UISceneActivationStateForegroundActive) \
    { \
        for (UIWindow *currentWindow in windowScene.windows)\
        { \
            if (currentWindow.isKeyWindow)\
            { \
                window = currentWindow; \
                break; \
            }\
        }\
    }\
}\
if (!window) {  \
    window =  UIApplication.sharedApplication.delegate.window; \
}\
(window); \
})\

#define SandBox_VerifyURL @"https://sandbox.itunes.apple.com/verifyReceipt"
#define Produce_VerifyURL  @"https://buy.itunes.apple.com/verifyReceipt"

#endif /* HTCommon_Config_h */
