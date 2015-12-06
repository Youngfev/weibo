//
//  HWHomeViewController.m
//  微博项目
//
//  Created by Youngfev on 15/12/4.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWDropMenu.h"

@interface HWHomeViewController ()<HWDropMenuDelegate>

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];

    UIButton *titleButton = [[UIButton alloc]init];
    titleButton.width = 200;
    titleButton.height = 30;
    
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];

    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
    titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
    
//    UIButton *view1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 100, 100)];
//    view1.backgroundColor = [UIColor brownColor];
//    [view1 addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:view1];
//    
}

-(void)titleClick:(UIButton *)titleButton
{

    
    HWDropMenu *dropMenu = [HWDropMenu menu];
    UITableViewController *vc = [[UITableViewController alloc]init];
    vc.view.height = 200;
    vc.view.width = 200;
    dropMenu.contentController = vc;
    dropMenu.delegate = self;
    [dropMenu showFrom:titleButton];
    
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
//    [UIView animateWithDuration:1.0 animations:^{
        titleButton.selected = YES;
//    }];
    
}

-(void)friendSearch
{
//    NSLog(@"friendSearch");
}

-(void)pop
{
//        NSLog(@"pop");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

-(void)dropMenuDidDismisss:(HWDropMenu *)menu
{
    UIButton* titleBtn = (UIButton *)self.navigationItem.titleView;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleBtn.selected = NO;
}

@end
