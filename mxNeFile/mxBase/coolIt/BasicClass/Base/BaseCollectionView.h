//
//  BaseCollectionView.h
//  Movie
//
//  Created by wmz on 2023/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionView : UICollectionView

@property (nonatomic, assign)  NSInteger var_pageNum;

@property (nonatomic, copy) void (^BLOCK_requestNewDataHandlerBlock)(void);
@property (nonatomic, copy) void (^BLOCK_requestMoreDataHandlerBlock)(void);

- (void)lgjeropj_refreshHeader:(BOOL)show;
- (void)lgjeropj_refreshFooter:(BOOL)show;

- (void)ht_reloadData:(BOOL)isNoMore;
- (void)ht_reloadFail;

@end

NS_ASSUME_NONNULL_END
