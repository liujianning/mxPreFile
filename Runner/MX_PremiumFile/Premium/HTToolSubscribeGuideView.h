//
//  HTToolSubscribeGuideView.h
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTToolSubscribeGuideView : UIView

@property (nonatomic, copy) void (^BLOCK_skipBlock) (void);
@property (nonatomic, copy) void (^BLOCK_subscribeBlock) (void);

@end

NS_ASSUME_NONNULL_END
