//
//  HWComposePhotosView.m
//  微博项目
//
//  Created by Youngfev on 15/12/12.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWComposePhotosView.h"

@implementation HWComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //
    }
    return self;
    
}

-(void)addPhoto:(UIImage *)image
{
    UIImageView *img = [[UIImageView alloc] init];
    
    img.image = image;
    img.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:img];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger photosCount = self.subviews.count;
    NSUInteger maxCol = 4;
    CGFloat imageHW = 70;
    for (NSUInteger i = 0; i < photosCount; i ++) {
        UIImageView *photoView = self.subviews[i];
        
        NSUInteger col = i % maxCol;
        NSUInteger row = i / maxCol;
        photoView.x = col * (imageHW + 5);
        photoView.y = row * (imageHW + 5);
        photoView.width = imageHW;
        photoView.height = imageHW;
    }
}

@end
