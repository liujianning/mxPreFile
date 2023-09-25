//
//  BaseView.h
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import <UIKit/UIKit.h>
#import "SRBaseView.h"
#import "PostCommon_Enum.h"

NS_ASSUME_NONNULL_BEGIN
@interface BaseView : SRBaseView

@property (nonatomic,copy) BLOCK_EventViewBlock customEventBlock;

- (void)ht_bindViewModel;
- (void)ht_setupViews;
- (void)ht_getNewData;
- (BOOL)ht_getNewDataFirst;
- (void)lgjeropj_updateConstraints;

@end

NS_ASSUME_NONNULL_END
