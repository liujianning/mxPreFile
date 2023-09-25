//
//  HTCollectionViewModel.h
 
//
//  Created by 李雪健 on 2023/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HTCollectionViewModelDelegate <NSObject>

// cell
- (UICollectionViewCell *)lgjeropj_collectionView:(UICollectionView *)collectionView andCellForItemAtIndexPath:(NSIndexPath *)indexPath;
// number row
- (NSInteger)lgjeropj_collectionView:(UICollectionView *)collectionView andNumberOfItemsInSection:(NSInteger)section;

@optional
// number section
- (NSInteger)lgjeropj_numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
// did select
- (void)lgjeropj_collectionView:(UICollectionView *)collectionView andDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
// size for item
- (CGSize)lgjeropj_collectionView:(UICollectionView *)collectionView andLayout:(UICollectionViewLayout *)collectionViewLayout andSizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HTCollectionViewModel : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <HTCollectionViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
