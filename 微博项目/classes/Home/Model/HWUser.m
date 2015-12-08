//
//  HWUser.m
//  微博项目
//
//  Created by Youngfev on 15/12/8.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser
+(instancetype)userWithDict:(NSDictionary*)dict
{
    HWUser* user = [[self alloc]init];
    
    user.idstr = dict[@"idstr"];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    
    return user;
}
@end
