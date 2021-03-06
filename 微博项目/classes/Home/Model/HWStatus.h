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
@property (nonatomic,copy) NSAttributedString *attributedText;

@property (nonatomic,strong) HWUser* user;
/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

@property (nonatomic,copy) NSArray* pic_urls;

@property (nonatomic,strong) HWStatus *retweeted_status;

@property (nonatomic,assign) NSInteger reposts_count;
@property (nonatomic,assign) NSInteger comments_count;
@property (nonatomic,assign) NSInteger attitudes_count;
@property (nonatomic,copy) NSAttributedString *retweeted_statusAttributedText;
@end
