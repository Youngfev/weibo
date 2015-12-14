//
//  HWEmotionTabBar.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionTabBar.h"
#import "HWEmotionTabBarButton.h"

@interface HWEmotionTabBar()
@property (nonatomic, weak) HWEmotionTabBarButton *selectedBtn;
@end

@implementation HWEmotionTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.userInteractionEnabled = YES;
//        [self setupBtn:@"最近" buttonType:HWEmotionTabBarButtonTypeRecent];
//        [self setupBtn:@"默认" buttonType:HWEmotionTabBarButtonTypeDefault];
//        [self setupBtn:@"Emoji" buttonType:HWEmotionTabBarButtonTypeEmoji];
//        [self setupBtn:@"浪小花" buttonType:HWEmotionTabBarButtonTypeLxh];
        [self setupBtn:@"最近" buttonType:HWEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:HWEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:HWEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:HWEmotionTabBarButtonTypeLxh];
    }
    return self;
}

-(void)setupBtn:(NSString *)title buttonType:(HWEmotionTabBarButtonType)buttonType
{
    HWEmotionTabBarButton *btn = [[HWEmotionTabBarButton alloc] init];
    
    [btn setTitle:title forState:UIControlStateNormal];
//    if (buttonType == HWEmotionTabBarButtonTypeDefault) {
//        
//        [self btnClick:btn];
//    }
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectedImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectedImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectedImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateDisabled];

    btn.tag = buttonType;
    [self addSubview:btn];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
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

-(void)setDelegate:(id<HWEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    [self btnClick:(HWEmotionTabBarButton *)[self viewWithTag:HWEmotionTabBarButtonTypeDefault]];
}

-(void)btnClick:(HWEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(HWEmotionTabBarButtonType)btn.tag];
    }
}

@end
