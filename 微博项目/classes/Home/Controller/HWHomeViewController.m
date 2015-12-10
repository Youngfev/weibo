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
#import "HWStatusCell.h"
#import "HWStatusFrame.h"

@interface HWHomeViewController ()<HWDropMenuDelegate>
@property (nonatomic,strong) NSMutableArray *statusesFrames;
@end

@implementation HWHomeViewController

-(NSMutableArray *)statusesFrames{
    if (_statusesFrames == nil) {
        _statusesFrames = [NSMutableArray array];
    }
    return _statusesFrames;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setUpNav];
    
    [self setUpUserInfo];
    
    [self setUpUpRefresh];
    
    [self setUpDownRefresh];
    
    self.tableView.backgroundColor = HWColor(211, 211, 211);
    self.tableView.contentInset = UIEdgeInsetsMake(74, 0, 0, 0);
    
#warning 暂时关闭
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setUpUnreadCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
   
}

-(void)setUpUnreadCount
{
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFJSONResponseSerializer
    //拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    parameters[@"uid"] = account.uid;
//    HWStatus *firstStatus = [self.statuses firstObject];
//    if (firstStatus) {
//        parameters[@"since_id"] = firstStatus.idstr;
//    }
    //    parameters[@"count"] = @1;
    //发送请求
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        //responseObject[@"status"]
        
#warning 未读数量桌面不提示，待测试
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"%@",error);
    }];
}

-(void)setUpUpRefresh
{
    HWLoadMoreFooter *footer = [HWLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
//    self.tableView.tableFooterView.hidden = YES;
}

-(void)setUpDownRefresh
{
    UIRefreshControl *refreshContr = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshContr];
    
    [refreshContr beginRefreshing];
    [self loadNewStatus:refreshContr];
    
    [refreshContr addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
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
    HWStatusFrame *lastStatus = [self.statusesFrames lastObject];
    if (lastStatus) {
        long long maxId = lastStatus.status.idstr.longLongValue - 1;
        parameters[@"max_id"] = @(maxId);
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
        
        NSMutableArray *newStatusFrames = [NSMutableArray array];
        for (HWStatus *status in newStatuses) {
            HWStatusFrame *fram = [[HWStatusFrame alloc] init];
            fram.status = status;
            [newStatusFrames addObject:fram];
        }
        
        [self.statusesFrames addObjectsFromArray:newStatusFrames];
        
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"请求失败-%@",error);
        self.tableView.tableFooterView.hidden = YES;
//        [refreshContr endRefreshing];
    }];
}

-(void)loadNewStatus:(UIRefreshControl *)refreshContr
{
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFJSONResponseSerializer
    //拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
    HWStatusFrame *firstStatus = [self.statusesFrames firstObject];
    if (firstStatus) {
        parameters[@"since_id"] = firstStatus.status.idstr;
    }
    //发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        NSMutableArray *newStatuses = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            HWStatus *status = [HWStatus mj_objectWithKeyValues:dict];
            [newStatuses addObject:status];
        }
        
        NSMutableArray *newStatusFrames = [NSMutableArray array];
        for (HWStatus *status in newStatuses) {
            HWStatusFrame *fram = [[HWStatusFrame alloc] init];
            fram.status = status;
            [newStatusFrames addObject:fram];
        }
        
        NSRange range = NSMakeRange(0, newStatusFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusesFrames insertObjects:newStatusFrames atIndexes:indexSet];
        
        [self.tableView reloadData];
        
        [refreshContr endRefreshing];
        
        [self showNewStatusCount:newStatuses.count];
//        HWLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"%@",error);
        [refreshContr endRefreshing];
    }];
}

-(void)showNewStatusCount:(NSInteger)count
{
    
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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
    //发送请求https://api.weibo.com/2/statuses/public_timeline.json
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


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.statusesFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusCell *cell = [HWStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusesFrames[indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 如果tableView还没有数据，就直接返回
    if (self.statusesFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusFrame *fra = self.statusesFrames[indexPath.row];
//    HWLog(@"%f",fra.cellHeight);
    return fra.cellHeight;
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
