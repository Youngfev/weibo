//
//  HWUser.h
//  微博项目
//
//  Created by Youngfev on 15/12/8.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWUser : NSObject
@property (nonatomic,copy) NSString* idstr;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end
