//
//  HWStatusPhotoView.m
//  微博项目
//
//  Created by Youngfev on 15/12/10.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"
@interface HWStatusPhotoView ()
@property (nonatomic,weak) UIImageView *gifView;

@end

@implementation HWStatusPhotoView

-(UIImageView*)gifView{
    if (_gifView == nil) {
        UIImage *image = [UIImage imageNamed:@"timeline_iamge_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
    
}

-(void)setPhoto:(HWPhoto *)photo
{
    _photo = photo;
    
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}
@end
