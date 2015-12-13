
//
//  HWNewFeatureController.m
//  微博项目
//
//  Created by Youngfev on 15/12/6.
//  Copyright © 2015年 Youngfev. All rights reserved.
//
#define HWNewFeatureCount 4

#import "HWNewFeatureController.h"
#import "HWTabbarViewController.h"

@interface HWNewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl* pageContr;
@end

@implementation HWNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.frame = self.view.bounds;
//    scrollView.
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (NSInteger i = 0; i < HWNewFeatureCount; i ++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.width = scrollW;
        imgView.height = scrollH;
        imgView.x = i * scrollW;
        imgView.y = 0;
        NSString * imgName = [NSString stringWithFormat:@"new_feature_%ld",i + 1];
        imgView.image = [UIImage imageNamed:imgName];
        [scrollView addSubview:imgView];
        
        if (i == HWNewFeatureCount - 1) {
            [self setUpLastImageView:imgView];
        }
    }
    scrollView.contentSize = CGSizeMake(HWNewFeatureCount * scrollW, 0);
//    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIPageControl *pageContr = [[UIPageControl alloc] init];
//    pageContr.width = 100;
//    pageContr.height = 20;
    pageContr.centerX = scrollW * 0.5;
    pageContr.centerY = scrollH - 30;
//    pageContr.backgroundColor = [UIColor blackColor];
    pageContr.currentPageIndicatorTintColor = HWColor(253, 98, 42);
    pageContr.pageIndicatorTintColor = HWColor(189, 189, 189);
    pageContr.numberOfPages = HWNewFeatureCount;
    [self.view addSubview:pageContr];
    self.pageContr = pageContr;
    
}

-(void)setUpLastImageView:(UIImageView*)imgView
{
    imgView.userInteractionEnabled = YES;
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    shareBtn.width = 120;
    shareBtn.height = 30;
    shareBtn.centerX = imgView.width * 0.5;
//    HWLog(@"%f",shareBtn.centerX);
    shareBtn.centerY = imgView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.selected = NO;
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    [imgView addSubview:shareBtn];
    
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.y = imgView.height * 0.7;
    [startBtn setTitle:@"开始发微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchDown];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [imgView addSubview:startBtn];
    
}
//-(void)dealloc
//{
//    NSLog(@"startBtn");
//}
-(void)startBtnClick
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[HWTabbarViewController alloc] init];
}

-(void)shareBtnClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageContr.currentPage = (NSInteger)(page + 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
