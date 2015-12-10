//
//  HWStatusToolbar.m
//  微博项目
//
//  Created by Youngfev on 15/12/10.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatusToolbar.h"

@interface HWStatusToolbar ()
@property (nonatomic,weak) UIButton* retweetBtn;
@property (nonatomic,weak) UIButton* commentBtn;
@property (nonatomic,weak) UIButton* attitudeBtn;


@end

@implementation HWStatusToolbar

+(instancetype)toolbar{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];

        self.retweetBtn = [self setUpBtn:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self setUpBtn:@"timeline_icon_comment" title:@"评论"];
        self.attitudeBtn = [self setUpBtn:@"timeline_icon_unlike" title:@"赞"];
    }
    return self;
}

-(UIButton*)setUpBtn:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.width /count;
    CGFloat btnH = self.height;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.height = btnH;
        btn.width = btnW;
    }
}

-(void)setStatus:(HWStatus *)status
{
    _status = status;
    
    [self setUpBtnCount:self.status.reposts_count btn:self.retweetBtn titile:@"转发"];
    [self setUpBtnCount:self.status.comments_count btn:self.commentBtn titile:@"评论"];
    [self setUpBtnCount:self.status.attitudes_count btn:self.attitudeBtn titile:@"赞"];
}

-(void)setUpBtnCount:(NSInteger)count btn:(UIButton *)btn titile:(NSString *)title
{
    if (count) {
        NSString *title = [NSString stringWithFormat:@"%ld",count];
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
