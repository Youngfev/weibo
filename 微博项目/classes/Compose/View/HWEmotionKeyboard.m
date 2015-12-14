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

@property (nonatomic,weak) HWEmotionListView *showingListView;
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
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
//        HWEmotionListView *showingListView = [[HWEmotionListView alloc] init];
//        showingListView.backgroundColor = HWRandomColor;
//        [self addSubview:showingListView];
//        self.showingListView = showingListView;
        

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
    
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    
//    UIView *childView = [self.showingListView.subviews lastObject];
//    childView.frame = self.showingListView.bounds;
}
-(void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType
{
    
//    [self.showingListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
        case HWEmotionTabBarButtonTypeRecent: // 最近
        {
            [self addSubview:self.recentListView];
            break;
        }
            
        case HWEmotionTabBarButtonTypeDefault: // 默认
        {

            [self addSubview:self.defaultListView];
            break;
        }
            
        case HWEmotionTabBarButtonTypeEmoji: // Emoji
        {
            [self addSubview:self.emojiListView];
            break;
        }
            
        case HWEmotionTabBarButtonTypeLxh: // Lxh
        {
            [self addSubview:self.lxhListView];
            break;
        }
    }
    self.showingListView = [self.subviews lastObject];
    [self setNeedsLayout];
}

@end
