//
//  CompleteViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//
static NSString *completeIdentifire = @"completeIdentifire";
#import "CompleteViewController.h"

@interface CompleteViewController ()

@end

@implementation CompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-40) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaittingPaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:completeIdentifire];
    if (!cell) {
        cell = [[WaittingPaymentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:completeIdentifire];
    }
    [cell setModel:nil];
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
    return 125;
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
