//
//  BaseCollectionViewCell.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "BaseCollectionViewCell.h"
@implementation BaseCollectionViewCell

+ (instancetype)ht_cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath
{
    return [self ht_cellWithCollectionView:collectionView andForIndexPath:indexPath andIdentifier:nil];
}

+ (instancetype)ht_cellWithCollectionView:(UICollectionView *)collectionView andForIndexPath:(NSIndexPath *)indexPath andIdentifier:(nullable NSString *)identifier
{
    if (!identifier) {
        identifier = [NSString stringWithFormat:@"%@",NSStringFromClass(self)];
    }
    [collectionView registerClass:self.class forCellWithReuseIdentifier:identifier];
    return [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)ht_commonInit
{
    [self ht_addCellSubViews];
    [self setNeedsUpdateConstraints];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ht_commonInit];
    }
    return self;
}

- (void)dealloc
{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)ht_addCellSubViews {}

- (void)ht_updateCellWithData {}

- (void)updateConstraints {
    [self lgjeropj_updateConstraints];
    [super updateConstraints];
}

- (void)lgjeropj_updateConstraints
{    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end
