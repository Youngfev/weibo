//
//  HWAccount.h
//  微博项目
//
//  Created by Youngfev on 15/12/7.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAccount : NSObject<NSCoding>
/**获得的access Token*/
@property (nonatomic,copy) NSString* access_token;
@property (nonatomic,copy) NSString* expires_in;
@property (nonatomic,copy) NSString* uid;
@property (nonatomic,copy) NSDate * created_time;

+(instancetype) accountWithDict:(NSDictionary *)dict;
@end
