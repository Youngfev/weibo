//
//  HWStatusFrame.m
//  微博项目
//
//  Created by Youngfev on 15/12/9.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatusFrame.h"
#import "HWStatus.h"
#import "HWUser.h"



@implementation HWStatusFrame

- (void)setStatus:(HWStatus *)status
{
    _status = status;
    
    HWUser *user = status.user;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 原创微博 */
    
    /** 头像 */
    CGFloat iconWH = 40;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:HWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员图标 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HWStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:HWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
//    self.timeLabelF
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + HWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:HWStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    if (self.status.pic_urls.count) {
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
        self.photosViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        originalH = CGRectGetMaxY(self.photosViewF) + HWStatusCellBorderW;
    }else{
        originalH = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolbarY = 0;
    /**转发*/
    if (self.status.retweeted_status) {
        
        HWStatus *retweeted_status = status.retweeted_status;
        HWUser *retweeted_status_user = retweeted_status.user;
        
        CGFloat retweetContentX = HWStatusCellBorderW;
        CGFloat retweetContentY = HWStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        CGSize retweetContentSize = [retweetContent sizeWithFont:HWStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
            self.retweetPhotosViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + HWStatusCellBorderW;
        }else{
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
        }

        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        

        
        toolbarY = CGRectGetMaxY(self.retweetViewF) + 0.5;
        
    }else{
        toolbarY = CGRectGetMaxY(self.originalViewF) + 0.5;
    }
    

    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 30;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);

    self.cellHeight = CGRectGetMaxY(self.toolbarF) + HWStatusCellBorderW;
    
}
@end
