//
//  HWAccountTool.m
//  微博项目
//
//  Created by Youngfev on 15/12/7.
//  Copyright © 2015年 Youngfev. All rights reserved.
//处理账号相关的所有操作

#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "HWAccountTool.h"

@implementation HWAccountTool

+(void)saveAccount:(HWAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}

+(HWAccount*)account
{
    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    
    /**验证账号是否过期*/
    long long expires_in = [account.expires_in longLongValue];//expires_in过期的期限
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    
    return account;
}
@end
