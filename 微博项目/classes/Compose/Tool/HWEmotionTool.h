//
//  HWEmotionTool.h
//  微博项目
//
//  Created by Youngfev on 15/12/16.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWEmotion;

@interface HWEmotionTool : NSObject
+(void)addRecentEmotion:(HWEmotion *)emotion;
+(NSArray *)recentEmotions;
@end
