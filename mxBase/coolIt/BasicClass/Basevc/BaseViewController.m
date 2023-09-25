//
//  SHBaseViewController.m
 
//
//  Created by 李雪健 on 2022/4/12.
//

#import "BaseViewController.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    APP_DELEGATE.allowRotation = 0;//测试-待处理
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ht_colorWithHexString:@"#222222"], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    self.view.backgroundColor = [UIColor ht_colorWithHexString:@"#111111"];
    [self lgjeropj_resetNavigationBarShadowImage];
    [self lgjeropj_addLeftNavButtonWithBtnImage:@"icon_shleft" action:@selector(lgjeropj_backAction)];
}

- (void)lgjeropj_addLeftEmptyNavButton {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 40)]];
}

- (void)lgjeropj_resetNavigationBarShadowImage {
    UINavigationBarAppearance *navBar = [[UINavigationBarAppearance alloc] init];
    navBar.backgroundColor = [UIColor clearColor];
    navBar.backgroundEffect = nil;
    navBar.shadowImage = [[UIImage alloc] init];
    navBar.shadowColor = [UIColor clearColor];
    self.navigationController.navigationBar.scrollEdgeAppearance = navBar;
    self.navigationController.navigationBar.standardAppearance = navBar;
}

- (UIButton *)lgjeropj_addLeftNavButtonWithBtnImage:(NSString *)image action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 18, 18);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

#pragma mark- 导航栏事件
- (void)lgjeropj_backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

@end
