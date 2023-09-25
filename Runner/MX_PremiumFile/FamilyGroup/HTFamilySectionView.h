//
//  HTFamilySectionView.h
 
//
//  Created by 李雪健 on 2023/7/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTFamilySectionView : UIView

@property (nonatomic, copy) void (^BLOCK_buttonActionBlock) (NSInteger type);

- (instancetype)initWithType:(NSInteger)type count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
