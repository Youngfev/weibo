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
    
    [self loadNewStatus];
}

-(void)loadNewStatus
{
    
    /**
     https://api.weibo.com/2/statuses/friends_timeline.json
     
     
     必选	类型及范围	说明
     source	false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
     max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
     count	false	int	单页返回的记录条数，最大不超过100，默认为20。
     page	false	int	返回结果的页码，默认为1。
     base_app	false	int	是否只获取当前应用的数据。0为否（所有数据），1为是（仅当前应用），默认为0。
     feature	false	int	过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
     trim_user	false	int	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
     
     */
    //请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //    AFJSONResponseSerializer
    //拼接请求参数
    HWAccount *account = [HWAccountTool account];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = account.access_token;
//    parameters[@"count"] = @1;
    //发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        
        for (NSDictionary *dict in dictArray) {
            HWStatus *status = [HWStatus statusWithDict:dict];
            [self.statuses addObject:status];
        }
        
        [self.tableView reloadData];
        
//        [self.statuses writeToFile:@"/Users/Youngfev/Desktop/test.txt" atomically:YES];
//        HWLog(@"%@",responseObject[@"statuses"]);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        HWLog(@"%@",error);
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
        HWUser *user = [HWUser userWithDict:responseObject];
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
#warning Incomplete implementation, return the number of rows
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
