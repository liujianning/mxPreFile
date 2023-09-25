//
//  MainTabbarVC.m
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import "MainTabbarVC.h"
//#import "HTFamilyViewController.h"//测试-待处理
//#import "HTRemindAddFamilyMemberView.h"//测试-待处理

@interface MainTabbarVC ()<UITabBarControllerDelegate>

@end

@implementation MainTabbarVC

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *viewControllers = @[
        [self ht_addChildController:@"HomeVC" andTitle:LocalString(@"Home", nil) andNorImage:@"icon_tab_0" andSelectedImage:@"icon_tab_0_sel" andIndex:0],
        [self ht_addChildController:@"PremiumVC" andTitle:LocalString(@"Premium", nil) andNorImage:@"icon_tab_1" andSelectedImage:@"icon_tab_1_sel" andIndex:1],
        [self ht_addChildController:@"MeVC" andTitle:LocalString(@"My Library", nil) andNorImage:@"icon_tab_2" andSelectedImage:@"icon_tab_2_sel" andIndex:2]
    ];
    self.viewControllers = viewControllers;
    self.selectedIndex = 0;
    
    [UITabBar appearance].translucent = NO;
    UITabBarAppearance *appearance = [self.tabBar.standardAppearance copy];
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor ht_colorWithHexString:@"#666666"]};
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    appearance.shadowColor = [UIColor whiteColor];
    [appearance configureWithTransparentBackground];
    appearance.backgroundColor = [UIColor ht_colorWithHexString:@"#191B21"];
    self.tabBar.standardAppearance = appearance;
    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = appearance;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ht_remind_add_member) name:@"NTFCTString_RemindAddFamilyMember" object:nil];
}

- (void)ht_remind_add_member {
    
    BOOL var_remind = [[NSUserDefaults standardUserDefaults] boolForKey:@"udf_remind_add_member"];
    if (var_remind) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"udf_remind_add_member"];
    
    //测试-待处理
//    HTRemindAddFamilyMemberView *view = [[HTRemindAddFamilyMemberView alloc] init];
//    view.block = ^(id  _Nullable data) {
//        // 添加家庭成员
//        HTFamilyViewController *vc = [[HTFamilyViewController alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [[HTWindowManage ht_getCurrentVC].navigationController pushViewController:vc animated:YES];
//    };
//    [view lgjeropj_show];
}

- (BaseNaviVC *)ht_addChildController:(NSString *)vcName andTitle:(NSString *)title andNorImage:(NSString *)norImage andSelectedImage:(NSString *)selectedImage andIndex:(NSInteger)index {
    BaseVC *childVc = [NSClassFromString(vcName) new];
    UIImage *norImageView = [UIImage imageNamed:norImage];
    norImageView = [norImageView imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.image = norImageView;
    UIImage *selImage = [UIImage imageNamed:selectedImage];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selImage;
    BaseNaviVC  *nav = [[BaseNaviVC alloc] initWithRootViewController:childVc];
    nav.index = index;
    nav.tabBarItem.title = title;
    
    return nav;
}

-(UIImage*)ht_imageWithColor:(UIColor*)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
