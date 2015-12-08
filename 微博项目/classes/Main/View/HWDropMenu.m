//
//  HWDropMenu.m
//  微博项目
//
//  Created by Youngfev on 15/12/5.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWDropMenu.h"
@interface HWDropMenu ()
@property (nonatomic,weak) UIImageView *containerView;//weak
@end
@implementation HWDropMenu

-(UIImageView *)containerView
{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        
        [self addSubview:containerView];//weak
        self.containerView = containerView;
    }
    return _containerView;
}
-(void)setContent:(UIView *)content
{
    _content = content;
    content.x = 10;
    content.y = 15;
    
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    [self.containerView addSubview:content];
}

-(void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)menu
{
    return [[self alloc]init];
}

- (void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    self.frame = window.bounds;
    
    CGRect newFrame = [from convertRect:from.bounds toView:window];
//    from.width = 199;
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    // 通知外界，自己显示了
    if ([self.delegate respondsToSelector:@selector(dropMenuDidShow:)]) {
        [self.delegate dropMenuDidShow:self];
    }
}

- (void)dismiss;
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(dropMenuDidDismisss:)]) {
        [self.delegate dropMenuDidDismisss:self];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}
@end
