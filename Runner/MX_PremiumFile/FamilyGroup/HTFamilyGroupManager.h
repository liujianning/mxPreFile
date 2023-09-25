//
//  HTFamilyGroupManager.h
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import <UIKit/UIKit.h>
#import "ZQFamilyAccountModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTFamilyGroupManager : UIView

+ (void)lgjeropj_requestFamilyInfo:(void(^)(id data))completion;

+ (void)ht_deleteFamilyMember:(ZQFamilyAccountModel *)model andComplete:(void(^)(id data))completion;

+ (void)ht_dissolveFamilyGroupAction:(void(^)(id data))completion;

+ (void)lgjeropj_addMemberRequest:(NSString *)title andComplete:(void(^)(void))completion;

+ (void)ht_showHowAddMember;

@end

NS_ASSUME_NONNULL_END
