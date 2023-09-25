//
//  BaseCustomNaviView.h
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCustomNaviView : BaseView

@property (nonatomic,assign) CGFloat customContentH;
@property (nonatomic,assign) CGFloat customContentHH;
@property (nonatomic,assign) BOOL useStatusBar;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *backBTN;

- (void)ht_backAction;

@end

NS_ASSUME_NONNULL_END
