//
//  HWStatus.m
//  微博项目
//
//  Created by Youngfev on 15/12/8.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatus.h"
#import "MJExtension.h"
#import "HWPhoto.h"

@implementation HWStatus
+ (NSDictionary*)mj_objectClassInArray
{
    return @{@"pic_urls":[HWPhoto class]};
}
@end
