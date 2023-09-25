//
//  PreiumBottomItemView.h
//  Movie
//
//  Created by wmz on 2023/2/21.
//

#import "BaseView.h"
#import "YYText.h"

NS_ASSUME_NONNULL_BEGIN

@interface PreiumBottomItemView : BaseView
@property (nonatomic,strong) UIView *pointView;
@property (nonatomic,strong) YYLabel *nameLabel;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *freStr;
@property (nonatomic,copy) NSString *webTitle;
@property (nonatomic,assign) BOOL pushWeb;
@end

NS_ASSUME_NONNULL_END
