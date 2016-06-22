//
//  PurchaseViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "PurchaseViewController.h"

@interface PurchaseViewController ()

@end

@implementation PurchaseViewController
-(void)loadPurchaseData
{
    NSArray *array = @[[NSNumber numberWithInt:page],@10];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:GetCouponsBatchByPagePath successBlock:^(id successJsonData) {
        NSLog(@"successJsonData = %@",successJsonData);
        NSMutableArray *array = successJsonData;
        if (array.count) {
            for (NSDictionary *dic in array) {
                [dataSource addObject:dic];
            }
            [myTableView reloadData];
            [myTableView.header endRefreshing];
        }
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);
    }];
}

- (void)pullUpToLoadMoreNews
{    __weak __typeof(self) weakSelf = self;
    
    myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
        
    }];
}
-(void)loadMoreData
{
    page++;
    
    NSArray *array = @[[NSNumber numberWithInt:page],@10];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:GetCouponsBatchByPagePath successBlock:^(id successJsonData) {
        NSLog(@"successJsonData = %@",successJsonData);
        NSMutableArray *array = successJsonData;
        if (array.count) {
            for (NSDictionary *dic in array) {
                [dataSource addObject:dic];
            }
            [myTableView reloadData];

        }else
        {
            [myTableView.footer endRefreshing];
        }
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠券";
    dataSource = [[NSMutableArray alloc] init];
    page = 1;
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadPurchaseData];
    }];
    
    // 马上进入刷新状态
    [myTableView.header beginRefreshing];
    
    [self pullUpToLoadMoreNews];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"cell";
    PurchaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[PurchaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    NSDictionary *dic = dataSource[indexPath.row];
    if (dic) {
        [cell loadCellData:dic];
        
    }
//    cell.headImageView.image = [UIImage imageNamed:[dic valueForKey:@"image"]];
//    cell.titleLable.text = [dic valueForKey:@"from"];
//    cell.desLable.text = [dic valueForKey:@"description"];
//    [cell.dateButton setTitle:[NSString stringWithFormat:@"有效期至%@",[dic valueForKey:@"date"]] forState:0];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"点击领取优惠券");
    
    NSDictionary *dic = dataSource[indexPath.row];
    NSArray *array = @[[Utility defaultsForKey:@"userID"],[dic valueForKey:@"id"]];

    NSLog(@"dic = %@",dic);
    NSLog(@"array = %@",array);

    
    
    
    
    
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
