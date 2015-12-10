//
//  HWTabBar.h
//  微博项目
//
//  Created by Youngfev on 15/12/6.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTabBar;
@protocol HWTabBarDelegate <NSObject,UITabBarDelegate>//先继承父类的代理
@optional
-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;

@end

@interface HWTabBar : UITabBar
@property (nonatomic,weak) id<HWTabBarDelegate>  delegate;

@end
