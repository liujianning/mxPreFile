//
//  HTManage.m
//  Movie
//
//  Created by wmz on 2023/2/13.
//

#import "HTManage.h"
#import "LKFPrivateFunction.h"
#import "BSNetAPIClient.h"
#import "PostCommon_Config.h"
//#import "HTToolKitManager.h"//测试-待处理
//#import "HTWebViewController.h"//测试-待处理

@implementation HTManage

+ (instancetype)sharedInstance{
    static HTManage *instance = nil;
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance ;
}

- (void)setModel4:(ConfigModel *)var_configModel{
    if (var_configModel) {
        [NSUserDefaults.standardUserDefaults setObject:[var_configModel yy_modelToJSONString]forKey:@"udf_config"];
    } else {
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"udf_config"];
    }
}

- (ConfigModel *)model4{
    NSString *str = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_config"];
    ConfigModel *var_config = [[ConfigModel alloc] init];
    if (str) {
        var_config = [ConfigModel yy_modelWithJSON:str];
    }
    return var_config;
}

- (void)setModel3:(ShareModel *)var_model3 {
    if (var_model3) {
        [NSUserDefaults.standardUserDefaults setObject:[var_model3 yy_modelToJSONString]forKey:@"udf_share"];
    } else {
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"udf_share"];
    }
}

- (ShareModel *)model3 {
    NSString *str = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_share"];
    ShareModel *var_config = [[ShareModel alloc] init];
    if (str) {
        var_config = [ShareModel yy_modelWithJSON:str];
    }
    return var_config;
}

- (void)ht_getAllConfig{
    [self ht_getConfig:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/105/"] andParams:@{} andBlock:^(id  _Nullable data) {
        if ([data isKindOfClass:NSDictionary.class]) {
            if ([data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"val"]] isKindOfClass:NSString.class]) {
                NSString *val = data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"val"]];
                if (![LKFPrivateFunction lgjeropj_isNotEmpty:val]) {
                    [NSUserDefaults.standardUserDefaults setObject:val forKey:@"udf_searchPlacer"];
                }
            }
        }
    }];
    
    [self ht_getConfig:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/84/"] andParams:@{} andBlock:^(id  _Nullable data) {
        if (data) {
            //测试-待处理
//            [[HTToolKitManager shared] lgjeropj_save_airplay:data[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"airplay"]]];
//            self.model4 = [ConfigModel yy_modelWithJSON:data];
//            [APP_DELEGATE lgjeropj_initApplovin];
        }
    }];
    
    
    //测试-待处理
//    [self ht_getConfig:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/78/"] andParams:[HTWindowManage ht_requestTakePartInfoParams] andBlock:^(id  _Nullable data) {
//        if (data) {
//            self.model3 = [ShareModel yy_modelWithJSON:data];
//            if ([self.model3 isKindOfClass:ShareModel.class]) {
//                [NSNotificationCenter.defaultCenter postNotificationName:@"NTFCTString_ShareModel" object:nil];
//            }
//        }
//    }];
    
    [self ht_getConfig:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/300/"] andParams:@{} andBlock:^(id  _Nullable data) {
        if (data) {
            //测试-待处理
//            [[HTToolKitManager shared] lgjeropj_save_strip_product:data];
            self.model5 = [SubscribeModel yy_modelWithJSON:data];
        }
    }];
}

- (void)ht_getConfig:(NSString*)key andParams:(NSDictionary *)dict andBlock:(nullable BLOCK_EventViewBlock)block{
    if ([LKFPrivateFunction lgjeropj_isEmpty:key]) {
        return;
    }
    [BSNetAPIClient.sharedInstance ht_requestWithPath:key andParams:dict andViewController:nil andBlock:^(id  _Nullable data, BOOL result) {
        if (result) {
            if (block) {
                block(data);
            }
         } else {
             if (block) {
                 block(nil);
             }
         }
    }];
}

- (void)ht_getUserInfoWithUid:(NSString*)uid andBlock:(BLOCK_UserModelBlock)block{
    [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/115/"] andParams:@{[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"uid"]:[LKFPrivateFunction lgjeropj_stringFillEmpty:uid]} andViewController:nil andBlock:^(id  _Nullable data, BOOL result) {
        if (result) {
            UserModel *var_userModel = [UserModel yy_modelWithJSON:data];
            if (block) {
                block(var_userModel);
            }
        } else {
            if (block) {
                block(nil);
            }
        }
    }];
}

- (void)ht_updateVipWithBlock:(nullable BLOCK_PayModelBlock)block source:(NSString*)source {
    UserModel *model = HTManage.sharedInstance.model2;
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:recepitURL];
    NSString *receipt = [receiptData base64EncodedStringWithOptions:0];
    NSString *pid = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_pid"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"0" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"flag"]];
    [params setValue:[LKFPrivateFunction lgjeropj_stringFillEmpty:pid] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"pid"]];
    [params setObject:(model.var_fid ?: @"0") forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"]];
    [params setValue:[LKFPrivateFunction lgjeropj_stringFillEmpty:receipt] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"receipt"]];
    [BSNetAPIClient.sharedInstance ht_requestWithPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"/326/"] andParams:params andViewController:nil andBlock:^(id  _Nullable data, BOOL result) {
        if (result) {
            PayModel *var_payModel = [PayModel yy_modelWithJSON:data];
            var_payModel.var_local.var_pid = [LKFPrivateFunction lgjeropj_stringFillEmpty:pid];
            model.var_fid = var_payModel.var_family.var_fid;
            model.var_master = var_payModel.var_family.var_master;
            HTManage.sharedInstance.model2 = model;
            
            if ([var_payModel isKindOfClass:PayModel.class]) {
                self.model6 = var_payModel;
            }
            if (var_payModel.var_device.var_f1.integerValue == 1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_RemindAddFamilyMember" object:nil];
            }
            [self ht_checkLogin];
            NSLog(@"🐴订阅页订阅状态 %@", data);
            NSString *status2 = @"3";
            if ([var_payModel.var_server.var_val2 isEqualToString:@"1"]) {
                status2 = var_payModel.var_server.var_auto_renew_status;
            } else {
                if (var_payModel.var_local.var_value == 1) {
                    status2 = var_payModel.var_local.var_auto_renew_status;
                }
            }
            NSString *var_k7 = @"0";
            if ([HTManage.sharedInstance.model6.var_family.var_val integerValue] == 1) {
                var_k7 = HTManage.sharedInstance.model6.var_family.var_k7;
            } else if ([HTManage.sharedInstance.model6.var_server.var_val2 integerValue] == 1) {
                var_k7 = HTManage.sharedInstance.model6.var_server.var_k7;
            } else if (HTManage.sharedInstance.model6.var_local.var_value == 1) {
                var_k7 = HTManage.sharedInstance.model6.var_local.var_k7;
            }
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setValue:source ?: @"4" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]];
            [params setValue:var_k7 forKey:[LKFPrivateFunction htMethodStringToInt:@"pay_time"]];
            [params setValue:@"1" forKey:[LKFPrivateFunction htMethodStringToInt:@"ctype"]];
            if (![[HTManage sharedInstance] ht_checkSub]) {
                [params setValue:@"2" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
                [params setValue:@"2" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status2"]];
                [params setValue:@"2" forKey:[LKFPrivateFunction htMethodStringToInt:@"g_status"]];
                [params setValue:@"2" forKey:[LKFPrivateFunction htMethodStringToInt:@"s_s_status"]];
                [params setValue:@"2" forKey:[LKFPrivateFunction htMethodStringToInt:@"s_f_status"]];
                [params setValue:@"2" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"s_x_status"]];
            } else {
                BOOL var_localVip = HTManage.sharedInstance.model6.var_local.var_value == 1;
                BOOL var_deviceVip = [HTManage.sharedInstance.model6.var_device.var_val integerValue] == 1;
                BOOL var_toolVip = [HTManage.sharedInstance.model6.var_server.var_t1 integerValue] == 2;
                if (var_deviceVip) {
                    [params setValue:HTManage.sharedInstance.model6.var_device.var_pid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type3"]];
                    [params setValue:@"1" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"s_x_status"]];
                } else {
                    [params setValue:@"2" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"s_x_status"]];
                }
                if (HTManage.sharedInstance.model2.var_uid) {
                    [params setValue:HTManage.sharedInstance.model2.var_email forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"mail"]];
                    if ([HTManage.sharedInstance.model6.var_family.var_val integerValue] == 1) {
                        [params setValue:HTManage.sharedInstance.model6.var_family.var_pid forKey:[LKFPrivateFunction htMethodStringToInt:@"type2"]];
                        [params setValue:[HTManage.sharedInstance.model6.var_family.var_auto_renew_status integerValue] == 1 ? @"1" : @"3" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
                        [params setValue:var_toolVip ? @"3" : @"1" forKey:[LKFPrivateFunction htMethodStringToInt:@"s_f_status"]];
                        [params setValue:HTManage.sharedInstance.model6.var_family.var_master forKey:[LKFPrivateFunction htMethodStringToInt:@"s_f_master"]];
                        [params setValue:@"" forKey:[LKFPrivateFunction htMethodStringToInt:@"s_s_status"]];
                        [params setValue:HTManage.sharedInstance.model6.var_family.var_fid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"]];
                    } else if ([HTManage.sharedInstance.model6.var_server.var_val2 integerValue] == 1) {
                        [params setValue:HTManage.sharedInstance.model6.var_server.var_pid forKey:[LKFPrivateFunction htMethodStringToInt:@"type2"]];
                        [params setValue:[HTManage.sharedInstance.model6.var_server.var_auto_renew_status integerValue] == 1 ? @"1" : @"3" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
                        [params setValue:var_toolVip ? @"3" : @"1" forKey:[LKFPrivateFunction htMethodStringToInt:@"s_s_status"]];
                        [params setValue:@"" forKey:[LKFPrivateFunction htMethodStringToInt:@"s_f_master"]];
                        [params setValue:@"" forKey:[LKFPrivateFunction htMethodStringToInt:@"s_f_status"]];
                        [params setValue:@"" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fid"]];
                    }
                }
                if (var_localVip) {
                    BOOL var_autoStatus = [HTManage.sharedInstance.model6.var_local.var_auto_renew_status integerValue] == 1;
                    if (var_autoStatus) {
                        [params setValue:@"1" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
                        [params setValue:@"1" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status2"]];
                    } else {
                        [params setValue:@"3" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status"]];
                        [params setValue:@"3" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"status2"]];
                    }
                    [params setValue:@"1" forKey:[LKFPrivateFunction htMethodStringToInt:@"g_status"]];
                    NSString *pid = [[NSUserDefaults standardUserDefaults] objectForKey:@"udf_pid"];
                    [params setValue:pid forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
                }
            }
            
            [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"subscribe_status"] params:params];
            
            if (block) {
                block(var_payModel);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NTFCTString_PurchaseVerifyCompletion" object:nil];
        } else {
            if (block) {
                block(nil);
            }
        }
    }];
}

- (void)ht_checkLogin {
    
    if (HTManage.sharedInstance.model2.var_uid) {
        return;
    }
    if (HTManage.sharedInstance.model6.var_local.var_value == 1) {
        return;
    }
    if ([HTManage.sharedInstance.model6.var_device.var_val integerValue] == 0) {
        return;
    }
    //测试-待处理
//    if ([[HTWindowManage ht_getCurrentVC] isKindOfClass:[HTWebViewController class]]) {
//        return;
//    }
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        HTWebViewController *vc = [[HTWebViewController alloc] init];
//        vc.source = @"37";
//        vc.var_force = [[HTToolKitManager shared] lgjeropj_strip_k13] > 0 ? @"1" : @"2";
//        [HTWindowManage ht_windowPushToVC:vc andCurrentVC:nil andHideBottom:YES];
//    });
}

- (void)ht_getUserInfo:(nullable BLOCK_UserModelBlock)block{
    if (HTManage.sharedInstance.model2.var_uid) {
        [self ht_getUserInfoWithUid:self.model2.var_uid andBlock:block];
    }
}

- (BOOL)ht_checkSub{
    if (self.model6.var_local.var_value == 1 || [self.model6.var_server.var_val2 isEqualToString:@"1"] || [self.model6.var_device.var_val isEqualToString:@"1"] || [self.model6.var_family.var_val isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}

- (void)ht_deleteAllSearch{
    NSString *key = @"udf_searchhistory";
    [NSUserDefaults.standardUserDefaults removeObjectForKey:key];
}

- (void)ht_saveSearchModel:(BaseCellModel*)model{
    if (![model isKindOfClass:BaseCellModel.class]) {
        return;
    }
    if ([LKFPrivateFunction lgjeropj_isEmpty:model.var_title]) {
        return;
    }
    NSString *key = @"udf_searchhistory";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [[NSMutableArray alloc] init];
    if (value) {
        var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:BaseCellModel.class json:value]];
        if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:var_marr]) {
            NSInteger index = NSNotFound;
            for (int i = 0; i<var_marr.count; i++) {
                BaseCellModel *tmoModel = var_marr[i];
                if ([tmoModel.var_title isEqualToString:model.var_title]) {
                    index = i;
                    break;;
                }
            }
            if (index != NSNotFound) {
              [var_marr removeObjectAtIndex:index];
            }
            [var_marr insertObject:model atIndex:0];
        } else {
            [var_marr addObject:model];
        }
    } else {
        [var_marr addObject:model];
    }
    [NSUserDefaults.standardUserDefaults setObject:[var_marr yy_modelToJSONString] forKey:key];
}
- (NSArray<BaseCellModel*>*)ht_getSearchDatasource{
    NSString *key = @"udf_searchhistory";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:BaseCellModel.class json:value]];
    return [NSArray arrayWithArray:var_marr?:@[]];
}


- (nullable MovieModel*)ht_checkCollect:(NSString*)var_ids{
    MovieModel *var_resultModel = nil;
    NSString *key = @"udf_collect";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [[NSMutableArray alloc] init];
    if (value) {
        var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:MovieModel.class json:value]];
        if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:var_marr]) {
            for (int i = 0; i<var_marr.count; i++) {
                MovieModel *model = var_marr[i];
                if ([model.var_id isEqualToString:var_ids]) {
                    var_resultModel = model;
                }
            }
        }
    }
    return var_resultModel;
}

- (void)ht_updateCollect:(MovieModel*)model{
    if (![self ht_checkCollect:model.var_id]) {
        return;
    }
    
    NSString *key = @"udf_collect";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [[NSMutableArray alloc] init];
    if (value) {
        var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:MovieModel.class json:value]];
        if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:var_marr]) {
            for (int i = 0; i<var_marr.count; i++) {
                MovieModel *tmoModel = var_marr[i];
                if ([tmoModel.var_id isEqualToString:model.var_id]) {
                    [var_marr replaceObjectAtIndex:i withObject:model];
                    break;
                }
            }
        }
        [NSUserDefaults.standardUserDefaults setObject:[var_marr yy_modelToJSONString] forKey:key];
    }
}

- (BOOL)ht_saveCollectModel:(MovieModel*)model andDele:(BOOL)del{
    if (![model isKindOfClass:MovieModel.class]) {
        return NO;
    }
    NSString *key = @"udf_collect";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [[NSMutableArray alloc] init];
    MovieModel *saveModel = [[MovieModel alloc] init];
    saveModel.var_id = model.var_id;
    saveModel.var_title = model.var_title;
    saveModel.var_rate = model.var_rate;
    saveModel.var_step = model.var_step;
    saveModel.var_shouldOpen = model.var_shouldOpen;
    saveModel.var_stepCurrentTime = model.var_stepCurrentTime;
    saveModel.var_stepSessionId = model.var_stepSessionId;
    saveModel.var_stepLanguage = model.var_stepLanguage;
    saveModel.var_stepMovieId = model.var_stepMovieId;
    saveModel.var_data_type = model.var_data_type;
    if ([LKFPrivateFunction lgjeropj_isNotEmpty:model.var_m_type_2]) {
        saveModel.var_m_type_2 = model.var_m_type_2;
    }
    saveModel.var_cover = model.var_cover;
    saveModel.var_stars = model.var_stars;
    saveModel.var_desc = model.var_desc;
    saveModel.var_pub_date = model.var_pub_date;
    saveModel.var_quality = model.var_quality;
    saveModel.var_ss_eps = model.var_ss_eps;
    saveModel.var_tags = model.var_tags;
    if (value) {
        var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:MovieModel.class json:value]];
        if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:var_marr]) {
            NSInteger index = NSNotFound;
            for (int i = 0; i<var_marr.count; i++) {
                MovieModel *tmoModel = var_marr[i];
                if ([tmoModel.var_id isEqualToString:saveModel.var_id]) {
                    index = i;
                    break;;
                }
            }
            if (del) {
                if (index != NSNotFound) {
                    [var_marr removeObjectAtIndex:index];
                } else {
                    [var_marr insertObject:saveModel atIndex:0];
                }
            } else {
                if (index != NSNotFound) {
                    [var_marr removeObjectAtIndex:index];
                }
                [var_marr insertObject:saveModel atIndex:0];
            }
        } else {
            [var_marr addObject:saveModel];
        }
    } else {
        [var_marr addObject:saveModel];
    }
    [NSUserDefaults.standardUserDefaults setObject:[var_marr yy_modelToJSONString] forKey:key];
    return YES;
}
- (NSArray<MovieModel*>*)ht_getCollectDatasource{
    NSString *key = @"udf_collect";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:MovieModel.class json:value]];
    return [NSArray arrayWithArray:var_marr?:@[]];
}

- (nullable MovieModel*)ht_checkHistory:(NSString*)ids{
    NSString *key = @"udf_history";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [[NSMutableArray alloc] init];
    if (value) {
        var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:MovieModel.class json:value]];
        if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:var_marr]) {
            for (int i = 0; i<var_marr.count; i++) {
                MovieModel *tmoModel = var_marr[i];
                if ([tmoModel.var_id isEqualToString:ids]) {
                    return tmoModel;
                }
            }
        }
    }
    return nil;
}
- (BOOL)ht_saveHistoryModel:(MovieModel*)model andDele:(BOOL)del{
    if (![model isKindOfClass:MovieModel.class]) {
        return NO;
    }
    NSString *key = @"udf_history";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [[NSMutableArray alloc] init];
    MovieModel *saveModel = [[MovieModel alloc] init];
    saveModel.var_id = model.var_id;
    saveModel.var_title = model.var_title;
    saveModel.var_shouldOpen = model.var_shouldOpen;
    saveModel.var_step = model.var_step;
    saveModel.var_stepCurrentTime = model.var_stepCurrentTime;
    saveModel.var_stepSessionId = model.var_stepSessionId;
    saveModel.var_stepMovieId = model.var_stepMovieId;
    saveModel.var_stepLanguage = model.var_stepLanguage;
    saveModel.var_rate = model.var_rate;
    saveModel.var_data_type = model.var_data_type;
    if ([LKFPrivateFunction lgjeropj_isNotEmpty:model.var_m_type_2]) {
        saveModel.var_m_type_2 = model.var_m_type_2;
    }
    saveModel.var_cover = model.var_cover;
    saveModel.var_stars = model.var_stars;
    saveModel.var_desc = model.var_desc;
    saveModel.var_pub_date = model.var_pub_date;
    saveModel.var_tags = model.var_tags;
    saveModel.var_quality = model.var_quality;
    saveModel.var_ss_eps = model.var_ss_eps;
    if (value) {
        var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:MovieModel.class json:value]];
        if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:var_marr]) {
            NSInteger index = NSNotFound;
            for (int i = 0; i<var_marr.count; i++) {
                MovieModel *tmoModel = var_marr[i];
                if ([tmoModel.var_id isEqualToString:saveModel.var_id]) {
                    index = i;
                    break;;
                }
            }
            if (del) {
                if (index != NSNotFound) {
                    [var_marr removeObjectAtIndex:index];
                } else {
                    [var_marr insertObject:saveModel atIndex:0];
                }
            } else {
                if (index != NSNotFound) {
                    [var_marr removeObjectAtIndex:index];
                }
                [var_marr insertObject:saveModel atIndex:0];
            }
        } else {
            [var_marr addObject:saveModel];
        }
    } else {
        [var_marr addObject:saveModel];
    }
    [NSUserDefaults.standardUserDefaults setObject:[var_marr yy_modelToJSONString] forKey:key];
    return YES;
}

- (BOOL)ht_saveHistoryModel:(MovieModel*)model{
    return [self ht_saveHistoryModel:model andDele:NO];
}

- (NSArray<MovieModel*>*)ht_getHistoryDatasource{
    NSString *key = @"udf_history";
    NSString *value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    NSMutableArray *var_marr = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:MovieModel.class json:value]];
    return [NSArray arrayWithArray:var_marr?:@[]];
}

- (BOOL)ht_checkLockIds:(NSString*)ids{
    if (!ids) {
        return NO;
    }
    NSString *key = @"udf_lock_ids";
    NSArray *array = [NSUserDefaults.standardUserDefaults arrayForKey:key];
    if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:array] && [array indexOfObject:ids] != NSNotFound) {
        return YES;
    }
    return NO;
}

- (void)ht_saveLockIds:(NSString*)ids{
    if (!ids) {
        return;
    }
    NSString *key = @"udf_lock_ids";
    NSMutableArray *array = [NSMutableArray arrayWithArray:[NSUserDefaults.standardUserDefaults arrayForKey:key]];
    if ([LKFPrivateFunction lgjeropj_isNotEmptyArray:array]) {
        if ([array indexOfObject:ids]!=NSNotFound) {
            [array removeObject:ids];
        }
    }
    [array addObject:ids];
    [NSUserDefaults.standardUserDefaults setObject:array forKey:key];
}
- (NSArray<NSString*>*)ht_getLockIds{
    NSString *key = @"udf_lock_ids";
    return [NSUserDefaults.standardUserDefaults arrayForKey:key]?:@[];
}

- (void)setModel6:(PayModel *)var_payModel{
    if (var_payModel) {
        [NSUserDefaults.standardUserDefaults setObject:[var_payModel yy_modelToJSONString]forKey:@"udf_payModel"];
    } else {
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"udf_payModel"];
    }
}

- (PayModel *)model6{
    NSString *str = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_payModel"];
    PayModel *var_payModel = [[PayModel alloc] init];
    if (str) {
        var_payModel = [PayModel yy_modelWithJSON:str];
    }
    return var_payModel;
}

- (void)setModel5:(SubscribeModel *)var_subscribeModel{
    if (var_subscribeModel) {
        [NSUserDefaults.standardUserDefaults setObject:[var_subscribeModel yy_modelToJSONString]forKey:@"udf_subscribeModel"];
    } else {
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"udf_subscribeModel"];
    }
}

- (SubscribeModel *)model5{
    NSString *str = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_subscribeModel"];
    SubscribeModel *var_subscribeModel = [[SubscribeModel alloc] init];
    if (str) {
        var_subscribeModel = [SubscribeModel yy_modelWithJSON:str];
    }
    return var_subscribeModel;
}

- (void)setModel2:(UserModel *)var_userModel{
    if (var_userModel) {
        [NSUserDefaults.standardUserDefaults setObject:[var_userModel yy_modelToJSONString]forKey:@"udf_user"];
    } else {
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"udf_user"];
    }
}

- (UserModel *)model2{
    NSString *str = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_user"];
    UserModel *var_userModel = [[UserModel alloc] init];
    if (str) {
        var_userModel = [UserModel yy_modelWithJSON:str];
    }
    return var_userModel;
}

+ (UIActivityViewController*)ht_shareTitle:(nullable NSString*)title andURL:(nullable NSString*)url andImage:(nullable NSString*)image andBlock:(nullable BLOCK_EventViewBlock)block{
    NSMutableArray *var_marr = [[NSMutableArray alloc] init];
    if (title) {
        [var_marr addObject:title];
    }
    if (url) {
        NSURL *nurl = [NSURL URLWithString:url];
        if (nurl) [var_marr addObject:nurl];
    }
    if (image) {
        UIImage *iv = [UIImage imageNamed:image];
        if (iv) [var_marr addObject:iv];
    }
    NSArray *activityItems = [NSArray arrayWithArray:var_marr];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    UIViewController *vc = HTWindow.rootViewController;
    if (HT_IPAD) {
        activityVC.popoverPresentationController.sourceView = vc.view;
        activityVC.popoverPresentationController.sourceRect = CGRectMake(15, vc.view.frame.size.height/2.0, 1.0, 1.0);
        activityVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [vc presentViewController:activityVC animated:NO completion:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (block) {
            block(@(completed));
        }
    };
    return activityVC;
}

+ (UIActivityViewController*)ht_shareTitle:(nullable NSString*)title andURL:(nullable NSString*)url andImage:(nullable NSString*)image{
   return [HTManage ht_shareTitle:title andURL:url andImage:image andBlock:nil];
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [HTManage sharedInstance] ;
}

- (id)copyWithZone:(struct _NSZone *)zone{
    return [HTManage sharedInstance] ;
}

@end
