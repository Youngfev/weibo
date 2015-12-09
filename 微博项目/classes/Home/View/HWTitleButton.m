
//
//  HWTitleButton.m
//  微博项目
//
//  Created by Youngfev on 15/12/7.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWTitleButton.h"

@implementation HWTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        
//        self.backgroundColor = [UIColor redColor];;
    }
    return self;
}

//-(void)setFrame:(CGRect)frame
//{
//    frame.size.width += 10;
//    
//    [super setFrame:frame];
//}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    
    // 1.计算titleLabel的frame
    self.titleLabel.x = 5;
//    self.titleLabel.x = self.imageView.x;
//
//    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame)+5;
//    HWLog(@"self.imageView.x %f",self.imageView.x);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}
@end
