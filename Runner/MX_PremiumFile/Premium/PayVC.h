//
//  PayVC.h
//  Movie
//
//  Created by wmz on 2023/3/10.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^BLOCK_PayPurchaseResultBlock)(BOOL var_success);

@interface PayVC : BaseVC

- (void)ht_payAction:(NSString*)proeuctId andBlock:(nullable BLOCK_PayPurchaseResultBlock)block;

@end

NS_ASSUME_NONNULL_END
