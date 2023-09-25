//
//  HistoryVC.h
//  Movie
//
//  Created by wmz on 2023/2/13.
//

#import "BaseVC.h"
#import "BaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryVC : BaseVC

@property (nonatomic,assign) BOOL edit;
@property (nonatomic,strong) BaseTableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
