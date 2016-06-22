//
//  ExchangeResultViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//
static NSString *exchangeResuleIdentifire = @"exchangeResuleIdentifire";

#import "ExchangeResultViewController.h"

@interface ExchangeResultViewController ()

@end

@implementation ExchangeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换结果";

    
    UIImageView *headBackImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
    headBackImageView.image = [UIImage imageNamed:@""];

    UIImageView *productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
    productImageView.image = [UIImage imageNamed:@"box"];
    [headBackImageView addSubview:productImageView];
    
    
    UILabel *intergralLable = [[UILabel alloc] initWithFrame:CGRectMake(productImageView.frame.origin.x+productImageView.frame.size.width+10, 50-15, 200, 30)];
    intergralLable.text = @"600积分";
    intergralLable.textColor = RGBA(255, 239, 52, 1);
    [headBackImageView addSubview:intergralLable];
    
    //状态
    UILabel *statusLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth-100, 50-15, 85, 30)];
    statusLable.text = @"实物";
    statusLable.textColor = [UIColor whiteColor];
    statusLable.textAlignment = NSTextAlignmentRight;
    [headBackImageView addSubview:statusLable];


    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.tableHeaderView = headBackImageView;
    [self.view addSubview:myTableView];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *dataArray = @[@[@"成功"],@[@"您的本次兑换以已经成功，请进入您的账户中查收"],@[@"2003980380380280820"]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exchangeResuleIdentifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exchangeResuleIdentifire];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"订单状态:%@",dataArray[indexPath.section][indexPath.row]];
    }else if(indexPath.section == 1)
    {
        cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
    }else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"订单编号:%@",dataArray[indexPath.section][indexPath.row]];
    }
    
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
    return 50;
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
