//
//  HWEmotionAttachment.m
//  微博项目
//
//  Created by Youngfev on 15/12/15.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionAttachment.h"
#import "HWEmotion.h"

@implementation HWEmotionAttachment

-(void)setEmotion:(HWEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
