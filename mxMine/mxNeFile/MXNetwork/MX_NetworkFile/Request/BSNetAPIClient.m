#import "BSNetAPIClient.h"
#import <CommonCrypto/CommonDigest.h>
#import "LKFPrivateFunction.h"
#import <CoreTelephony/CoreTelephonyDefines.h>
#import "HDDevice.h"
#import "HTMutilangManager.h"
#import "PostCommon_Enum.h"
#import "PostCommon_Config.h"
@interface BSNetAPIClient()
@property (nonatomic, copy)  NSDictionary *errorInfo;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end
@implementation BSNetAPIClient

static dispatch_once_t onceToken;
static BSNetAPIClient *instance = nil;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        instance = [[BSNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[BSNetAPIClient ht_baseURLStr]]];
    });
    return instance;
}

+ (void)ht_changeClient {
    onceToken = 0;
    instance = nil;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) return nil;
    self.requestSerializer.timeoutInterval = 10.0f;
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"application/json"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/plain"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/javascript"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/json"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"text/html"], nil];
    return self;
}

- (void)ht_requestWithPath:(nullable NSString *)aPath andParams:(nullable NSDictionary *)params andViewController:(nullable UIViewController *)vc andStatus:(BOOL)needStatus andBlock:(nullable BLOCK_PostNetWorkBockBlock)block {
    
    [self ht_requestWithPath:aPath andParams:params andViewController:vc andType:ENUM_Post andStatus:needStatus andBlock:block];
}

- (void)ht_requestWithPath:(nullable NSString *)aPath andParams:(nullable NSDictionary *)params andViewController:(nullable UIViewController*)vc andBlock:(nullable BLOCK_PostNetWorkBockBlock)block {
    
    [self ht_requestWithPath:aPath andParams:params andViewController:vc andStatus:NO andBlock:block];
}

- (void)ht_requestWithPath:(nullable NSString *)aPath andParams:(nullable NSDictionary *)params andViewController:(nullable UIViewController*)vc andType:(ENUM_NetworkMethodType)type andStatus:(BOOL)needStatus andBlock:(nullable BLOCK_PostNetWorkBockBlock)block {
    
    self.requestSerializer.timeoutInterval = 15.0f;
    if (![aPath isKindOfClass:NSString.class] || aPath.length <= 0) return;
    aPath = [aPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableDictionary *headInfo = [[NSMutableDictionary alloc] init];
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.requestSerializer setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"application/x-www-form-urlencoded;charset=utf-8"] forHTTPHeaderField:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Content-Type"]];
    switch (type) {
        case ENUM_Get: {
            [self GET:aPath parameters:[self ht_getCommonInfo:params] headers:headInfo progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self ht_handleResponse:(NSHTTPURLResponse *)task.response andResponseJSON:responseObject andUploadFile:NO andViewController:vc andStatus:needStatus andBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self ht_handleResponse:(NSHTTPURLResponse *)task.response andResponseJSON:error andUploadFile:NO andViewController:vc andStatus:needStatus andBlock:block];
            }];
        }
        break;
        case ENUM_Post: {
            NSMutableDictionary *info = [self ht_getCommonInfo:params];
            [self POST:aPath parameters:info headers:headInfo progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self ht_handleResponse:(NSHTTPURLResponse *)task.response andResponseJSON:responseObject andUploadFile:NO andViewController:vc andStatus:needStatus andBlock:block];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self ht_handleResponse:(NSHTTPURLResponse *)task.response andResponseJSON:error andUploadFile:NO andViewController:vc andStatus:needStatus andBlock:block];
            }];
        }
        break;
    }
}

- (NSMutableDictionary *)ht_getCommonInfo:(NSDictionary *)params {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *var_api = [self lgjeropj_apiParams:params];
    NSMutableDictionary *var_sig = [self lgjeropj_apiSignatureParameters:params];
    [dict addEntriesFromDictionary:var_api];
    [dict addEntriesFromDictionary:var_sig];
    [dict addEntriesFromDictionary:params];
    return dict;
}

- (NSMutableDictionary *)lgjeropj_apiParams:(NSDictionary *)params {
    
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
    HDDevice *device = [[HDDevice alloc] init];
    CGRect rect_screen = [[UIScreen mainScreen] bounds];
    CGSize size_screen = rect_screen.size;
    CGFloat var_scale_screen = [UIScreen mainScreen].scale;
    if (!params[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"uid"]]) {
//        mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"uid"]] = HTManage.sharedInstance.model2.var_uid?:@"0";//测试-待处理待调试
    }
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"apns_id"]] = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_deviceToken"]?:@"";
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_id"]] = STATIC_AppId;
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"app_ver"]] = device.version;
    
    NSArray *var_array = [[NSUserDefaults standardUserDefaults] objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"AppleLanguages"]];
    NSString *var_string = [var_array objectAtIndex:0];
    NSArray *var_langRegionArray = [var_string componentsSeparatedByString:@"-"];
    NSString *var_lang = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"en"];
    NSString *var_country = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"US"];
    
    if (var_langRegionArray.count >= 3) {
        NSMutableArray *var_lastArray = [NSMutableArray arrayWithArray:var_langRegionArray];
        [var_lastArray removeLastObject];
        var_lang = [var_lastArray componentsJoinedByString:@"_"];
        var_country = var_langRegionArray.lastObject;
    } else if (var_langRegionArray.count == 2) {
        var_country = [[NSLocale currentLocale] countryCode];
        if ([var_country isEqualToString:var_langRegionArray.lastObject]) {
            var_lang = var_langRegionArray.firstObject;
        } else {
            var_lang = [var_langRegionArray componentsJoinedByString:@"_"];
        }
    } else if (var_langRegionArray.count == 1) {
        var_lang = var_langRegionArray.firstObject;
        var_country = [[NSLocale currentLocale] countryCode];
    }
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"lang"]] = var_lang;
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"brand"]] = UIDevice.currentDevice.model ?: @"";
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"country"]] = var_country ?: @"";
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"device"]] = UIDevice.currentDevice.systemName;
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"deviceNo"]] = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if ([device.identifier hasPrefix:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"00000000-0000"]]) {
        mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"idfa"]] = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else {
        mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"idfa"]] = device.identifier;
    }
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"imsi"]] = [device getIMSIInfo];
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"installTime"]] = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_installtime"]?:[NSString stringWithFormat:@"%.0f",NSDate.date.timeIntervalSince1970];
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"model"]] = device.modelName;
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"os_ver"]] = device.systemVersion;
    NSInteger var_coverDefinition = [[NSUserDefaults standardUserDefaults] integerForKey:@"udf_coverDefinition"];
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"r1"]] = @(var_coverDefinition ?: 0);
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"reg_id"]] = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_fcmToken"]?:@"";
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"resolution"]] = [NSString stringWithFormat:@"%.0fx%.0f",size_screen.width * var_scale_screen, size_screen.height * var_scale_screen];
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"simcard"]] = [self lgjeropj_isSIMInstalled]?@"1":@"0";
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"timezone"]] = [NSString stringWithFormat:@"%zd", [NSTimeZone localTimeZone].secondsFromGMT / 3600];
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"token"]] = @"1";
//    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"vp"]] = @([HTManage.sharedInstance ht_checkSub]).stringValue;//测试-待处理待调试
    mdic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"version"]] = @"6.0";
    return mdic;
}

- (BOOL)lgjeropj_isSIMInstalled {
    int simNum = [self lgjeropj_getSimCardNumInPhone];
    if (simNum > 0) {
        return YES;
    }
    return NO;
}
// 判断手机中sim卡数量
- (int)lgjeropj_getSimCardNumInPhone {
     CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
     if (@available(iOS 12.0, *)) {
          NSDictionary *ctDict = networkInfo.serviceSubscriberCellularProviders;
          if ([ctDict allKeys].count > 1) {
               NSArray *keys = [ctDict allKeys];
               CTCarrier *carrier1 = [ctDict objectForKey:[keys firstObject]];
               CTCarrier *carrier2 = [ctDict objectForKey:[keys lastObject]];
               if (carrier1.mobileCountryCode.length && carrier2.mobileCountryCode.length) {
                    return 2;
               } else if (!carrier1.mobileCountryCode.length && !carrier2.mobileCountryCode.length) {
                    return 0;
               } else {
                    return 1;
               }
          } else if ([ctDict allKeys].count == 1) {
               NSArray *keys = [ctDict allKeys];
               CTCarrier *carrier1 = [ctDict objectForKey:[keys firstObject]];
               if (carrier1.mobileCountryCode.length) {
                    return 1;
               } else {
                    return 0;
               }
          } else {
               return 0;
          }
     }else {
          CTCarrier *carrier = [networkInfo subscriberCellularProvider];
          NSString *carrier_name = carrier.mobileCountryCode;
          if (carrier_name.length) {
               return 1;
          } else {
               return 0;
          }
     }
}

- (NSMutableDictionary *)lgjeropj_apiSignatureParameters:(NSDictionary *)params {
    NSMutableDictionary *var_dict = [NSMutableDictionary dictionary];
    
    NSString *var_timestampStr = @"";
    NSString *var_unixtimeStr = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"unixtime"];
    NSArray *keysArr = [params allKeys];
    if ([keysArr containsObject:var_unixtimeStr]) {
        var_timestampStr = params[var_unixtimeStr];
    } else {
        var_timestampStr = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
    }
    [var_dict setObject:var_timestampStr forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"unixtime1"]];
    
    NSString *var_saltStr = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"drxsk93xd9ut"];
    NSDictionary *var_infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *var_bundleIDStr = [var_infoDictionary objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"CFBundleIdentifier"]];
    NSString *var_deviceStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSString *var_tmepmdStr = [NSString stringWithFormat:@"%@%@%@%@%@",var_deviceStr,@"/",var_timestampStr,@"/",var_bundleIDStr];
    NSString *var_signmdStr = [self ht_getMd5_32Bit_String:var_tmepmdStr];
    
    NSString *var_signtmepStr = [NSString stringWithFormat:@"%@%@%@",var_signmdStr,@"/",var_saltStr];
    NSString *var_signatureStr = [self ht_getMd5_32Bit_String:var_signtmepStr];
    [var_dict setObject:var_signatureStr forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"sig2"]];
    
    return var_dict;
}

- (NSString *)ht_getMd5_32Bit_String:(NSString *)srcString {
    const char *var_cStr = [srcString UTF8String];
    unsigned char var_digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( var_cStr, (CC_LONG)strlen(var_cStr), var_digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", var_digest[i]];
    }
    return result;
}

- (void)ht_downloadWithUrl:(NSString*)url andBlock:(nullable BLOCK_PostNetWorkBockBlock)block{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        if ([self ht_isFileExist:[response suggestedFilename]]) {
        }
        NSURL *var_documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [var_documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        return url;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (block) {
            if (error) {
                block(nil,NO);
            } else {
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"url"]] = url;
                NSString *string = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"file://"];
                dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"path"]] = [LKFPrivateFunction lgjeropj_stringFillEmpty:[filePath.absoluteString stringByReplacingOccurrencesOfString:string withString:@""]];
                block(dict,YES);
            }
        }
    }];
    [downloadTask resume];
}

-(BOOL)ht_isFileExist:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

#pragma mark - responseJSON Error
-(void)ht_handleResponse:(NSHTTPURLResponse*)response andResponseJSON:(id)responseJSON andUploadFile:(BOOL)uploadFile andViewController:(nullable UIViewController*)vc andStatus:(BOOL)needStatus andBlock:(nullable BLOCK_PostNetWorkBockBlock)block{
    NSString *errorStr = nil;
    NSInteger errorCode = 0;
    if (response.statusCode == 200) {
        if ([responseJSON isKindOfClass:NSDictionary.class]) {
            if (needStatus && block) {
                block(responseJSON,YES);
                return;
            }
            if (responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]]) {
                errorCode = [responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]] intValue];
            }
            if (errorCode == 200) {
                if (block) {
                    if (![responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data"]] isKindOfClass:[NSNull class]]) {
                        if (responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data_2"]]) {
                            block(responseJSON,YES);
                        } else {
                            block(responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data"]],YES);
                        }
                    } else {
                        if (responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]]) {
                            block(responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]],YES);
                        }
                    }
                }
                return;
            } else{
                if (responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]]) {
                    errorStr = responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]] ;
                }
                if (responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]]) {
                    errorCode = [responseJSON[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]] intValue] ;
                }
            }
        } else if ([responseJSON isKindOfClass:NSError.class]) {
            NSError *err = (NSError*)responseJSON;
            errorCode = err.code;
            errorStr = [responseJSON localizedDescription];
        } else {
            errorCode = response.statusCode;
            errorStr = self.errorInfo[@(response.statusCode)];
        }
    } else {
        errorCode = response.statusCode;
        errorStr = self.errorInfo[@(response.statusCode)];
    }
    if (block) {
        block(@{[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"errorCode"]:@(errorCode),[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"errorStr"]:errorStr?:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Unknow Error"]},NO);
    }
}


#pragma mark BaseURL
+ (NSString *)ht_baseURLStr {
    NSString *var_Base = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_api"];
    if  (!var_Base || var_Base.length <= 0) {
        var_Base = STATIC_NETWORD;
    }
    return var_Base;
}

- (NSString *)ht_uuidString{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    NSString *UUID = [[uuid lowercaseString] stringByReplacingOccurrencesOfString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"-"] withString:@""];
    return UUID;
}

- (NSDictionary *)errorInfo{
    if (!_errorInfo) {
        _errorInfo = @{
            @(400):LocalString(@"Bad Request", nil),
            @(401):LocalString(@"Unauthorized", nil),
            @(403):LocalString(@"Forbidden", nil),
            @(404):LocalString(@"Not Found", nil),
            @(405):LocalString(@"Request Method Error", nil),
            @(415):LocalString(@"Unsupported Media Type", nil),
            @(500):LocalString(@"Internal Server Error", nil),
            @(502):LocalString(@"Bad Gateway", nil),
            @(503):LocalString(@"Service Unavailable", nil),
        };
    }
    return _errorInfo;
}

@end
