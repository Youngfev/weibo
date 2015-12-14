//
//  HWEmotionTabBarButton.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionTabBarButton.h"

@implementation HWEmotionTabBarButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];

        
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
    
}

-(void)setHighlighted:(BOOL)highlighted
{
    
}

@end
