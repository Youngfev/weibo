//
//  HWEmotionTool.m
//  微博项目
//
//  Created by Youngfev on 15/12/16.
//  Copyright © 2015年 Youngfev. All rights reserved.
//
#define HWRecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotions.archive"]
#import "HWEmotionTool.h"
#import "HWEmotion.h"

@implementation HWEmotionTool

static NSMutableArray *_recentEmotions;

+(void)initialize
{
    _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HWRecentEmotionsPath];
    if (_recentEmotions == nil) {
        _recentEmotions = [[NSMutableArray alloc] init];
    }
}

+(void)addRecentEmotion:(HWEmotion *)emotion
{
//    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
//    
//    if (!emotions) {
//        emotions = [NSMutableArray array];
//    }
    
    
//    for (HWEmotion *emo in emotions) {
//        if (([emo.chs isEqualToString:emotion.chs]) || ([emo.code isEqualToString:emotion.code])) {
//            [emotions removeObject:emo];
//            break;
//        }
//    }
    [_recentEmotions removeObject:emotion];
    
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:HWRecentEmotionsPath];
}

+(NSArray *)recentEmotions
{
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:HWRecentEmotionsPath];
    return _recentEmotions;
}

@end
