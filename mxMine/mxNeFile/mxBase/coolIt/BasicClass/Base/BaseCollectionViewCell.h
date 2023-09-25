//
//  BaseCollectionViewCell.h
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import <UIKit/UIKit.h>
#import "BaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) BaseCellModel *model;
@property (nonatomic,strong) NSIndexPath *indexPath;

+ (instancetype)ht_cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)ht_cellWithCollectionView:(UICollectionView *)collectionView andForIndexPath:(NSIndexPath *)indexPath andIdentifier:(nullable NSString *)identifier;
- (void)ht_addCellSubViews;
- (void)ht_updateCellWithData;
- (void)lgjeropj_updateConstraints;

@end

NS_ASSUME_NONNULL_END
