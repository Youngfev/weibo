//
//  HWEmotionKeyboard.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionTabBar.h"

@interface HWEmotionKeyboard ()<HWEmotionTabBarDelegate>

@property (nonatomic,weak) HWEmotionListView *listView;
@property (nonatomic,weak) HWEmotionTabBar *tabBar;

@end

@implementation HWEmotionKeyboard

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        HWEmotionTabBar *tabBar = [[HWEmotionTabBar alloc] init];
//        tabBar.backgroundColor = HWRandomColor;
        [self addSubview:tabBar];
        tabBar.delegate = self;
        self.tabBar = tabBar;
        
        HWEmotionListView *listView = [[HWEmotionListView alloc] init];
//        listView.backgroundColor = HWRandomColor;
        [self addSubview:listView];
        self.listView = listView;
        

    }
    return self;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
//    HWLog(@"%f",self.tabBar.y);
    
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
}
-(void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType
{
    switch (buttonType) {
        case HWEmotionTabBarButtonTypeRecent: // 最近
            HWLog(@"最近");
            break;
            
        case HWEmotionTabBarButtonTypeDefault: // 默认
            HWLog(@"默认");
            break;
            
        case HWEmotionTabBarButtonTypeEmoji: // Emoji
            HWLog(@"Emoji");
            break;
            
        case HWEmotionTabBarButtonTypeLxh: // Lxh
            HWLog(@"Lxh");
            break;
    }
}

@end
