//
//  HWEmotionPopView.m
//  微博项目
//
//  Created by Youngfev on 15/12/14.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionPopView.h"

@implementation HWEmotionPopView

+(instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWEmotionPopView" owner:nil options:nil] lastObject];
}

@end
