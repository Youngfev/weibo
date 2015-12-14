//
//  HWEmotionListView.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionListView.h"

#define HWEmotionListPageSize 20

@interface HWEmotionListView ()

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HWEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
//        scrollView.backgroundColor = HWRandomColor;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
//        pageControl.backgroundColor = HWRandomColor;
//        pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"comopse_keyboard_dot_normal"]];
//        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        pageControl.userInteractionEnabled = NO;
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
    
}

-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
//    HWLog(@"%ld",emotions.count);
    self.pageControl.numberOfPages = (emotions.count + HWEmotionListPageSize -1) / HWEmotionListPageSize;
    HWLog(@"%ld",self.pageControl.numberOfPages);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = 0;
    self.scrollView.y = 0;
}

@end
