//
//  HWAccountTool.h
//  微博项目
//
//  Created by Youngfev on 15/12/7.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWAccount.h"
@interface HWAccountTool : NSObject
+(void)saveAccount:(HWAccount *)account;
+(HWAccount*)account;
@end
