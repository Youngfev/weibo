//
//  HWStatusCell.m
//  微博项目
//
//  Created by Youngfev on 15/12/9.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "HWStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "HWPhoto.h"
#import "HWStatusToolbar.h"
#import "HWStatusPhotosView.h"


@interface HWStatusCell()
/* 原创微博 */
/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) HWStatusPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/**
 转发微博
 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) HWStatusPhotosView *retweetPhotosView;

@property (nonatomic, weak) HWStatusToolbar *toolbar;
@end

@implementation HWStatusCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"reuseId";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupOriginal];
        [self setupRetweet];
        [self setupToolbar];
    }
    return self;
}
-(void)setupToolbar
{
    HWStatusToolbar *toolbar = [HWStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
//    toolbar.backgroundColor = [UIColor brownColor];
    self.toolbar = toolbar;
}

-(void)setupRetweet
{
    /** 原创微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    retweetView.backgroundColor = HWColor(247, 247, 247);
    self.retweetView = retweetView;

    /**转发内容*/
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = HWStatusCellNameFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    /** 转发配图 */
    HWStatusPhotosView *retweetPhotosView = [[HWStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    
}

-(void)setupOriginal
{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    /** 配图 */
    HWStatusPhotosView *photosView = [[HWStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = HWStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = HWStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = HWStatusCellSourceFont;
    sourceLabel.textColor = HWColor(115, 115, 115);
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = HWStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
}

- (void)setStatusFrame:(HWStatusFrame *)statusFrame
{
    
//    HWLog(@"setStatusFrame:(HWStatusFrame *)statusFrame");
    _statusFrame = statusFrame;
    
    HWStatus *status = statusFrame.status;
    HWUser *user = status.user;
    
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
        /** 会员图标 */
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }


    /** 配图 */
   
    
    if (status.pic_urls.count) {
         self.photosView.frame = statusFrame.photosViewF;
         self.photosView.photos = status.pic_urls;
//#warning todo
//        HWPhoto *photo = [status.pic_urls lastObject];
//        [self.photosView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_imageq_placeholder"]];
        self.photosView.hidden = NO;
    }else{
        self.photosView.hidden = YES;

    }
    
//    /** 昵称 */
//    self.nameLabel.text = user.name;
//    self.nameLabel.frame = statusFrame.nameLabelF;
//    
//    /** 时间 */
//    NSString *time = status.created_at;
//    CGFloat timeX = statusFrame.nameLabelF.origin.x;
//    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + HWStatusCellBorderW;
//    CGSize timeSize = [time sizeWithFont:HWStatusCellTimeFont];
//    statusFrame.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
//    //    self.timeLabelF/** 时间 */
//    self.timeLabel.text = time;
//    
//    /** 来源 */
//    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HWStatusCellBorderW;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [status.source sizeWithFont:HWStatusCellSourceFont];
//    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
//
//    
//    
////    self.sourceLabel.font = [UIFont systemFontOfSize:12];
////    self.sourceLabel.frame = statusFrame.timeLabelF;
//    
//    /** 来源 */
//    self.sourceLabel.text = status.source;
////    self.sourceLabel.frame = statusFrame.sourceLabelF;
//    
//    /** 正文 */
//    self.contentLabel.text = status.text;
//    self.contentLabel.frame = statusFrame.contentLabelF;
    
    
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    //    NSString *newTime = status.created_at;
    //    NSUInteger timeLen = self.timeLabel.text.length;
    //    if (timeLen && timeLen != newTime.length) { //
    //
    //    }
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + HWStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:HWStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HWStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;

    
    /**
     
     转发微博
     
     */
    if (status.retweeted_status) {
        
        HWStatus *retweeted_status = status.retweeted_status;
        HWUser *retweeted_status_user = retweeted_status.user;
    
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.numberOfLines = 0;
        self.retweetContentLabel.font = HWStatusCellRetweetContentFont;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        if (retweeted_status.pic_urls.count) {
            
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = status.retweeted_status.pic_urls;
//            #warning todo
//            HWPhoto *retweetedPhoto = [status.retweeted_status.pic_urls firstObject];
//            [self.retweetPhotosView sd_setImageWithURL:[NSURL URLWithString:retweetedPhoto.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
            
            self.retweetPhotosView.hidden = NO;
            
        }else{
            self.retweetPhotosView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }
 
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}

@end
