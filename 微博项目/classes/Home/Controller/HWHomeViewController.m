//
//  HWHomeViewController.m
//  微博项目
//
//  Created by Youngfev on 15/12/4.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWDropMenu.h"
#import "AFNetworking.h"
#import "HWAccountTool.h"

@interface HWHomeViewController ()<HWDropMenuDelegate>

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];
    
    [self setUpUserInfo];
}
-(void)setUpUserInfo
{
    
    
    /**
     URL
     https://api.weibo.com/2/users/show.json
     
     必选	类型及范围	说明
     source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid	false	int64	需要查询的用户ID。
     screen_name	false	string	需要查询的用户昵称。
     */
    
    
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFJSONResponseSerializer
    //拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
    //发送请求
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        NSString *name = responseObject[@"name"];
        
        account.name = name;
        [HWAccountTool saveAccount:account];
        [titleButton setTitle:name forState:UIControlStateNormal];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"%@",error);
    }];
}

-(void)setUpNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    UIButton *titleButton = [[UIButton alloc]init];
    titleButton.width = 200;
    titleButton.height = 30;
    
    NSString *name = [HWAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 145, 0, 0);
    titleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
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
