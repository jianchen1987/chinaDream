//
//  AboutUsViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/16.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()
{
    NSArray *leftTitleArray;
}
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 200)];
    headView.backgroundColor = RGBA(240, 240, 240, 1);
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth/2-50, 30, 100, 100)];
    headImageView.image = [UIImage imageNamed:@"appLogo"];
    [headView addSubview:headImageView];
    
    
    UILabel *appNameLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth/2-100, headImageView.bottom+20, 200, 20)];
    appNameLable.text = @"美邻说";
    appNameLable.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:appNameLable];
    
    
    
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.tableHeaderView = headView;
    [self.view addSubview:myTableView];
    
    leftTitleArray = @[@"我们的理念",@"合作事宜:(rzl@mls.com)",@"客服微信:mls2015",@"官方网站:www.rzl.com"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return leftTitleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *aboutUsIdentifire = @"aboutUsIdentifire";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutUsIdentifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutUsIdentifire];
    }
    
    
    cell.textLabel.text = leftTitleArray[indexPath.row];
    if (indexPath.row == 0 || indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[OurThankingViewController new] animated:YES];
    }
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
