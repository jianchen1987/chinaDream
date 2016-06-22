//
//  ExchangeRecordViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/16.
//  Copyright © 2015年 高国峰. All rights reserved.
//
static NSString *exchangeIdentifire = @"exchangeIdentifire";

#import "ExchangeRecordViewController.h"

@interface ExchangeRecordViewController ()

@end

@implementation ExchangeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-50) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"packege",@"image",@"600积分",@"title",@"成功",@"status", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"box",@"image",@"200积分",@"title",@"失败",@"status", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"packege",@"image",@"600积分",@"title",@"成功",@"status", nil];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    [dataSource addObject:dic3];
    [dataSource addObject:dic1];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    [dataSource addObject:dic3];
    [dataSource addObject:dic1];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    [dataSource addObject:dic3];
    [dataSource addObject:dic1];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    [dataSource addObject:dic3];
    [dataSource addObject:dic1];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExchangeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exchangeIdentifire];
    if (!cell) {
        cell = [[ExchangeRecordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exchangeIdentifire];
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
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[ExchangeResultViewController new] animated:YES];
    
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
