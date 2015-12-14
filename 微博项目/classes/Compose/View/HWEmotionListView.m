//
//  HWEmotionListView.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionListView.h"

#define HWEmotionListPageSize 20

@interface HWEmotionListView ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HWEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = HWRandomColor;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
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
    
    NSUInteger count = (emotions.count + HWEmotionListPageSize -1) / HWEmotionListPageSize;
    
    self.pageControl.numberOfPages = count;
    
    for (int i = 0; i < count; i++) {
        UIView *pageView = [[UIView alloc] init];

        [self.scrollView addSubview:pageView];
    }
    

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    
    NSUInteger count = self.scrollView.subviews.count;

    for (int i = 0; i < count; i++) {
        UIView *pageView = self.scrollView.subviews[i];
//        if ([pageView isKindOfClass:[UIImageView class]]) continue;
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = i * pageView.width;
        pageView.x = 0;
    }
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.scrollView.contentSize = CGSizeMake(count * screenW, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / self.scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

@end
