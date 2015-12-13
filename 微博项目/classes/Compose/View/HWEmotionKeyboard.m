//
//  HWEmotionKeyboard.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionTabbar.h"

@interface HWEmotionKeyboard ()

@property (nonatomic,weak) HWEmotionListView *listView;
@property (nonatomic,weak) HWEmotionTabbar *tabbar;

@end

@implementation HWEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        HWEmotionListView *listView = [[HWEmotionListView alloc] init];
        [self addSubview:listView];
        
        self.listView = listView;
        
        HWEmotionTabbar *tabbar = [[HWEmotionTabbar alloc] init];
        [self addSubview:tabbar];
        
        self.tabbar = tabbar;
    }
    return self;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabbar.width = self.width;
    self.tabbar.height = 44;
    self.tabbar.y = 0;
    self.tabbar.y = self.height - self.tabbar.height;
    
    self.listView.x = self.listView.y = 0;
    self.width = self.width;
    self.height = self.tabbar.y;
}

@end
