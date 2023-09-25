//
//  MainTabbarVC.h
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import <UIKit/UIKit.h>
#import "BaseNaviVC.h"
#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainTabbarVC : UITabBarController
///打开开关的方式   1 正常打开  2 搜索OPEN打开
@property (nonatomic,copy) NSString *var_op_type;
- (BaseNaviVC*)ht_addChildController:(NSString *)vcName andTitle:(NSString *)title andNorImage:(NSString *)norImage andSelectedImage:(NSString *)selectedImage andIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
