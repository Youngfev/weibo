//
//  HWComposeController.m
//  微博项目
//
//  Created by Youngfev on 15/12/11.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWComposeController.h"
#import "HWAccountTool.h"

@interface HWComposeController ()

@end

@implementation HWComposeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
#warning enabled = NO;颜色改不了？？？
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    NSString *name = [HWAccountTool account].name;
    self.navigationItem.title = name;

}


-(void)send
{
    
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
