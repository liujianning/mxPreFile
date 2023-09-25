//
//  HTCollectionViewModel.m
 
//
//  Created by 李雪健 on 2023/7/13.
//

#import "HTCollectionViewModel.h"

@implementation HTCollectionViewModel

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_numberOfSectionsInCollectionView:)]) {
        [self.delegate lgjeropj_numberOfSectionsInCollectionView:collectionView];
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_collectionView:andCellForItemAtIndexPath:)]) {
        return [self.delegate lgjeropj_collectionView:collectionView andCellForItemAtIndexPath:indexPath];
    }
    return [[UICollectionViewCell alloc] init];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_collectionView:andNumberOfItemsInSection:)]) {
        return [self.delegate lgjeropj_collectionView:collectionView andNumberOfItemsInSection:section];
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_collectionView:andDidSelectItemAtIndexPath:)]) {
        return [self.delegate lgjeropj_collectionView:collectionView andDidSelectItemAtIndexPath:indexPath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_collectionView:andLayout:andSizeForItemAtIndexPath:)]) {
        return [self.delegate lgjeropj_collectionView:collectionView andLayout:collectionViewLayout andSizeForItemAtIndexPath:indexPath];
    }
    if ([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        return [(UICollectionViewFlowLayout *)collectionViewLayout itemSize];
    }
    return CGSizeZero;
}

@end
