


#import "HTWebViewController.h"
#import <WebKit/WebKit.h>
#import <AuthenticationServices/AuthenticationServices.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "GoogleSignIn.h"
#import "HTCommonConfiguration.h"
#import "NSObject+Toast.h"
#import "HTManage.h"
#import "BSNetAPIClient.h"
#import "LKFPrivateFunction.h"

@interface HTWebViewController ()<WKUIDelegate,WKNavigationDelegate, WKScriptMessageHandler, ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, copy) NSString *var_link;
@property (nonatomic, strong) WKWebView *var_colorView;
@property (nonatomic, strong) UIProgressView *var_progressView;
@property (nonatomic, strong) UIView *var_noDataView;

@end

@implementation HTWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[self.var_colorView configuration].userContentController removeScriptMessageHandlerForName:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"iOS"]];
    [self.var_colorView.configuration.userContentController addScriptMessageHandler:self name:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"iOS"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 登录页不弹ad
    HTCommonConfiguration.lgjeropj_shared.BLOCK_stopAdBlock(YES);
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(ht_logoutAction:) name:@"NTFCTString_UserLogout" object:nil];

    [self lgjeropj_showLoadingForSuperView:self.view];
    self.var_link = [[NSUserDefaults standardUserDefaults] stringForKey:@"udf_login_h5"] ?: [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"https://www.h5login.work/"];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]] = self.source;
    if (HTManage.sharedInstance.model2.var_uid) {
        self.var_link = [self.var_link stringByAppendingString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user"]];
        [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"account_sh"] params:dictionary];
    } else {
        dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]] = @"2";
        [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"signup_sh"] params:dictionary];
    }
    [self lgjeropj_addSubView];
    [self lgjeropj_getUrl];
}

- (void)lgjeropj_addSubView
{
    self.view.backgroundColor = [UIColor ht_colorWithHexString:@"#1A1C21"];
    
    [self.view addSubview:self.var_progressView];
    [self.var_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(StatusBarHeight);
        make.height.mas_equalTo(1);
        make.left.right.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.var_colorView];
    [self.var_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_progressView.mas_bottom);
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.var_noDataView];
}

- (void)lgjeropj_showNodataView
{
    self.var_noDataView.hidden = NO;
}

- (void)lgjeropj_hidenNodataView
{
    self.var_noDataView.hidden = YES;
}

- (UIView *)var_noDataView
{
    if (!_var_noDataView) {
        _var_noDataView = [[UIView alloc] init];
        _var_noDataView.frame = CGRectMake(0, 0, ViewWidth, ViewHeight);
        _var_noDataView.backgroundColor = [UIColor ht_colorWithHexString:@"#111218"];
        _var_noDataView.hidden = YES;
        UIButton *var_setBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [var_setBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        var_setBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [var_setBtn setTintColor:[UIColor whiteColor]];
        [var_setBtn addTarget:self action:@selector(lgjeropj_backAction) forControlEvents:UIControlEventTouchUpInside];
        [_var_noDataView addSubview:var_setBtn];
        [var_setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(StatusBarHeight);
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(40);
        }];
        
        UIImageView *var_imageView = [[UIImageView alloc] init];
        var_imageView.image = [UIImage imageNamed:@"icon_warning"];
        [_var_noDataView addSubview:var_imageView];
        [var_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointMake(0, -60));
            make.size.mas_equalTo(40);
        }];
        UILabel *var_msgLable = [[UILabel alloc] init];
        var_msgLable.font = [UIFont systemFontOfSize:15];
        var_msgLable.textColor = [UIColor whiteColor];
        var_msgLable.textAlignment = NSTextAlignmentCenter;
        var_msgLable.numberOfLines = 0;
        var_msgLable.text = LocalString(@"Network error, retry", nil);
        [_var_noDataView addSubview:var_msgLable];
        [var_msgLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(var_imageView.mas_bottom).offset(40);
            make.left.mas_equalTo(60);
            make.right.mas_equalTo(-60);
        }];
        //
        UIButton *var_refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [var_refreshButton setTitle:LocalString(@"Refresh", nil) forState:UIControlStateNormal];
        var_refreshButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [var_refreshButton setTitleColor:[UIColor ht_colorWithHexString:@"#3CDEF4"] forState:UIControlStateNormal];
        [var_refreshButton addTarget:self action:@selector(ht_refreshButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_var_noDataView addSubview:var_refreshButton];
        var_refreshButton.layer.cornerRadius = 4;
        var_refreshButton.layer.masksToBounds = YES;
        var_refreshButton.layer.borderWidth = 1;
        var_refreshButton.layer.borderColor = [[UIColor ht_colorWithHexString:@"#3CDEF4"] CGColor];
        [var_refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(var_msgLable.mas_bottom).offset(40);
            make.size.mas_equalTo(CGSizeMake(75, 40));
            make.centerX.mas_equalTo(0);
        }];
    }
    return _var_noDataView;
}

- (void)ht_refreshButtonAction
{
    [self lgjeropj_getUrl];
}

- (UIProgressView *)var_progressView
{
    if (!_var_progressView) {
        _var_progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
        _var_progressView.progressTintColor = [UIColor ht_colorWithHexString:@"#3CDEF4"];
        _var_progressView.trackTintColor = [UIColor clearColor];
        _var_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }
    return _var_progressView;
}

- (WKWebView *)var_colorView
{
    if (!_var_colorView) {
        WKWebViewConfiguration *var_configuration = [[WKWebViewConfiguration alloc] init];
        var_configuration.preferences.javaScriptEnabled = YES;
        _var_colorView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, 0,0) configuration:var_configuration];
        _var_colorView.navigationDelegate = self;
        _var_colorView.UIDelegate = self;
        _var_colorView.backgroundColor = [UIColor clearColor];
        _var_colorView.opaque = NO;
        _var_colorView.scrollView.bounces = NO;
        _var_colorView.scrollView.showsHorizontalScrollIndicator = NO;
        _var_colorView.scrollView.showsVerticalScrollIndicator = NO;
        _var_colorView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        //添加'iOS'键,来监听web端的消息
        [_var_colorView.configuration.userContentController addScriptMessageHandler:self name:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"iOS"]];
        //监听标题和加载进度
        NSKeyValueObservingOptions var_options = NSKeyValueObservingOptionNew;
        [_var_colorView addObserver:self forKeyPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"] options:var_options context:nil];
        [_var_colorView addObserver:self forKeyPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"estimatedProgress"] options:var_options context:nil];
    }
    return _var_colorView;
}

//get请求
- (void)lgjeropj_getUrl {
    NSDictionary *var_commonDict = [BSNetAPIClient.sharedInstance lgjeropj_apiParams:@{}];
    NSMutableDictionary *var_parmaDict = [NSMutableDictionary dictionaryWithDictionary:var_commonDict];
    if ([var_parmaDict.allKeys containsObject:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"version"]]) {
        [var_parmaDict removeObjectForKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"version"]];
    }
    //0:默认样式(带返回按钮,不带文案) | 1:强制登录(不带返回按钮,文案:Login to Begin Your Premium Journey)  | 2:非强制登录(带返回按钮,文案:Login for Premium Status).web根据该字段改变样式
    [var_parmaDict setObject:self.var_force ?: @"0" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"force"]];
    NSString *var_jsonString = [var_parmaDict yy_modelToJSONString];
    NSString *var_webUrlString = [NSString stringWithFormat:@"%@?%@%@",self.var_link, [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"param="], var_jsonString];
    var_webUrlString = [var_webUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:var_webUrlString];
    NSURLRequest *var_request = [NSURLRequest requestWithURL:url];
    [self.var_colorView loadRequest:var_request];
}

//监听
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void*)context {
    if ([keyPath isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"estimatedProgress"]]) {
        self.var_progressView.progress = self.var_colorView.estimatedProgress;
        if (self.var_progressView.progress == 1) {
            __weak typeof(self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.var_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finished) {
                weakSelf.var_progressView.hidden = YES;
            }];
        }
    }  else if ([keyPath isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]]) {
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)ht_logoutAction:(NSNotification*)no{
    [self lgjeropj_quitWebpage];
}

- (void)lgjeropj_backAction {
    [self lgjeropj_quitWebpage];
}

- (void)lgjeropj_quitWebpage
{
    [self.navigationController popViewControllerAnimated:YES];
}

//禁止左右弹动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - HTWidth) / 2, scrollView.contentOffset.y);
}

//页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.var_progressView.hidden = NO;
    self.var_progressView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [self.view bringSubviewToFront:self.var_progressView];
}

//页面加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    self.var_progressView.hidden = YES;
    [self lgjeropj_hidenNodataView];
    [self lgjeropj_hideLoadingForSuperView:self.view];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if (error) {
        [self lgjeropj_showNodataView];
    }
    [self lgjeropj_hideLoadingForSuperView:self.view];
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.var_progressView.hidden = YES;
}

#pragma mark --WKScriptMessageHandler-监听来自web端发过来的消息
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"iOS"]]) {
        NSString *var_jsonString = message.body;
        NSDictionary *var_dict = [NSJSONSerialization JSONObjectWithData:[var_jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if ([var_dict.allKeys containsObject:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]])
        {
            NSInteger var_tag = [var_dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]] intValue];
            [self lgjeropj_webTellLogic:var_tag andDict:var_dict];
        }
    }
}

//具体的业务
- (void)lgjeropj_webTellLogic:(NSInteger)var_tag andDict:(NSDictionary *)var_dict
{
    switch (var_tag) {
        case 1:
        {
            //谷歌登录
            [self lgjeropj_loginByGoogle];
            [self lgjeropj_htMethodClickMaidian:@"7" andType:@"2" andResult:@"0"];
            break;
        }
        case 2:
        {
            //facebook登录
            [self lgjeropj_loginByFacebook];
            [self lgjeropj_htMethodClickMaidian:@"8" andType:@"2" andResult:@"0"];
            break;
        }
        case 3:
        {
            //苹果登录
            [self lgjeropj_appleLogin];
            [self lgjeropj_htMethodClickMaidian:@"15" andType:@"2" andResult:@"0"];
            break;
        }
        case 5:
        {
            //登录注册完毕
            [self lgjeropj_saveUserDataWithDict:var_dict];
            //埋点
            NSString *var_type = [NSString stringWithFormat:@"%@", var_dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]]];
            NSString *var_source = [NSString stringWithFormat:@"%@", var_dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]]];
            if (var_source.integerValue == 1) {
                [self lgjeropj_htMethodClickMaidian:@"11" andType:var_type andResult:@"1"];
            } else if (var_source.integerValue == 2) {
                [self lgjeropj_htMethodClickMaidian:@"12" andType:var_type andResult:@"1"];
            } else if (var_source.integerValue == 3) {
                [self lgjeropj_htMethodResultMaidian:@"3"];
            } else if (var_source.integerValue == 4) {
                [self lgjeropj_htMethodResultMaidian:@"2"];
            } else if (var_source.integerValue == 5) {
                [self lgjeropj_htMethodResultMaidian:@"1"];
            }
            break;
        }
        case 6:
        {
            //获取用户信息完毕
            [self lgjeropj_saveUserDataWithDict:var_dict];
            [self lgjeropj_quitWebpage];
            break;
        }
        case 9:
        {
            //退出登录
            [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"account_cl"] params:@{[LKFPrivateFunction htMethodStringToInt:@"kid"]:@"6"}];
            HTCommonConfiguration.lgjeropj_shared.BLOCK_toLogoutBlock();
            break;
        }
        case 10:
        {
            //更新了用户信息
            [self lgjeropj_saveUserDataWithDict:var_dict];
            [self lgjeropj_quitWebpage];
            break;
        }
        case 11:
        {
            //弃用
            //user页面返回按钮,原生给web发消息,触发web判断逻辑
            break;
        }
        case 12:
        {
            //放弃修改用户信息,点击弹窗里的cancel或者没有信息变更的情况下触发
            [self lgjeropj_quitWebpage];
            break;
        }
        case 13:
        {
            //打开terms of service
            HTCommonConfiguration.lgjeropj_shared.BLOCK_toWebUrlBlock([LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"user"]);
            break;
        }
        case 14:
        {
            //打开privacy policy
            HTCommonConfiguration.lgjeropj_shared.BLOCK_toWebUrlBlock([LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"protocol"]);
            break;
        }
        case 16:
        {
            //关闭web,返回原生页面
            [self lgjeropj_quitWebpage];
            [self lgjeropj_htMethodClickMaidian:@"1" andType:@"0" andResult:@"0"];
            break;
        }
        case 17:
        {
            NSString *var_type = [NSString stringWithFormat:@"%@", var_dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]]];
            NSString *var_source = [NSString stringWithFormat:@"%@", var_dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]]];
            if (var_source.integerValue == 1) {
                [self lgjeropj_htMethodClickMaidian:@"11" andType:var_type andResult:@"0"];
            } else if (var_source.integerValue == 2) {
                [self lgjeropj_htMethodClickMaidian:@"12" andType:var_type andResult:@"0"];
            }
        }
        default:
            break;
    }
}

//谷歌登录
- (void)lgjeropj_loginByGoogle
{
    [GIDSignIn.sharedInstance signInWithPresentingViewController:self completion:^(GIDSignInResult *signInResult, NSError *error)
     {
        if (error) {
            NSMutableDictionary *var_dict = [NSMutableDictionary new];
            [var_dict setObject:@"7" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]];
            [var_dict setObject:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Failed"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]];
            NSString *var_errorStr = [NSString stringWithFormat:@"%ld-%@",(long)error.code,error.localizedDescription];
            [var_dict setObject:var_errorStr forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msgDetails"]];
            NSString *var_jSting = [var_dict yy_modelToJSONString];
            [self lgjeropj_jsInsertWithJsonString:var_jSting];
        } else {
            NSString *tp_face = @"";
            if (signInResult.user.profile.hasImage) {
                tp_face = [signInResult.user.profile imageURLWithDimension:120].absoluteString;
            }
            NSDictionary *params = @{
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]: @"2",
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"thridparty_g"]: @"1",
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_tpid"]: [NSString stringWithFormat:@"%@", signInResult.user.userID],
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_name"]: [NSString stringWithFormat:@"%@", signInResult.user.profile.name],
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_face"]: tp_face,
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"email"]: [NSString stringWithFormat:@"%@", signInResult.user.profile.email]
            };
            NSMutableDictionary *var_dict = [NSMutableDictionary dictionaryWithDictionary:params];
            [var_dict setObject:@"1" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]];
            NSString *var_jSting = [var_dict yy_modelToJSONString];
            [self lgjeropj_jsInsertWithJsonString:var_jSting];
        }
    }];
}

//facebook登录
- (void)lgjeropj_loginByFacebook
{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithPermissions:@[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"public_profile"], [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"email"]] fromViewController:self handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSMutableDictionary *var_dict = [NSMutableDictionary new];
            [var_dict setObject:@"8" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]];
            [var_dict setObject:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Failed"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]];
            NSString *var_errorStr = [NSString stringWithFormat:@"%ld-%@",(long)error.code,error.localizedDescription];
            [var_dict setObject:var_errorStr forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msgDetails"]];
            NSString *var_jSting = [var_dict yy_modelToJSONString];
            [self lgjeropj_jsInsertWithJsonString:var_jSting];

        } else if (result.isCancelled) {
            NSMutableDictionary *var_dict = [NSMutableDictionary new];
            [var_dict setObject:@"8" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]];
            [var_dict setObject:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Cancelled"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]];
            [var_dict setObject:@"" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msgDetails"]];
            NSString *var_jSting = [var_dict yy_modelToJSONString];
            [self lgjeropj_jsInsertWithJsonString:var_jSting];
        } else {
            FBSDKProfile *profile = FBSDKProfile.currentProfile;
            NSString *userId = result.token.userID;
            NSString *facebookToken =  result.token.tokenString;
            NSDictionary *params = @{
                @"type": @"2",
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"thridparty_g"]: @"2",
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_tpid"]: [NSString stringWithFormat:@"%@", userId],
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_name"]: [NSString stringWithFormat:@"%@", profile.name],
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_face"]: [NSString stringWithFormat:@"%@", profile.imageURL.absoluteString],
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"email"]: [NSString stringWithFormat:@"%@", profile.email],
                [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"identityToken"]: [NSString stringWithFormat:@"%@", facebookToken]
            };
            NSMutableDictionary *var_dict = [NSMutableDictionary dictionaryWithDictionary:params];
            [var_dict setObject:@"2" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]];
            NSString *var_jSting = [var_dict yy_modelToJSONString];
            [self lgjeropj_jsInsertWithJsonString:var_jSting];
        }
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    HTCommonConfiguration.lgjeropj_shared.BLOCK_stopAdBlock(NO);
    //释放
    [self lgjeropj_hideLoadingForSuperView:self.view];
    [[self.var_colorView configuration].userContentController removeScriptMessageHandlerForName:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"iOS"]];
}

- (void)dealloc {
    [self.var_colorView removeObserver:self forKeyPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"title"]];
    [self.var_colorView removeObserver:self forKeyPath:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"estimatedProgress"]];
}

#pragma mark - appleLogin
- (void)lgjeropj_appleLogin {
    ASAuthorizationAppleIDProvider *var_appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
    ASAuthorizationAppleIDRequest *var_request = var_appleIDProvider.createRequest;
    var_request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
    ASAuthorizationController *var_controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[var_request]];
    var_controller.delegate = self;
    var_controller.presentationContextProvider = self;
    [var_controller performRequests];
}

//授权成功
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization  NS_SWIFT_NAME(authorizationController(controller:didCompleteWithAuthorization:)) API_AVAILABLE(ios(13.0))
{
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *var_appleIDCredential = (ASAuthorizationAppleIDCredential *)authorization.credential;
        [self lgjeropj_actionLoginWithAppleData:var_appleIDCredential];
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]) {
        ASPasswordCredential *var_passwordCredential = (ASPasswordCredential *)authorization.credential;
        [self lgjeropj_actionLoginWithAppleData:var_passwordCredential];
    }
}

//授权失败
- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error  NS_SWIFT_NAME(authorizationController(controller:didCompleteWithError:)) API_AVAILABLE(ios(13.0)) {
    
    NSMutableDictionary *var_dict = [NSMutableDictionary new];
    [var_dict setObject:@"4" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]];
    [var_dict setObject:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"Authorization failed"] forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msg"]];
    NSString *var_errorStr = [NSString stringWithFormat:@"%ld-%@",(long)error.code,error.localizedDescription];
    [var_dict setObject:var_errorStr forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"msgDetails"]];
    NSString *var_jSting = [var_dict yy_modelToJSONString];
    [self lgjeropj_jsInsertWithJsonString:var_jSting];
}

- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return HTWindow;
}

- (void)lgjeropj_actionLoginWithAppleData:(id)data
{
    NSMutableDictionary *var_dict = [NSMutableDictionary new];
    if ([data isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        ASAuthorizationAppleIDCredential *var_appleIDCredential = (ASAuthorizationAppleIDCredential *)data;
        [var_dict setObject:var_appleIDCredential.user forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_tpid"]];//唯一标识
        [var_dict setObject:var_appleIDCredential.email?var_appleIDCredential.email:var_appleIDCredential.user forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"email"]];
        
        NSMutableString *var_mutableString = [NSMutableString string];
        [var_mutableString appendString:var_appleIDCredential.fullName.givenName?:@""];
        [var_mutableString appendString:var_appleIDCredential.fullName.middleName?:@""];
        [var_mutableString appendString:var_appleIDCredential.fullName.familyName?:@""];
        [var_dict setObject:var_mutableString forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_name"]];
    } else if ([data isKindOfClass:[ASPasswordCredential class]]) {
        ASPasswordCredential *passwordCredential = (ASPasswordCredential *)data;
        [var_dict setObject:passwordCredential.user forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_tpid"]];
        [var_dict setObject:passwordCredential.user forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"email"]];
        [var_dict setObject:@"" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_name"]];
    }
    [var_dict setObject:@"2" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]];
    [var_dict setObject:@"" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"tp_face"]];
    [var_dict setObject:@"3" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"thridparty_g"]];//1 谷歌登录 2Facebook登录  3苹果登录 0:原生
    [var_dict setObject:@"3" forKey:[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"loginType"]];
    NSString *var_jSting = [var_dict yy_modelToJSONString];
    [self lgjeropj_jsInsertWithJsonString:var_jSting];
}

//js注入
- (void)lgjeropj_jsInsertWithJsonString:(NSString *)jsonSting
{
    NSString *var_evaluateJavaScript = [NSString stringWithFormat:@"%@('%@')", [LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"getNativeParam"], jsonSting];
    //执行一段JS
    [self.var_colorView evaluateJavaScript:var_evaluateJavaScript completionHandler:^(id _Nullable object, NSError * _Nullable error) {
        if (error != nil) {
        } else {

        }
    }];
}

- (void)ht_clearCache {
    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];;
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
    }];
}

- (void)didReceiveMemoryWarning{
    [self ht_clearCache];
}

- (ENUM_ControllerNaviType)ht_customNaviType{
    return ENUM_ControllerNaviTypeHide;
}
//存值
- (void)lgjeropj_saveUserDataWithDict:(NSDictionary *)dict
{
    UserModel *loginUser = [UserModel yy_modelWithJSON:dict[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"data"]]];
    HTManage.sharedInstance.model2 = loginUser;
    [self lgjeropj_showLoadingForSuperView:self.view];
    [HTManage.sharedInstance ht_getUserInfoWithUid:loginUser.var_uid andBlock:^(UserModel * _Nullable var_userModel) {
        if ([var_userModel isKindOfClass:UserModel.class]) {
            HTManage.sharedInstance.model2 = var_userModel;
            [HTManage.sharedInstance ht_updateVipWithBlock:^(PayModel * _Nullable var_payModel) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self lgjeropj_hideLoadingForSuperView:self.view];
                });
            } source:@"4"];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self lgjeropj_hideLoadingForSuperView:self.view];
            });
        }
    }];
}

//埋点
- (void)lgjeropj_htMethodClickMaidian:(NSString *)htVarKid andType:(NSString *)htVarType andResult:(NSString *)htVarResult {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"result"]] = htVarResult;
    dictionary[[LKFPrivateFunction htMethodStringToInt:@"kid"]] = htVarKid;
    dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]] = self.source;
    dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]] = htVarType;
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"signup_cl"] params:dictionary];
}

- (void)lgjeropj_htMethodResultMaidian:(NSString *)htVarType {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"result"]] = @"1";
    dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"type"]] = htVarType;
    dictionary[[LKFPrivateFunction htMethodAsciiToStringButNotMulti:@"source"]] = self.source;
    [HTPointRequest.sharedInstance ht_point:[LKFPrivateFunction htMethodStringToInt:@"third_party_result"] params:dictionary];
}

@end
