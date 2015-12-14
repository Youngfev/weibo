//
//  HWEmotionTabBar.h
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWEmotionTabBarButtonTypeRecent, // 最近
    HWEmotionTabBarButtonTypeDefault, // 默认
    HWEmotionTabBarButtonTypeEmoji, // emoji
    HWEmotionTabBarButtonTypeLxh, // 浪小花
} HWEmotionTabBarButtonType;

@class HWEmotionTabBar;

@protocol HWEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType;
@end

@interface HWEmotionTabBar : UIView
@property (nonatomic, weak) id<HWEmotionTabBarDelegate> delegate;
@end