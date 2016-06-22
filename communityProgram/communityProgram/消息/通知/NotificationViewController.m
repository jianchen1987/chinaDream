//
//  NotificationViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//
static NSString *notificationIdentifire = @"notificationIdentifire";

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController
-(void)loadNotification
{
    NSArray *array = @[@1,@10];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:@"getNoticeAll" successBlock:^(id successJsonData) {
        NSLog(@"successJsonData = %@",successJsonData);
        if (successJsonData) {
            for (NSDictionary *dic in successJsonData) {
                [dataSource addObject:dic];
            }
            [myTableView reloadData];
        }

    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc] init];
    [self loadNotification];
    
    
    
//    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"跟着邻居买，绝对靠谱",@"title",@"2015-12-27",@"date", nil];
//    
//    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"号外：猪小区第一期诚实周报新鲜出炉",@"title",@"2015-12-27",@"date", nil];
//    
//    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"活动即将结束，请抓紧时间报名",@"title",@"2015-12-27",@"date", nil];
//    [dataSource addObject:dic1];
//    [dataSource addObject:dic2];
//    [dataSource addObject:dic3];
//    [dataSource addObject:dic1];
//    [dataSource addObject:dic2];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:notificationIdentifire];
    if (!cell) {
        cell = [[NotificationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:notificationIdentifire];
    }
    
    NSDictionary *dic = dataSource[indexPath.row];
    [cell cellForData:dic];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
