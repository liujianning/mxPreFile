//
//  BaseCollectionView.m
//  Movie
//
//  Created by wmz on 2023/3/3.
//

#import "BaseCollectionView.h"
#import "SVPullToRefresh.h"

@interface BaseCollectionView ()

@property (nonatomic, assign)  BOOL var_showHeader;
@property (nonatomic, assign)  BOOL var_showFooter;

@end

@implementation BaseCollectionView

- (NSInteger)var_pageNum
{
    if (!_var_pageNum) {
        _var_pageNum = 1;
    }
    return _var_pageNum;
}

- (void)lgjeropj_refreshHeader:(BOOL)show
{
    self.var_showHeader = show;
    if (show) {
        __weak typeof(self) weakSelf = self;
        [self addPullToRefreshWithActionHandler:^{
            weakSelf.var_pageNum = 1;
            if (weakSelf.BLOCK_requestNewDataHandlerBlock) weakSelf.BLOCK_requestNewDataHandlerBlock();
        }];
    } else {
        [self setShowsPullToRefresh:NO];
    }
}

- (void)lgjeropj_refreshFooter:(BOOL)show
{
    self.var_showFooter = show;
    if (show) {
        __weak typeof(self) weakSelf = self;
        [self addInfiniteScrollingWithActionHandler:^{
            if (!weakSelf.var_pageNum) weakSelf.var_pageNum = 1;
            weakSelf.var_pageNum += 1;
            if (weakSelf.BLOCK_requestMoreDataHandlerBlock) weakSelf.BLOCK_requestMoreDataHandlerBlock();
        }];
        self.infiniteScrollingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    } else {
        [self setShowsInfiniteScrolling:NO];
    }
}

- (void)ht_reloadData:(BOOL)isNoMore
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];

        if (self.var_pageNum == 1) {
            
            if (self.var_showHeader) {
                [self.pullToRefreshView stopAnimating];
            }
            if (self.var_showFooter) {
                self.infiniteScrollingView.enabled = YES;
            }
        } else {
            if (self.var_showFooter) {
                self.infiniteScrollingView.enabled = !isNoMore;
                [self.infiniteScrollingView stopAnimating];
            }
        }
    });
}

- (void)ht_reloadFail
{
    if (self.var_showHeader) [self.pullToRefreshView stopAnimating];
    if (self.var_showFooter) [self.infiniteScrollingView stopAnimating];
    if (self.var_pageNum == 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    }
}

@end
