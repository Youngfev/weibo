//
//  HWTextView.m
//  微博项目
//
//  Created by Youngfev on 15/12/12.
//  Copyright © 2015年 Youngfev. All rights reserved.
//带有占位文字的textview

#import "HWTextView.h"

@interface HWTextView ()

//@property (nonatomic,weak) UILabel *placeTextLabel;

@end

@implementation HWTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}
-(void)textDidChange
{
//    HWLog(@"textDidChange");
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = self.font;
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attr];
//    [self.placeholder drawInRect:CGRectMake(10, 100, 100, 100) withAttributes:attr];
    
}

@end
