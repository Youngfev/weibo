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
 */

#import "HWOAuthController.h"

@interface HWOAuthController ()

@end

@implementation HWOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3199272345&redirect_uri=https://api.weibo.com/oauth2/default.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
