//
//  HWEmotionListView.m
//  微博项目
//
//  Created by Youngfev on 15/12/13.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionListView.h"
#import "HWEmotionPageView.h"

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
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];//不提供pageImage了？？
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
//    HWLog(@"%zd",count);
    self.pageControl.numberOfPages = count;
     NSRange range;
    for (NSInteger i = 0; i < count; i++) {
        HWEmotionPageView *pageView = [[HWEmotionPageView alloc] init];
       
        range.location = i * HWEmotionListPageSize;
        NSUInteger left = emotions.count - range.location;
        if (left >= HWEmotionListPageSize) {
            range.length = HWEmotionListPageSize;
        }else{
            range.length = left;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
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
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.x = i * pageView.width;
        pageView.y = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat page = scrollView.contentOffset.x / self.scrollView.width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}

@end
