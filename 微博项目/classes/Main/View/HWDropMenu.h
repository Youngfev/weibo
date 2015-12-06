//
//  HWDropMenu.h
//  微博项目
//
//  Created by Youngfev on 15/12/5.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWDropMenu;
@protocol HWDropMenuDelegate <NSObject>
@optional
-(void)dropMenuDidDismisss:(HWDropMenu *)menu;

@end

@interface HWDropMenu : UIView
+ (instancetype)menu;
- (void)showFrom:(UIView *)from;
- (void)dismiss;
@property (nonatomic,strong) UIView* content;
@property (nonatomic,strong) UIViewController * contentController;
@property (nonatomic,weak) id<HWDropMenuDelegate> delegate;
@end
