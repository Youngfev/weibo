//
//  HWComposeToolbar.h
//  微博项目
//
//  Created by Youngfev on 15/12/12.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWComposeToolbarTypeCamera,
    HWComposeToolbarTypePicture,
    HWComposeToolbarTypeMention,
    HWComposeToolbarTypeTrend,
    HWComposeToolbarTypeEmotion,
    
}HWComposeToolbarType;

@class HWComposeToolbar;
@protocol HWComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarType)type;

@end
@interface HWComposeToolbar : UIView
@property (nonatomic,weak) id<HWComposeToolbarDelegate> delegate;
@end
