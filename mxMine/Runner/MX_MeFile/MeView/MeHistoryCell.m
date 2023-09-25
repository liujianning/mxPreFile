//
//  MeHistoryCell.m
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "MeHistoryCell.h"
#import "CommonMovieItemCell.h"
#import "HTCollectionViewModel.h"

@interface MeHistoryCell()<HTCollectionViewModelDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) HTCollectionViewModel *collectionViewModel;

@end

@implementation MeHistoryCell

- (void)ht_addCellSubViews
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(HTNum(84), HTNum(155));
    flow.minimumLineSpacing = HTNum(5);
    flow.minimumInteritemSpacing = HTNum(5);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.sectionInset = UIEdgeInsetsMake(0, HTNum(10), 0, HTNum(10));
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:flow];
    self.collectionView.delegate = self.collectionViewModel;
    self.collectionView.dataSource = self.collectionViewModel;
    self.collectionView.backgroundColor = [UIColor ht_colorWithHexString:@"#111219"];
    [self.contentView addSubview:self.collectionView];
    self.clipsToBounds = YES;
}

- (void)lgjeropj_updateConstraints
{
    [super lgjeropj_updateConstraints];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(HTNum(155));
        make.bottom.mas_equalTo(-HTNum(15));
    }];
}
- (void)ht_updateCellWithData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (NSInteger)lgjeropj_collectionView:(UICollectionView *)collectionView andNumberOfItemsInSection:(NSInteger)section {
    return self.model.dataArray.count;
}

- (UICollectionViewCell *)lgjeropj_collectionView:(UICollectionView *)collectionView andCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommonMovieItemCell *item = [CommonMovieItemCell ht_cellWithCollectionView:collectionView forIndexPath:indexPath];
    if (self.model.dataArray.count > indexPath.row) {
        item.model = self.model.dataArray[indexPath.row];
    }
    item.model.var_showPlay = YES;
    item.var_source = @"6";
    [item ht_updateCellWithData];
    return item;
}

- (void)lgjeropj_collectionView:(UICollectionView *)collectionView andDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (HTCollectionViewModel *)collectionViewModel {
    
    if (!_collectionViewModel) {
        _collectionViewModel = [[HTCollectionViewModel alloc] init];
        _collectionViewModel.delegate = self;
    }
    return _collectionViewModel;
}

@end
