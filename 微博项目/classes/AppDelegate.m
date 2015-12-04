//
//  AppDelegate.m
//  微博项目
//
//  Created by Youngfev on 15/12/4.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "AppDelegate.h"
#import "HWHomeViewController.h"
#import "HWMessageCenterViewController.h"
#import "HWDiscoverViewController.h"
#import "HWProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    UITabBarController *tabBarVC = [[UITabBarController alloc]init];
    self.window.rootViewController = tabBarVC;
    
    HWHomeViewController *vc1 = [[HWHomeViewController alloc] init];
    [self addChlidVC:vc1 withTitle:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    HWMessageCenterViewController *vc2 = [[HWMessageCenterViewController alloc] init];
    [self addChlidVC:vc2 withTitle:@"消息" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    HWDiscoverViewController *vc3 = [[HWDiscoverViewController alloc] init];
    [self addChlidVC:vc3 withTitle:@"发现" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    HWProfileViewController *vc4 = [[HWProfileViewController alloc] init];
    [self addChlidVC:vc4 withTitle:@"我" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
//tabBarVC.viewControllers = @[vc1,vc2,vc3,vc4];//添加子控制器
    [tabBarVC addChildViewController:vc1];//添加子控制器
    [tabBarVC addChildViewController:vc2];
    [tabBarVC addChildViewController:vc3];
    [tabBarVC addChildViewController:vc4];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)addChlidVC:(UIViewController*)vc withTitle:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage
{
//    UIViewController *vc = [[UIViewController alloc]init];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    [vc.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttributes = [NSMutableDictionary dictionary];
    selectedTextAttributes[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    
    vc.view.backgroundColor = HWRandomColor;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
