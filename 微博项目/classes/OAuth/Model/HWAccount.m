//
//  HWAccount.m
//  微博项目
//
//  Created by Youngfev on 15/12/7.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWAccount.h"

@implementation HWAccount
+(instancetype) accountWithDict:(NSDictionary *)dict
{
    HWAccount *account = [[HWAccount alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.created_time = [NSDate date];
    
    return account;
}

/**
 
 当一个对象要存储进沙盒时，就会调用这个方法
 目的是声明这个对象的哪个属性要存储到沙盒
 */

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}
/**
 
 从沙盒取出一个对象，就会调用这个方法
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
