//
//  SHNavigationController.m
 
//
//  Created by 李雪健 on 2022/4/12.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController () <UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    [super popViewControllerAnimated:animated];
    UIViewController *viewController = [self.childViewControllers lastObject];
    if (self.childViewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    } else {
        self.tabBarController.tabBar.hidden = NO;
    }
    return viewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end
