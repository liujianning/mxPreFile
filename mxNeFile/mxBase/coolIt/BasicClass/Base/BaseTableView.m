//
//  BaseTableView.m
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import "BaseTableView.h"
#import "SVPullToRefresh.h"

@interface BaseTableView ()

@property (nonatomic, assign)  BOOL var_showHeader;
@property (nonatomic, assign)  BOOL var_showFooter;

@end

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 44;
        self.rowHeight = UITableViewAutomaticDimension;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 11.0, *)) {
            self.estimatedSectionHeaderHeight = 0.01;
            self.estimatedSectionFooterHeight = 0.01;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        self.automaticallyAdjustsScrollIndicatorInsets = false;
        if (@available(iOS 15.0, *)) {
            self.sectionHeaderTopPadding = 0;
        }
        self.backgroundColor = [UIColor ht_colorWithHexString:@"#111219"];
        self.showsHorizontalScrollIndicator = NO;
        self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
    }
    return self;
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

