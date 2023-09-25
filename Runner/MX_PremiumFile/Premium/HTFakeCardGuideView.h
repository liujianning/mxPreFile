//
//  HTFakeCardGuideView.h
 
//
//  Created by 李雪健 on 2023/7/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTFakeCardGuideView : UIView

@property (nonatomic, copy) BLOCK_VoidBlock var_becomeAction;
@property (nonatomic, copy) BLOCK_VoidBlock var_skipAction;

@end

NS_ASSUME_NONNULL_END
