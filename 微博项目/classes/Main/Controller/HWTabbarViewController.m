//
//  HWTabbarViewController.m
//  微博项目
//
//  Created by Youngfev on 15/12/4.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWTabbarViewController.h"
#import "HWHomeViewController.h"
#import "HWMessageCenterViewController.h"
#import "HWDiscoverViewController.h"
#import "HWProfileViewController.h"
#import "HWNavigationController.h"
#import "HWTabBar.h"
#import "HWComposeController.h"

@interface HWTabbarViewController ()<HWTabBarDelegate>
@end

@implementation HWTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HWHomeViewController *vc1 = [[HWHomeViewController alloc] init];
    [self addChlidVC:vc1 withTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    HWMessageCenterViewController *vc2 = [[HWMessageCenterViewController alloc] init];
    [self addChlidVC:vc2 withTitle:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    HWDiscoverViewController *vc3 = [[HWDiscoverViewController alloc] init];
    [self addChlidVC:vc3 withTitle:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    HWProfileViewController *vc4 = [[HWProfileViewController alloc] init];
    [self addChlidVC:vc4 withTitle:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    //更换系统的tabbar KVC 更改只读的属性
//    self.tabBar
    [self setValue:[[HWTabBar alloc]init] forKey:@"tabBar"];
    

}

-(void)addChlidVC:(UIViewController*)vc withTitle:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
    //    UIViewController *vc = [[UIViewController alloc]init];
//    vc.tabBarItem.title = title;
//    vc.navigationItem.title = title;
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    [vc.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttributes = [NSMutableDictionary dictionary];
    selectedTextAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    
//    vc.view.backgroundColor = HWRandomColor;
    HWNavigationController *nav = [[HWNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar
{
    HWComposeController *composeVC = [[HWComposeController alloc] init];
//    composeVC.view.backgroundColor = [UIColor whiteColor];
    HWNavigationController *nav = [[HWNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
