//
//  HistoryCell.h
//  Movie
//
//  Created by wmz on 2023/2/13.
//

#import <UIKit/UIKit.h>
#import "PostCommon_Enum.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCell : BaseTableViewCell

@property (nonatomic,copy) BLOCK_EventViewBlock block;
@property (nonatomic,copy) NSString *source;
- (void)ht_addCellSubViews;
- (void)ht_updateCellWithData;

@end

NS_ASSUME_NONNULL_END
