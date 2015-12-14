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
#import "HWEmotion.h"
#import "MJExtension.h"

@interface HWEmotionKeyboard ()<HWEmotionTabBarDelegate>

@property (nonatomic,weak) UIView *listView;
@property (nonatomic,strong) HWEmotionListView *recentListView;
@property (nonatomic,strong) HWEmotionListView *defaultListView;
@property (nonatomic,strong) HWEmotionListView *emojiListView;
@property (nonatomic,strong) HWEmotionListView *lxhListView;
@property (nonatomic,weak) HWEmotionTabBar *tabBar;

@end

@implementation HWEmotionKeyboard

-(HWEmotionListView*)recentListView{
    if (_recentListView == nil) {
        _recentListView = [[HWEmotionListView alloc] init];
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
//        NSArray *defaultEmotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
//        
//        self.defaultListView.emotions = defaultEmotions;
        self.recentListView.backgroundColor = HWRandomColor;
    }
    return _recentListView;
}
-(HWEmotionListView*)defaultListView{
    if (_defaultListView == nil) {
        _defaultListView = [[HWEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        NSArray *defaultEmotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
        self.defaultListView.emotions = defaultEmotions;
        self.defaultListView.backgroundColor = HWRandomColor;
    }
    return _defaultListView;
}
-(HWEmotionListView*)emojiListView{
    if (_emojiListView == nil) {
        _emojiListView = [[HWEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        NSArray *emojiEmotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
        self.emojiListView.emotions = emojiEmotions;
        self.emojiListView.backgroundColor = HWRandomColor;
    }
    return _emojiListView;
}
-(HWEmotionListView*)lxhListView{
    if (_lxhListView == nil) {
        _lxhListView = [[HWEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        NSArray *lxhEmotions = [HWEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
        self.lxhListView.emotions = lxhEmotions;
        self.lxhListView.backgroundColor = HWRandomColor;
    }
    return _lxhListView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        HWEmotionTabBar *tabBar = [[HWEmotionTabBar alloc] init];
//        tabBar.backgroundColor = HWRandomColor;
        [self addSubview:tabBar];
        tabBar.delegate = self;
        self.tabBar = tabBar;
        
        UIView *listView = [[UIView alloc] init];
        listView.backgroundColor = HWRandomColor;
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
    
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
    
    UIView *childView = [self.listView.subviews lastObject];
    childView.frame = self.listView.bounds;
}
-(void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType
{
    
    [self.listView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (buttonType) {
        case HWEmotionTabBarButtonTypeRecent: // 最近
        {
            [self.listView addSubview:self.recentListView];
            break;
            
        }
            
        case HWEmotionTabBarButtonTypeDefault: // 默认
        {

            [self.listView addSubview:self.defaultListView];
            self.defaultListView.backgroundColor = HWRandomColor;
            break;
            
        }
            
        case HWEmotionTabBarButtonTypeEmoji: // Emoji
        {
            [self.listView addSubview:self.emojiListView];
            break;
            
        }
            
        case HWEmotionTabBarButtonTypeLxh: // Lxh
        {
            [self.listView addSubview:self.lxhListView];
            break;
    
        }
    }
    
    [self setNeedsLayout];
}

@end
