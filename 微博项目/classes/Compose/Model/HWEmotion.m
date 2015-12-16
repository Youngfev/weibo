//
//  HWEmotion.m
//  微博项目
//
//  Created by Youngfev on 15/12/14.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotion.h"

@implementation HWEmotion

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
}

-(BOOL)isEqual:(HWEmotion *)object
{
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString:object.code];
}
@end
