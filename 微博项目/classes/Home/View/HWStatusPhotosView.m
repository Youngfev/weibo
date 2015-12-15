//
//  HWStatusPhotosView.m
//  微博项目
//
//  Created by Youngfev on 15/12/10.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatusPhotosView.h"
#import "HWPhoto.h"

#import "HWStatusPhotoView.h"

#define HWStatusPhotoWH 80
#define HWStatusPhotoMargin 10
#define HWStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation HWStatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor brownColor];
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSInteger photosCount = photos.count;
    
    while (self.subviews.count < photosCount) {
        HWStatusPhotoView *photoView = [[HWStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) {
            photoView.hidden = NO;
            
            photoView.photo = photos[i];
            
            
        }else{
            photoView.hidden = YES;
        }
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger photosCount = self.photos.count;
    int maxCol = HWStatusPhotoMaxCol(photosCount);
    for (NSInteger i = 0; i < photosCount; i ++) {
        HWStatusPhotoView *photoView = self.subviews[i];
        
        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;
        photoView.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin);
        photoView.width = HWStatusPhotoWH;
        photoView.height = HWStatusPhotoWH;
    }

}

+ (CGSize)photosSizeWithCount:(NSInteger)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = 3;
    
    NSInteger cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * HWStatusPhotoWH + (cols - 1) * HWStatusPhotoMargin;
    
    // 行数
    NSInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * HWStatusPhotoWH + (rows - 1) * HWStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
@end
