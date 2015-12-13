//
//  HWEmotionTabBar.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionTabBar.h"
#import "HWEmotionTabBarButton.h"

@implementation HWEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupBtn:@"最近"];
        [self setupBtn:@"默认"];
        [self setupBtn:@"Emoji"];
        [self setupBtn:@"浪小花"];
    }
    return self;
    
}

-(void)setupBtn:(NSString *)title
{
    HWEmotionTabBarButton *btn = [[HWEmotionTabBarButton alloc] init];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
    
    [self addSubview:btn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        HWEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}

@end
