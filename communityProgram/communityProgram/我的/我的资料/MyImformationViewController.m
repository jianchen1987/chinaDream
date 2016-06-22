//
//  MyImformationViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyImformationViewController.h"

@interface MyImformationViewController ()

@end

@implementation MyImformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 120)];
    topView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 60, 60)];
    userImageView.image = [UIImage imageNamed:@""];
    userImageView.layer.cornerRadius = 30;
    
    userImageView.clipsToBounds = YES;
    [topView addSubview:userImageView];
    
    UILabel *userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(userImageView.right+10, 15, 200, 20)];
    userNameLable.text = @"测试数据";
    userNameLable.textColor = RGBA(51, 51, 51, 1);
    userNameLable.font = Font(16);
    [topView addSubview:userImageView];
    
    
    UILabel *userLevelLable = [[UILabel alloc] initWithFrame:CGRectMake(userImageView.right+10, userNameLable.bottom+5, 200, 20)];
    userLevelLable.text = @"我的等级:LV2";
    userLevelLable.font = Font(14);
    [topView addSubview:userLevelLable];
    
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.tableHeaderView = topView;
    [self.view addSubview:myTableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }else
        return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myImformationIdentifire = @"myImformationCell";
    static NSString *myImformationInputIdentifire = @"myImformationInputCell";
    NSArray *leftTitleArray = @[@[@"昵称",@"性别",@"生日",@"爱好",@"家乡",@"房间号"],@[@"地址管理"]];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myImformationIdentifire];
    MyImformationInputTableViewCell *inputCell = [tableView dequeueReusableCellWithIdentifier:myImformationInputIdentifire];
    if (indexPath.section == 0) {
        if (indexPath.row == 1 || indexPath.row == 2) {
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationIdentifire];
            }
            
            cell.textLabel.text = leftTitleArray[indexPath.section][indexPath.row];

            
            return cell;
        }else
        {
            if (!inputCell) {
                inputCell = [[MyImformationInputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationInputIdentifire];
            }
            inputCell.textLabel.text = leftTitleArray[indexPath.section][indexPath.row];

            return inputCell;
            
        }
        
    }else
    {
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationIdentifire];
        }
        cell.textLabel.text = leftTitleArray[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }else
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 30)];
        
        UILabel *desLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, DeviceWidth, 20)];
        desLable.text = @"等级可获得超市商品的相应优惠";
        desLable.font = Font(14);
        desLable.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:desLable];
        
        return backView;
    }else
        return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
