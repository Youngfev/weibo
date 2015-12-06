//
//  HWDropMenu.h
//  微博项目
//
//  Created by Youngfev on 15/12/5.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWDropMenu : UIView
+ (instancetype)menu;
- (void)showFrom:(UIView *)from;
- (void)dismiss;
@property (nonatomic,strong) UIView* content;
@property (nonatomic,strong) UIViewController * contentController;
@end
