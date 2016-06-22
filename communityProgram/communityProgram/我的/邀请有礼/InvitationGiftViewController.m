//
//  InvitationGiftViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/12.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "InvitationGiftViewController.h"

@interface InvitationGiftViewController ()

@end

@implementation InvitationGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc] init];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *invitationIdentifire = @"invitationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:invitationIdentifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:invitationIdentifire];
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
