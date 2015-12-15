
//
//  HWEmotionPageView.m
//  微博项目
//
//  Created by Youngfev on 15/12/14.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionPageView.h"
#import "HWEmotion.h"
#import "HWEmotionPopView.h"

@interface HWEmotionPageView ()
@property (nonatomic,weak) HWEmotionPopView *popView;

@end

@implementation HWEmotionPageView


-(HWEmotionPopView *)popView
{
    if (!_popView) {
        _popView = [HWEmotionPopView popView];
    }
    
    return _popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
    }
    return self;
    
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        HWEmotion *emotion = emotions[i];
        if (emotion.code) {
            //emoji转码
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }else{
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        }
        btn.adjustsImageWhenHighlighted = NO;
        [self addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)btnClick:(UIButton *)btn
{
    HWEmotion *emotion = self.emotions[btn.tag];
    
    if (emotion.code) {
        //emoji转码
        [self.popView.popButton setTitle:emotion.code.emoji forState:UIControlStateNormal];
        self.popView.popButton.titleLabel.font = [UIFont systemFontOfSize:32];
    }else{
        [self.popView.popButton setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }
    
    btn.adjustsImageWhenHighlighted = NO;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];//获得最上面的window

    CGRect btnFrame = [btn convertRect:btn.bounds toView:nil];
    
    [window addSubview:self.popView];
    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMidX(btnFrame);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2 * inset) / 7;
    CGFloat btnH = (self.height - inset) / 3;
    NSUInteger count = self.emotions.count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % 7) * btnW;
        btn.y = inset + (i / 7) * btnH;
    }
}
@end
