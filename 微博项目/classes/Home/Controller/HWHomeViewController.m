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
#import "HWTitleButton.h"
#import "UIImageView+WebCache.h"
#import "HWStatus.h"
#import "HWUser.h"
#import "MJExtension.h"
#import "HWLoadMoreFooter.h"

@interface HWHomeViewController ()<HWDropMenuDelegate>
@property (nonatomic,strong) NSMutableArray *statuses;
@end

@implementation HWHomeViewController

-(NSMutableArray *)statuses{
    if (_statuses == nil) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setUpNav];
    
    [self setUpUserInfo];
    
    [self setUpUpRefresh];
    [self setUpDownRefresh];
    
}

-(void)setUpUpRefresh
{
    HWLoadMoreFooter *footer = [HWLoadMoreFooter footer];
//    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    self.tableView.tableFooterView.hidden = YES;
}


-(void)setUpDownRefresh
{
    UIRefreshControl *refreshContr = [[UIRefreshControl alloc] init];
    
    [refreshContr beginRefreshing];
    [self refreshStateChange:refreshContr];
    
    [refreshContr addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshContr];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFJSONResponseSerializer
    //拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    HWStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        parameters[@"since_id"] = firstStatus.idstr;
    }
    //    parameters[@"count"] = @1;
    //发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *newStatuses = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HWStatus *status = [HWStatus mj_objectWithKeyValues:dict];
            [newStatuses addObject:status];
        }
        
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
//        [refreshContr endRefreshing];
        
//        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"%@",error);
        self.tableView.tableFooterView.hidden = YES;
//        [refreshContr endRefreshing];
    }];
}

-(void)refreshStateChange:(UIRefreshControl *)refreshContr
{
//    HWLog(@"refreshStateChange");
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFJSONResponseSerializer
    //拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    HWStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        parameters[@"since_id"] = firstStatus.idstr;
    }
    //    parameters[@"count"] = @1;
    //发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *newStatuses = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HWStatus *status = [HWStatus mj_objectWithKeyValues:dict];
            [newStatuses addObject:status];
        }
        
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        
        [self.tableView reloadData];
        
        [refreshContr endRefreshing];
        
        [self showNewStatusCount:newStatuses.count];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"%@",error);
        [refreshContr endRefreshing];
    }];
}

-(void)showNewStatusCount:(NSInteger)count
{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    if (!count) {
        label.text = @"没有新的微博，稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"有%ld条新微博",count];
    }
    
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            label.y -= label.height;
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
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
        HWUser *user = [HWUser mj_objectWithKeyValues:responseObject];
//        NSString *name = responseObject[@"name"];
        
        account.name = user.name;
        [HWAccountTool saveAccount:account];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"%@",error);
    }];
}

-(void)setUpNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem= [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    HWTitleButton *titleButton = [[HWTitleButton alloc]init];
    
    NSString *name = [HWAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseId = @"reuseId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    /**
     
     profile_image_url = http://tp1.sinaimg.cn/5496045720/50/5722759073/1
     
     
     */
    
    HWStatus *status = self.statuses[indexPath.row];
    HWUser *user = status.user;
    
    NSString *profileImage = user.profile_image_url;
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default_small"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:profileImage] placeholderImage:placeholder];
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 如果tableView还没有数据，就直接返回
    if (self.statuses.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatus];
    }
}


-(void)dropMenuDidDismisss:(HWDropMenu *)menu
{
    UIButton* titleBtn = (UIButton *)self.navigationItem.titleView;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleBtn.selected = NO;
}
-(void)dropMenuDidShow:(HWDropMenu *)menu
{
    UIButton* titleBtn = (UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
}
@end
