//
//  DynamicViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//
static NSString *dynamicIdentifire = @"dynamicIdentifire";
#import "DynamicViewController.h"

@interface DynamicViewController ()

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    dataSource = [[NSMutableArray alloc] init];
    
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"跟着邻居买，绝对靠谱",@"title",@"2015-12-27",@"date", nil];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"号外：猪小区第一期诚实周报新鲜出炉",@"title",@"2015-12-27",@"date", nil];
    
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"活动即将结束，请抓紧时间报名",@"title",@"2015-12-27",@"date", nil];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    [dataSource addObject:dic3];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-49) style:UITableViewStyleGrouped];
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
    DirectMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicIdentifire];
    if (!cell) {
        cell = [[DirectMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dynamicIdentifire];
    }
    NSDictionary *dic = dataSource[indexPath.row];
    [cell cellWithData:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    DirectMessageTableViewCell *cell = (DirectMessageTableViewCell *)[self tableView:myTableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
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
