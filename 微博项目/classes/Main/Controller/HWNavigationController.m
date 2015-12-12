//
//  HWNavigationController.m
//  微博项目
//
//  Created by Youngfev on 15/12/5.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWNavigationController.h"

@interface HWNavigationController ()

@end

@implementation HWNavigationController
//设置一次
+ (void)initialize
{
//    UINavigationBar *navBar = [UINavigationBar appearance];//设置导航条
    UIBarButtonItem *item = [UIBarButtonItem appearance];//设置barButtonItem
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSMutableDictionary *disableAttributes = [NSMutableDictionary dictionary];
    disableAttributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableAttributes[NSFontAttributeName] = attributes[NSFontAttributeName];
    [item setTitleTextAttributes:disableAttributes forState:UIControlStateDisabled];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigatironbar_back_highlighted"];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
#warning 这里要用self，不是self.navigationController
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

@end
