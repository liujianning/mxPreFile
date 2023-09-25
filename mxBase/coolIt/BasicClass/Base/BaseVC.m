//
//  BaseVC.m
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import "BaseVC.h"
#import "AdSubAlert.h"
@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self ht_getWillData];
}

- (void)ht_customBack:(NSString*)name {
    [self ht_customBack:name andForce:NO];
}

- (void)ht_customBack:(NSString*)name andForce:(BOOL)force{
    if (self.navigationController.viewControllers.count <= 1 && !force) return;
    self.navigationItem.hidesBackButton = YES;
    UIImage* backImg = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:backImg style:UIBarButtonItemStylePlain target:self action:@selector(ht_backAction)];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)ht_backAction{
    NSArray *viewControllers = [self.navigationController viewControllers];
    if (1 <= viewControllers.count && 0 < [viewControllers indexOfObject:self]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    self.navigationController.navigationBar.translucent = NO;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ht_colorWithHexString:@"#111218"];
    [self ht_customBack:@"icon_back"];
    [self ht_setupNavigation];
    [self ht_setupViews];
    [self ht_bindViewModel];
    [self ht_getNewData];
}

- (void)ht_bottomView{
    self.view.backgroundColor = [UIColor ht_colorWithHexString:@"#000000" andAlpha:0.3];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
    }];
}

- (void)ht_scrollView{
    self.var_scrollView = [[UIScrollView alloc] init];
    self.var_scrollView.showsVerticalScrollIndicator = NO;
    self.var_scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.var_scrollView.showsHorizontalScrollIndicator = NO;
    self.var_scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.view addSubview:self.var_scrollView];
    [self.var_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    self.contenView = [[UIView alloc] init];;
    [self.var_scrollView addSubview:self.contenView];
    [self.contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-HTBottomSafeHeight);
        make.width.equalTo(self.var_scrollView.mas_width);
    }];
}

- (void)ht_getWillData{
    
}

- (void)ht_setupViews{
    
}

- (void)ht_bindViewModel{
    
}

- (void)ht_getNewData{
    
}

- (void)ht_setupNavigation{
    
}

- (ENUM_ControllerNaviType)ht_customNaviType{
    return ENUM_ControllerNaviTypeNormal;;
}

- (void)dealloc{
    NSLog(@"%@ dealloc",NSStringFromClass(self.class));
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    [self ht_updateViewConstraints];
}

- (void)ht_updateViewConstraints {
    
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor ht_colorWithHexString:@"#000000"];
    }
    return _bottomView;
}

- (UIStackView *)var_stackView{
    if (!_var_stackView) {
        _var_stackView = [[UIStackView alloc] init];
        _var_stackView.axis = UILayoutConstraintAxisVertical;
    }
    return _var_stackView;
}

- (void)ht_showGoSub{
  
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (NSString*)ht_pointType{
    return @"0";
}

- (NSString *)source{
    if (!_source) {
        _source = @"0";
    }
    return _source;
}

- (NSString *)var_op_type{
    _var_op_type = [NSUserDefaults.standardUserDefaults objectForKey:@"udf_op_type"] ? : @"1";
    return _var_op_type;
}

@end

