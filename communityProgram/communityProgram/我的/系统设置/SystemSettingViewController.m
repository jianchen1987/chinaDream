//
//  SystemSettingViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "SystemSettingViewController.h"

@interface SystemSettingViewController ()

@end

@implementation SystemSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.showsVerticalScrollIndicator = NO;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else if(section == 1)
    {
        return 4;
    }
    else
    {
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = @[@[@"开启",@"只在夜间开启",@"关闭"],@[@"清理缓存",@"修改密码",@"问题反馈",@"关于我们"],@[@"退出登录"]];
    static NSString *settingIdentifire = @"settingIdentifire";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingIdentifire];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingIdentifire];
        cell.textLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
    }
    
    
    cell.textLabel.text = titleArray[indexPath.section][indexPath.row];
    if (indexPath.section == 1)
    {
        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else if(indexPath.section == 2)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *desArray = @[@"勿扰模式设置",@"开启夜间则只会22:00到8:00间生效",@""];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
    
    UILabel *descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceWidth-20, 20)];
    descriptionLable.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
    descriptionLable.text = [desArray objectAtIndex:section];
    [backView addSubview:descriptionLable];
    
    
    return backView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section)
    {
        case 0:
            break;
        case 1:
        {
            if (indexPath.row == 1)
            {
                
            }else if(indexPath.row == 2)
            {
                [self.navigationController pushViewController:[OpinionRebackViewController new] animated:YES];
            }else if(indexPath.row == 3)
            {
                [self.navigationController pushViewController:[AboutUsViewController new] animated:YES];
            }
        }
            break;
        case 2:
        {
            [[UserObject shareUser] loginOut];
            [self checkIsLogin];
        }
        default:
            break;
    }

}


@end
