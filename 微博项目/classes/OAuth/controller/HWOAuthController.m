//
//  HWOAuthController.m
//  微博项目
//
//  Created by Youngfev on 15/12/6.
//  Copyright © 2015年 Youngfev. All rights reserved.
//


/**
 client_id=3199272345 (AppKey)
 App Secret：ff520801c25170e4078b6f2902eb7474
 redirect_uri=https://api.weibo.com/oauth2/default.html
 
 "access_token" = "2.00oKu2tBrsoVUDeda8a22cceqzG3KD";
 
 
 */

#import "HWOAuthController.h"
#import "AFNetworking.h"
#import "HWTabbarViewController.h"
#import "HWNewFeatureController.h"
#import "HWAccount.h"
#import "MBProgressHUD+MJ.h"
#import "HWAccountTool.h"

@interface HWOAuthController ()<UIWebViewDelegate>

@end

@implementation HWOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3199272345&redirect_uri=https://api.weibo.com/oauth2/default.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];//webView
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载"];
//    HWLog(@"webViewDidStartLoad");
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
//    HWLog(@"webViewDidFinishLoad");
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"code="];
    if (range.length) {
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        
        /**
         换取一个access Token
         
         必选	类型及范围	说明
         client_id	true	string	申请应用时分配的AppKey。
         client_secret	true	string	申请应用时分配的AppSecret。
         grant_type	true	string	请求的类型，填写authorization_code
         
         grant_type为authorization_code时
         必选	类型及范围	说明
         code	true	string	调用authorize获得的code值。
         redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
         
         
         https://api.weibo.com/oauth2/access_token
         */
        [self accessTokenWithCode:code];
        
        return NO;
    }
    return YES;
}


-(void)accessTokenWithCode:(NSString *)code
{
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    AFJSONResponseSerializer
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"3199272345";
    parameters[@"client_secret"] = @"ff520801c25170e4078b6f2902eb7474";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"https://api.weibo.com/oauth2/default.html";
    //发送请求
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       
        HWAccount *account = [HWAccount accountWithDict:responseObject];
        [HWAccountTool saveAccount:account];
        
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        NSString *key = @"CFBundleVersion";
        NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];//从沙盒中读取info.plist中的版本，专用于读取info.plist
        NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];//从沙盒中读取版本号
        if ([lastVersion isEqualToString:currentVersion]) {
            HWTabbarViewController *tabBarVC = [[HWTabbarViewController alloc]init];//
            window.rootViewController = tabBarVC;
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];//将版本号存储到沙盒
            [[NSUserDefaults standardUserDefaults] synchronize];//立即存储进沙盒
            HWNewFeatureController *newFeature = [[HWNewFeatureController alloc] init];
            window.rootViewController = newFeature;
        }
        [MBProgressHUD hideHUD];
//        HWLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        HWLog(@"%@",error);
    }];
}

@end
