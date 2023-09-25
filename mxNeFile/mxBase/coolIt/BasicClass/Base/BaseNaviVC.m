//
//  BaseNaviVC.m
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import "BaseNaviVC.h"
#import "BaseVC.h"

@interface BaseNaviVC ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong)  UIColor *bgColor;
@end

@implementation BaseNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgColor = [UIColor ht_colorWithHexString:@"#1A1C21"];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        barApp.backgroundEffect = nil;
        barApp.backgroundColor = self.bgColor;
        barApp.shadowColor = nil;
        barApp.shadowImage = [[UIImage alloc] init];
        barApp.titleTextAttributes = @{
            NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
            NSForegroundColorAttributeName:UIColor.whiteColor
        };
        self.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationBar.standardAppearance = barApp;
    } else {
        self.navigationBar.shadowImage = [[UIImage alloc] init];
        self.navigationBar.barTintColor = self.bgColor;
        self.navigationBar.titleTextAttributes = @{
            NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
            NSForegroundColorAttributeName:UIColor.whiteColor
        };
    }
    self.navigationBar.translucent = NO;
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL noNav = NO;
    if ([viewController respondsToSelector:@selector(ht_customNaviType)]) {
        BaseVC *VC = (BaseVC*)viewController;
        if ([VC ht_customNaviType] == ENUM_ControllerNaviTypeHide) {
            noNav = YES;
        } else if ([VC ht_customNaviType] == ENUM_ControllerNaviTypeNormal) {
            UIColor *mainColor = self.bgColor;
            if (@available(iOS 15.0, *)) {
                navigationController.navigationBar.scrollEdgeAppearance.backgroundColor = mainColor;
                navigationController.navigationBar.standardAppearance.backgroundColor = mainColor;
            } else {
                navigationController.navigationBar.barTintColor = mainColor;
                navigationController.navigationBar.backgroundColor = mainColor;
            }
        }
    }
    navigationController.navigationBar.translucent = NO;
    navigationController.interactivePopGestureRecognizer.delegate = self;
    [navigationController setNavigationBarHidden:noNav animated:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}


@end
