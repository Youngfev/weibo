//
//  HWStatusToolbar.h
//  微博项目
//
//  Created by Youngfev on 15/12/10.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HWStatus.h"

@interface HWStatusToolbar : UIView
+(instancetype)toolbar;
@property (nonatomic,strong) HWStatus* status;
@end
