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

@interface HWEmotionKeyboard ()

@property (nonatomic,weak) HWEmotionListView *listView;
@property (nonatomic,weak) HWEmotionTabBar *tabbar;

@end

@implementation HWEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        HWEmotionListView *listView = [[HWEmotionListView alloc] init];
        [self addSubview:listView];
        listView.backgroundColor = HWRandomColor;
        self.listView = listView;
        
        HWEmotionTabBar *tabbar = [[HWEmotionTabBar alloc] init];
        [self addSubview:tabbar];
//        tabbar.backgroundColor = HWRandomColor;
//        tabbar.delegate = self;
        self.tabbar = tabbar;
    }
    return self;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabbar.width = self.width;
    self.tabbar.height = 37;
    self.tabbar.y = 0;
    self.tabbar.y = self.height - self.tabbar.height;
    
    self.listView.x = self.listView.y = 0;
    self.width = self.width;
    self.height = self.tabbar.y;
}
//-(void)emotionTabbar:(HWEmotionTabbar *)tabBar didSelectButton:(HWEmotionTabbarButtonType)buttonType
//{
//    switch (buttonType) {
//        case HWEmotionTabbarButtonTypeRecent: // 最近
//            HWLog(@"最近");
//            break;
//            
//        case HWEmotionTabbarButtonTypeDefault: // 默认
//            HWLog(@"默认");
//            break;
//            
//        case HWEmotionTabbarButtonTypeEmoji: // Emoji
//            HWLog(@"Emoji");
//            break;
//            
//        case HWEmotionTabbarButtonTypeLxh: // Lxh
//            HWLog(@"Lxh");
//            break;
//    }
//}

@end
