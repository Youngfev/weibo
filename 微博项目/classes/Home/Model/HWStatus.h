//
//  HWStatus.h
//  微博项目
//
//  Created by Youngfev on 15/12/8.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWUser;
@interface HWStatus : NSObject
@property (nonatomic,copy) NSString * idstr;
@property (nonatomic,copy) NSString* text;
@property (nonatomic,strong) HWUser* user;

+(instancetype)statusWithDict:(NSDictionary*)dict;
@end
