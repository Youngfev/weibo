//
//  HWTabBar.m
//  微博项目
//
//  Created by Youngfev on 15/12/6.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWTabBar.h"
@interface HWTabBar ()
@property (nonatomic,weak) UIButton *plusBtn;
@end

@implementation HWTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];
        _plusBtn = plusBtn;
    }
    return  self;
}

-(void)plusBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    CGFloat btnWidth = self.width / 5;
    NSInteger index = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = btnWidth;
            child.x = index * btnWidth;
            index ++;
            if (index == 2) {
                index = 3;
            }
        }
    }
}
@end
