//
//  HWStatusPhotosView.h
//  微博项目
//
//  Created by Youngfev on 15/12/10.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HWStatusPhotosView : UIView
@property (nonatomic,strong) NSArray * photos;
+ (CGSize)photosSizeWithCount:(NSInteger)count;
@end
