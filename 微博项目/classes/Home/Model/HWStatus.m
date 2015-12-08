//
//  HWStatus.m
//  微博项目
//
//  Created by Youngfev on 15/12/8.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatus.h"
#import "HWUser.h"

@implementation HWStatus
+(instancetype)statusWithDict:(NSDictionary*)dict
{
    HWStatus* status = [[self alloc]init];
    
    status.idstr = dict[@"idstr"];
    status.text = dict[@"text"];
    status.user = [HWUser userWithDict:dict[@"user"]];
    
    return status;
}
@end
