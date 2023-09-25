//
//  AdSubAlert.h
//  Movie
//
//  Created by wmz on 2023/3/12.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdSubAlert : BaseView

@property (nonatomic, weak) UIViewController *movieVC;
@property (nonatomic, copy) void (^BLOCK_closeAdBlock) (void);

@end

NS_ASSUME_NONNULL_END
