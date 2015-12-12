//
//  HWComposeController.m
//  微博项目
//
//  Created by Youngfev on 15/12/11.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWComposeController.h"
#import "HWAccountTool.h"
#import "HWTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface HWComposeController ()
@property (nonatomic,weak) HWTextView *textView;
@end

@implementation HWComposeController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    
    [self setUpTextView];

}

-(void)setUpTextView
{
    HWTextView *textView = [[HWTextView alloc] init];
    
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享新鲜事...";
    
    [self.view addSubview:textView];
    self.textView = textView;
}

-(void)setUpNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
#warning enabled = NO;颜色改不了？？？
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    //    titleView.backgroundColor = [UIColor redColor];
    titleView.textAlignment = UITextAlignmentCenter;
    titleView.numberOfLines = 0;
    
    NSString *str = [NSString stringWithFormat:@"发微博\n%@",[HWAccountTool account].name];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, [HWAccountTool account].name.length)];
    
    titleView.attributedText = attrStr;
    self.navigationItem.titleView = titleView;
}

-(void)send
{
    
    [MBProgressHUD showMessage:@"正在发送"];
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    HWAccount *account = [HWAccountTool account];
    parameters[@"access_token"] = account.access_token;
    parameters[@"status"] = self.textView.text;
    
    
    //发送请求
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        HWLog(@"success");
        [self dismissViewControllerAnimated:YES completion:nil];
        [MBProgressHUD showMessage:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"发送失败"];
        HWLog(@"%@",error);
    }];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
