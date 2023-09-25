//
//  HTPointRequest.m
//  Movie
//
//  Created by wmz on 2023/4/25.
//

#import "HTPointRequest.h"
#import "LKFPrivateFunction.h"
#import "HDDevice.h"
#import "YYModel.h"
#import "PostCommon_Enum.h"

@implementation HTPointRequest

static dispatch_once_t onceToken;
static HTPointRequest *instance = nil;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        instance = [[HTPointRequest alloc] initWithBaseURL:[NSURL URLWithString:[HTPointRequest ht_baseURLStr]]];
    });
    return instance;
}

+ (void)ht_changeClient {
    onceToken = 0;
    instance = nil;
}

+ (NSString *)ht_baseURLStr {
    NSString *var_Base = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_dp"];
    if  (!var_Base || var_Base.length <= 0) {
        var_Base = STATIC_NETWORD;
    }
    return var_Base;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) return nil;
    self.requestSerializer.timeoutInterval = 10.0f;
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.requestSerializer setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"application/x-www-form-urlencoded;charset=utf-8"] forHTTPHeaderField:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Content-Type"]];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"application/json"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/plain"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/javascript"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/json"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/html"], nil];
    return self;
}

- (void)ht_point:(NSString*)name params:(nullable NSDictionary *)params{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:params];
    mdic[[LKFPrivateFunction htMethodStringToInt:@"pointname"]] = name;
    NSLog(@"🐴%@",[mdic yy_modelToJSONString]);
    [self GET:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/data/"] parameters:[self ht_getCommonInfo:mdic] headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
}

- (NSMutableDictionary *)ht_getCommonInfo:(NSDictionary *)params{
    NSMutableDictionary *var_mdic = [NSMutableDictionary dictionaryWithDictionary:params];
    HDDevice *device = [[HDDevice alloc] init];
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat var_scale_screen = [UIScreen mainScreen].scale;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_id"]] = STATIC_AppId;
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"apns_id"]] = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_deviceToken"]?:@"";
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"reg_id"]] = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_fcmToken"]?:@"";;
//    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"vp"]] = @([HTManage.sharedInstance ht_checkSub]).stringValue;//测试-待处理待调试
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"simcard"]] = [self lgjeropj_isSIMInstalled]?@"1":@"0";
    if ([device.identifier hasPrefix:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"00000000-0000"]]) {
        var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"idfa"]] = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"idfa"]] = device.identifier;
    }
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"brand"]] = UIDevice.currentDevice.model ?: @"";
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"xaid"]] = [[[UIDevice currentDevice] identifierForVendor] UUIDString] ?: @"";
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"ver"]] = [infoDictionary objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"CFBundleShortVersionString"]];
    NSString *string = [[[NSUserDefaults standardUserDefaults] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"AppleLanguages"]] objectAtIndex:0];
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"cl"]] = string ?: @"";
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"model"]] = device.modelName;
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"os_ver"]] = device.systemVersion;
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"tmzone"]] = [self lgjeropj_destinationTimeZone];
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"uptime"]] = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"prodid"]] = @2;
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"display"]] = [NSString stringWithFormat:@"%.0fx%.0f",size_screen.width * var_scale_screen, size_screen.height * var_scale_screen];
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"musiccountry"]] = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_regionStr"] ?: @"";
    NSDictionary *var_netDict = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSString *netKey = [[var_netDict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"__SCOPED__"]] allKeys] componentsJoinedByString:@","];
    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data"]] = netKey ?: @"0";
    var_mdic[[LKFPrivateFunction htMethodStringToInt:@"install_len"]] = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_installtime"]?:[NSString stringWithFormat:@"%.0f",NSDate.date.timeIntervalSince1970];
    if (!params[[LKFPrivateFunction htMethodStringToInt:@"userid"]]) {
//        var_mdic[[LKFPrivateFunction htMethodStringToInt:@"userid"]] = HTManage.sharedInstance.model2.var_uid?:@"0";//测试-待处理待调试
    }
//    var_mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"login"]] = HTManage.sharedInstance.model2.var_uid?@"1":@"0";//测试-待处理待调试
    return var_mdic;
}

- (BOOL)lgjeropj_isSIMInstalled {
    int var_simNum = [self lgjeropj_getSimCardNumInPhone];
    if (var_simNum > 0) {
        return YES;
    }
    return NO;
}
// 判断手机中sim卡数量
- (int)lgjeropj_getSimCardNumInPhone {
     CTTelephonyNetworkInfo *var_networkInfo = [[CTTelephonyNetworkInfo alloc] init];
     if (@available(iOS 12.0, *)) {
          NSDictionary *var_ctDict = var_networkInfo.serviceSubscriberCellularProviders;
          if ([var_ctDict allKeys].count > 1) {
               NSArray *var_keys = [var_ctDict allKeys];
               CTCarrier *car1 = [var_ctDict objectForKey:[var_keys firstObject]];
               CTCarrier *car2 = [var_ctDict objectForKey:[var_keys lastObject]];
               if (car1.mobileCountryCode.length && car2.mobileCountryCode.length) {
                    return 2;
               } else if (!car1.mobileCountryCode.length && !car2.mobileCountryCode.length) {
                    return 0;
               } else {
                    return 1;
               }
          } else if ([var_ctDict allKeys].count == 1) {
               NSArray *var_keys = [var_ctDict allKeys];
               CTCarrier *var_carrier1 = [var_ctDict objectForKey:[var_keys firstObject]];
               if (var_carrier1.mobileCountryCode.length) {
                    return 1;
               } else {
                    return 0;
               }
          } else {
               return 0;
          }
     }else {
          CTCarrier *var_carrier = [var_networkInfo subscriberCellularProvider];
          NSString *var_carrieName = var_carrier.mobileCountryCode;
          if (var_carrieName.length) {
               return 1;
          } else {
               return 0;
          }
     }
}

- (NSString *)lgjeropj_destinationTimeZone {
    NSTimeZone* var_destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger var_sourceGMTOffset = [var_destinationTimeZone secondsFromGMTForDate:[NSDate date]];
    NSString * var_sourceGMT = [NSString stringWithFormat:@"%ld",var_sourceGMTOffset/3600];
    return  var_sourceGMT;
}

- (NSString*)ht_getNetworkState {
   NSDictionary *var_netDict0 = CFBridgingRelease(CFNetworkCopySystemProxySettings());
    NSArray *var_netKeys0 = [var_netDict0[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"__SCOPED__"]] allKeys];
   NSString *data = [var_netKeys0 componentsJoinedByString:@","];
   return data;
}

@end
