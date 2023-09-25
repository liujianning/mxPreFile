//
//  HTSubscripBootBottomView.h
 
//
//  Created by 李雪健 on 2023/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTSubscripBootBottomView : UIView

@property (nonatomic, strong) UIButton *var_priceBTN;

@property (nonatomic, copy) void (^BLOCK_payBlock) (void);
@property (nonatomic, copy) void (^BLOCK_moreBlock) (void);

@end

NS_ASSUME_NONNULL_END
