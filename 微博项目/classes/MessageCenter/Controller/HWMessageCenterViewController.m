//
//  HWMessageCenterViewController.m
//  微博项目
//
//  Created by Youngfev on 15/12/4.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWMessageCenterViewController.h"
#import "HWNavigationController.h"
#import "HWTestViewController.h"

@interface HWMessageCenterViewController ()

@end

@implementation HWMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

-(void)composeMsg
{
    NSLog(@"composeMsg");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * reuseID = @"reuseID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行数据",indexPath.row + 1];
    
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWTestViewController *test = [[HWTestViewController alloc] init];
    test.title = @"test 控制器";
    [self.navigationController pushViewController:test animated:YES];
}

@end
