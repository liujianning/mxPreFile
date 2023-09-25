//
//  HTTableViewModel.h
 
//
//  Created by 李雪健 on 2023/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HTTableViewModelDelegate <NSObject>

// row
- (NSInteger)lgjeropj_tableView:(UITableView *)tableView andNumberOfRowsInSection:(NSInteger)section;
// cell
- (UITableViewCell *)lgjeropj_tableView:(UITableView *)tableView andCellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
// section
- (NSInteger)lgjeropj_numberOfSectionsInTableView:(UITableView *)tableView;
// did select
- (void)lgjeropj_tableView:(UITableView *)tableView andSelectRowAtIndexPath:(NSIndexPath *)indexPath;
// height row
- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForRowAtIndexPath:(NSIndexPath *)indexPath;
// height header
- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForHeaderInSection:(NSInteger)section;
// view header
- (UIView *)lgjeropj_tableView:(UITableView *)tableView andViewForHeaderInSection:(NSInteger)section;
// height footer
- (CGFloat)lgjeropj_tableView:(UITableView *)tableView andHeightForFooterInSection:(NSInteger)section;
// view footer
- (UIView *)lgjeropj_tableView:(UITableView *)tableView andViewForFooterInSection:(NSInteger)section;

@end

@interface HTTableViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id <HTTableViewModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
