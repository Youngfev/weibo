//
//  HWComposeToolbar.m
//  微博项目
//
//  Created by Youngfev on 15/12/12.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWComposeToolbar.h"

@implementation HWComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        // 初始化按钮
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:HWComposeToolbarTypeCamera];
        
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:HWComposeToolbarTypePicture];
        
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:HWComposeToolbarTypeMention];
        
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:HWComposeToolbarTypeTrend];
        
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:HWComposeToolbarTypeEmotion];
        
    }
    return self;
    
}
-(void)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(HWComposeToolbarType)type
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.tag = type;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (NSUInteger i = 0; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        
        btn.x = i * btnW;
        btn.y = 0;
        btn.height = btnH;
        btn.width = btnW;
    }
    
}
-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        
        [self.delegate composeToolbar:self didClickButton:btn.tag];
    }
}

@end
