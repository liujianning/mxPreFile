//
//  HTFamilyTableViewCell.h
//  Merriciya
//
//  Created by 昊天 on 2023/5/29.
//

#import <UIKit/UIKit.h>
#import "ZQFamilyAccountModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HTFamilyTableCellClickDelegate <NSObject>

@optional

/// 点击代理
- (void)ht_familyMemberCellClick:(NSInteger)index;

@end

@interface HTFamilyTableViewCell : UITableViewCell
@property (nonatomic, assign) id <HTFamilyTableCellClickDelegate> delegate;
@property (nonatomic, strong) UIImageView *var_headerImgView;
@property (nonatomic, strong) UILabel *var_nameLabel;//名字
@property (nonatomic, strong) UILabel *var_titleLabel;//抬头
@property (nonatomic, strong) UIImageView *var_diamondView;//钻石logo
@property (nonatomic, strong) UIButton *var_deleteButton;//删除按钮
@property (nonatomic, strong) UIView *var_lineView;

- (void)lgjeropj_updateCellWithData:(ZQFamilyAccountModel*)model andIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
