//
//  BaseVC.h
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import <UIKit/UIKit.h>
#import "PostCommon_Enum.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ENUM_ControllerNaviType) {
    ENUM_ControllerNaviTypeNormal = 0,
    ENUM_ControllerNaviTypeHide = 1,
};

@interface BaseVC : UIViewController

@property(nonatomic,assign)CGFloat var_bottomMarginToTop;
@property (nonatomic,copy) BLOCK_EventViewBlock customVCEventBlock;
@property (nonatomic,strong) UIScrollView *var_scrollView;
@property (nonatomic,strong) UIView *contenView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIStackView *var_stackView;

- (void)ht_scrollView;
- (void)ht_bottomView;

- (void)ht_setupViews;
- (void)ht_bindViewModel;
- (void)ht_getNewData;
- (void)ht_setupNavigation;
- (void)ht_getWillData;
- (void)ht_backAction;
- (void)ht_customBack:(NSString*)name;
- (void)ht_customBack:(NSString*)name andForce:(BOOL)force;
- (void)ht_showGoSub;
- (ENUM_ControllerNaviType)ht_customNaviType;
- (NSString*)ht_pointType;

@property (nonatomic,copy) NSString *source;
///打开开关的方式   1 正常打开  2 搜索OPEN打开
@property (nonatomic,copy) NSString *var_op_type;

- (void)ht_updateViewConstraints;

@end

NS_ASSUME_NONNULL_END
