//
//  HTPremiumHeaderView.h
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTPremiumHeaderView : UIScrollView

@property (nonatomic, strong) UIImageView *head2Icon;
@property (nonatomic, copy) void (^BLOCK_FamilyMemberBlock) (void);

- (void)ht_updateLocalUI;
- (void)ht_updateServerUI;

@end

NS_ASSUME_NONNULL_END
