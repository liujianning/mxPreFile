//
//  HTPremiumProductManager.m
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import "HTPremiumProductManager.h"
#import "HTToolKitManager.h"

@implementation HTPremiumProductManager
#pragma mark - individual
- (NSArray *)lgjeropj_individualProductArray {
    // 拿到真卡片
    NSArray *array = [self lgjeropj_individualRealProductArray];
    // 插入假卡片、移除真卡片、插入活动数据
    NSArray *var_total = [self lgjeropj_insertIndividualFakeCard:array];
    return var_total;
}

- (NSArray *)lgjeropj_individualRealProductArray {
    // 月
    BaseCellModel *var_month = [[BaseCellModel alloc] init];
    var_month.var_title = LocalString(@"Monthly", nil);
    var_month.var_select= YES;
    var_month.var_kid = @"2";
    var_month.var_tag = STATIC_MONTH;
    var_month.data = [NSMutableDictionary dictionaryWithDictionary:@{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]:LocalString(@"Trial", nil),
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$2.99"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]:LocalString(@"for the 1 month", nil),
    }];
    // 年
    BaseCellModel *var_year = [[BaseCellModel alloc] init];
    var_year.var_title = LocalString(@"Yearly", nil);
    var_year.data = @{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"-74%"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$29.99"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$102"]
    };
    var_year.var_kid = @"3";
    var_year.var_tag = STATIC_YEAR;
    var_year.var_detail = [NSString stringWithFormat:LocalString(@"*Auto-renewal for %@ per year.", nil),[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$29.99"]];
    // 周
    BaseCellModel *var_week = [[BaseCellModel alloc] init];
    var_week.var_title = LocalString(@"Weekly", nil);
    var_week.data = @{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$1.99"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]:LocalString(@"for the 1st week", nil)
    };
    var_week.var_tag = STATIC_WEEK;
    var_week.var_kid = @"7";
    var_week.var_detail = [NSString stringWithFormat:LocalString(@"*Auto-renewal for %@ per week.", nil),[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$1.99"]];
    // 月年周
    return @[var_month, var_year, var_week];
}

- (NSArray *)lgjeropj_insertIndividualFakeCard:(NSArray *)array {
    
    NSMutableArray *var_total = [NSMutableArray arrayWithArray:array];
    NSDictionary *var_server = [[HTToolKitManager shared] lgjeropj_server_products];
    if ([self lgjeropj_showFake] && var_server.count > 0) {
        // 个人计划
        NSMutableDictionary *var_month = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"]]];
        [var_month setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
        // 假月
        [var_total insertObject:[self ht_translateModel:var_month] atIndex:0];
        NSMutableDictionary *var_year = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"]]];
        [var_year setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
        if ([var_total count] > 2) {
            // 假月 真月 假年 真年 真周
            [var_total insertObject:[self ht_translateModel:var_year] atIndex:2];
        } else {
            // 假月 假年
            [var_total addObject:[self ht_translateModel:var_year]];
        }
        NSMutableDictionary *var_week = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"week"]]];
        [var_week setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"week"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
        if ([var_total count] > 4) {
            // 假月 真月 假年 真年 假周 真周
            [var_total insertObject:[self ht_translateModel:var_week] atIndex:4];
        } else {
            // 假月 假年 假周
            [var_total addObject:[self ht_translateModel:var_week]];
        }
        // 移除真实商品
        NSArray *var_hidden = [[HTToolKitManager shared] lgjeropj_hidden_products];
        if (var_hidden.count > 0) {
            for (int i = 0; i < [var_hidden count]; i++) {
                NSString *var_productId = var_hidden[i];
                for (NSInteger j = var_total.count-1; j >= 0; j--) {
                    BaseCellModel *model = var_total[j];
                    if (!model.var_fake && [model.var_tag containsString:var_productId]) {
                        [var_total removeObject:model];
                        break;
                    }
                }
            }
        }
        NSString *var_activity_product = @"";
        NSArray *var_k3 = [[HTToolKitManager shared] lgjeropj_strip_k3];
        if (var_k3.count > 0) {
            NSInteger var_activity = [[var_k3 firstObject] integerValue];
            if (var_activity == 1) {
                // 有活动
                if (var_k3.count > 2) {
                    var_activity_product = [NSString stringWithFormat:@"%@", [var_k3 objectAtIndex:2]];
                }
            }
        }
        if (var_activity_product.length > 0) {
            if ([var_activity_product containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"]]) {
                var_activity_product = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"year"];
            } else if ([var_activity_product containsString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"]]) {
                var_activity_product = [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"month"];
            }
            NSDictionary *var_trial_product = [var_server objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"trial"]];
            NSInteger index = -1;
            for (int i = 0; i < var_total.count; i++) {
                BaseCellModel *model = [var_total objectAtIndex:i];
                if (model.var_fake && [model.var_tag isEqualToString:var_activity_product]) {
                    index = i;
                    break;
                }
            }
            if (index >= 0) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:var_trial_product];
                dic[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"activity"]] = @"1";
                BaseCellModel *model = [self ht_translateModel:dic];
                [var_total replaceObjectAtIndex:index withObject:model];
            }
        }
    }
    return var_total;
}
#pragma mark - family
- (NSArray *)lgjeropj_familyProductArray {
    // 拿到真卡片
    NSArray *array = [self lgjeropj_familyRealProductArray];
    // 插入假卡片、移除真卡片、插入活动数据
    NSArray *var_total = [self lgjeropj_insertFamilyFakeCard:array];
    return var_total;
}

- (NSArray *)lgjeropj_familyRealProductArray {
    // 家庭月
    BaseCellModel *var_month = [[BaseCellModel alloc] init];
    var_month.var_title = LocalString(@"Monthly", nil);
    var_month.var_kid = @"2";
    var_month.var_tag = [NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_MONTH];
    var_month.data = [NSMutableDictionary dictionaryWithDictionary:@{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]:LocalString(@"Trial", nil),
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$7.99"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]:LocalString(@"for the 1 month", nil),
    }];
    // 家庭年
    BaseCellModel *var_year = [[BaseCellModel alloc] init];
    var_year.var_title = LocalString(@"Yearly", nil);
    var_year.data = @{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"-68%"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$49.99"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$156"]
    };
    var_year.var_kid = @"3";
    var_year.var_tag = [NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_YEAR];
    var_year.var_detail = [NSString stringWithFormat:LocalString(@"*Auto-renewal for %@ per year.", nil),[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$49.99"]];
    // 家庭周
    BaseCellModel *var_week = [[BaseCellModel alloc] init];
    var_week.var_title = LocalString(@"Weekly", nil);
    var_week.data = @{
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$2.99"],
        [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]:LocalString(@"for the 1st week", nil)
    };
    var_week.var_tag = [NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_WEEK];
    var_week.var_kid = @"7";
    var_week.var_detail = [NSString stringWithFormat:LocalString(@"*Auto-renewal for %@ per week.", nil), [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"$2.99"]];
    // 月年周
    return @[var_month, var_year, var_week];
}

- (NSArray *)lgjeropj_insertFamilyFakeCard:(NSArray *)array {
    
    NSMutableArray *var_total = [NSMutableArray arrayWithArray:array];
    NSDictionary *var_server = [[HTToolKitManager shared] lgjeropj_server_products];
    if ([self lgjeropj_showFake] && var_server.count > 0) {
        // 家庭计划
        NSMutableDictionary *var_fm = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fm"]]];
        [var_fm setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fm"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
        // 假月 真月 真年 真周
        [var_total insertObject:[self ht_translateModel:var_fm] atIndex:0];
        NSMutableDictionary *var_fy = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fy"]]];
        [var_fy setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fy"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
        if ([var_total count] > 2) {
            // 假月 真月 假年 真年 真周
            [var_total insertObject:[self ht_translateModel:var_fy] atIndex:2];
        } else {
            // 假月 假年
            [var_total addObject:[self ht_translateModel:var_fy]];
        }
        NSMutableDictionary *var_fw = [NSMutableDictionary dictionaryWithDictionary:[var_server objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fw"]]];
        [var_fw setValue:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fw"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
        if ([var_total count] > 4) {
            // 假月 真月 假年 真年 假周 真周
            [var_total insertObject:[self ht_translateModel:var_fw] atIndex:4];
        } else {
            // 假月 假年 假周
            [var_total addObject:[self ht_translateModel:var_fw]];
        }
        NSArray *var_hidden = [[HTToolKitManager shared] lgjeropj_hidden_products];
        if (var_hidden.count > 0) {
            for (int i = 0; i < [var_hidden count]; i++) {
                NSString *var_productId = var_hidden[i];
                for (NSInteger j = var_total.count-1; j >= 0; j--) {
                    BaseCellModel *model = var_total[j];
                    if (!model.var_fake) {
                        if ([var_productId isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fw"]] && [model.var_tag isEqualToString:[NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_WEEK]]) {
                            [var_total removeObject:model];
                            break;
                        }
                        if ([var_productId isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fm"]] && [model.var_tag isEqualToString:[NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_MONTH]]) {
                            [var_total removeObject:model];
                            break;
                        }
                        if ([var_productId isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"fy"]] && [model.var_tag isEqualToString:[NSString stringWithFormat:@"%@_%@", STATIC_FAMILY, STATIC_YEAR]]) {
                            [var_total removeObject:model];
                            break;
                        }
                    }
                }
            }
        }
    }
    return var_total;
}
#pragma mark - private
- (BaseCellModel *)ht_translateModel:(NSDictionary *)dic {
    
    NSInteger count = [[dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"c1"]] integerValue];
    NSString *var_symbol = [dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"d1"]];
    NSString *var_h1 = [NSString stringWithFormat:@"%@", [dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"h1"]]];
    NSString *var_h2 = [NSString stringWithFormat:@"%@", [dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"h2"]]];
    NSString *var_y1 = [NSString stringWithFormat:@"%@", [dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"y1"]]];
    BaseCellModel *model = [[BaseCellModel alloc] init];
    if (count < 30) {
        model.var_title = LocalString(@"Weekly", nil);
        model.var_kid = @"42";
    } else if (count == 30) {
        model.var_title = LocalString(@"Monthly", nil);
        model.var_kid = @"38";
    } else {
        model.var_title = LocalString(@"Annually", nil);
        model.var_kid = @"39";
    }
    model.var_params = dic;
    model.var_tag = [dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"product"]];
    BOOL var_activity = [[dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"activity"]] integerValue] > 0;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:[NSString stringWithFormat:@"%@%@", var_symbol, var_h2] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"price"]];
    [params setValue:[NSString stringWithFormat:@"%@%@", var_symbol, var_y1] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"content"]];
    if (var_activity) {
        [params setValue:LocalString(@"Limited Offer", nil) forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]];
    } else if (![var_h1 isEqualToString:var_h2] && var_h1.length > 0) {
        [params setValue:LocalString(@"Trial", nil) forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tag"]];
    }
    model.var_pay = var_h1.length > 0 ? var_h1 : var_h2;
    model.data = params;
    model.var_activity = var_activity;
    model.var_detail = [dic objectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"t1"]];
    model.var_fake = YES;
    return model;
}

- (BOOL)lgjeropj_showFake {
    
    BOOL var_isLocalVip = HTManage.sharedInstance.model6.var_local.var_value == 1;
    BOOL var_isToolVip = [HTManage.sharedInstance.model6.var_server.var_t1 integerValue] == 2;
    // 非本地订阅用户 或 是工具包订阅用户
    if (!var_isLocalVip || var_isToolVip) {
        if ([[HTToolKitManager shared] lgjeropj_strip_k12]) {
            return YES;
        }
    }
    return NO;
}

@end
