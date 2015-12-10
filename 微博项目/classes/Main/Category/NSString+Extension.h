//
//  NSString+Extension.h
//  微博项目
//
//  Created by Youngfev on 15/12/10.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
@end
