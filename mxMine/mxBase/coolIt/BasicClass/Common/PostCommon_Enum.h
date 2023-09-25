//
//  PostCommon_Enum.h
//  PostDelivery
//
//  Created by wmz on 2020/6/18.
//  Copyright © 2020 wmz. All rights reserved.
//

#ifndef PostCommon_Enum_h
#define PostCommon_Enum_h
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

static NSString *STATIC_GradientKey = @"STATIC_GradientKey";

typedef void (^BLOCK_EventViewBlock)(id _Nullable data);
typedef void (^BLOCK_CustomViewBlock)(UIView *view);
typedef void (^BLOCK_VoidBlock)(void);


typedef NS_ENUM(NSUInteger, ENUM_PlayType) {
    ///电影
    ENUM_MovieType = 0,
    ///电视剧
    ENUM_SeriesType = 1,
};

static NSString * _Nullable const STATIC_Terms = @"https://www.apple.com/legal/internet-services/itunes/dev/stdeula/";

/*
 测试 key
 */
static NSString * _Nullable const STATIC_Privacypolicy = @"https://sites.google.com/view/qosrave/privacypolicy";
static NSString * _Nullable const STATIC_AppId =  @"100";//271
static NSString * _Nullable const STATIC_AppleId =  @"6446979826";//
static NSString * _Nullable const STATIC_FBID =  @"1005459233456032";//
static NSString * _Nullable const STATIC_NETWORD = @"http://54.187.6.80";//
static NSString * _Nullable const STATIC_KOCHAVA =  @"koklashfly-271-8qo3i62";
static NSString * _Nullable const STATIC_Free =  @"free";
static NSString * _Nullable const STATIC_MONTH =  @"month";
static NSString * _Nullable const STATIC_YEAR =  @"year";
static NSString * _Nullable const STATIC_WEEK =  @"week";
static NSString * _Nullable const STATIC_FAMILY =  @"family";
static NSString * _Nullable const STATIC_PAY =  @"e7486eea6edb43309cad765b4d0eaa92";

NS_ASSUME_NONNULL_END

#endif /* PostCommon_Enum_h */

