//
//  BaseTableViewCell.h
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import <UIKit/UIKit.h>
#import "BaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,strong) BaseCellModel *model;

+ (instancetype)ht_cellWithTableView:(UITableView *)tableView;
+ (instancetype)ht_cellWithTableView:(UITableView *)tableView andIdentifier:(NSString *_Nullable)identifier;
- (void)ht_addCellSubViews;
- (void)ht_updateCellWithData;
- (void)lgjeropj_updateConstraints;

@end

NS_ASSUME_NONNULL_END
