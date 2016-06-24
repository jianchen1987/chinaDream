//
//  MyImformationViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyImformationViewController.h"
#import "ProgressView.h"

@interface MyImformationViewController ()<UITextFieldDelegate>

@end

@implementation MyImformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的资料";
   
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 120)];
    topView.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 80, 80)];
    userImageView.image = [UIImage imageNamed:@"上传头像"];
    userImageView.layer.cornerRadius = 30;
    userImageView.clipsToBounds = YES;
    [userImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnUploadHeadIcon:)];
    singleGesture.numberOfTapsRequired = 1;
    [userImageView addGestureRecognizer:singleGesture];
    [topView addSubview:userImageView];
    
    
    UILabel *quarterName = [[UILabel alloc] initWithFrame:CGRectMake(userImageView.right+10, 20, 200, 20)];
    quarterName.text      = [NSString stringWithFormat:@"我的小区:%@",self.user.quarter.quarterName];
    quarterName.textColor = RGBA(51, 51, 51, 1);
    quarterName.font      = Font(_SUBTITLE_FONT_SIZE_);
    [topView addSubview:quarterName];
    
    
    UILabel *userLevelLable = [[UILabel alloc] initWithFrame:CGRectMake(userImageView.right+10, (120 - 20)/2, 200, 20)];
    userLevelLable.text      = [NSString stringWithFormat:@"我的等级:LV%@",self.user.identityIntegral];
    userLevelLable.font      = Font(_DETAIL_FONT_SIZE_);
    userLevelLable.textColor = RGBA(93, 93, 93, 1);
    [topView addSubview:userLevelLable];
    
    ProgressView *progress = [[ProgressView alloc] initWithFrame:CGRectMake(userImageView.right + 10, userImageView.bottom -20, 200, 20)];
    [progress setProgressValue:0.71];
    [topView addSubview:progress];
    
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = topView;
}

- (void)clickOnUploadHeadIcon:(id)sender
{
    NSLog(@"touch upload");
}




#pragma mark --tableview delegate --
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
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
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 1 || indexPath.row == 2)
        {
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationIdentifire];
            }
            
            cell.textLabel.text = leftTitleArray[indexPath.section][indexPath.row];

            
            return cell;
        }
        else
        {
            MyImformationInputTableViewCell *inputCell = [tableView dequeueReusableCellWithIdentifier:myImformationInputIdentifire];
            if (!inputCell)
            {
                inputCell = [[MyImformationInputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationInputIdentifire];
            }
            inputCell.inputTextFeild.delegate = self;
            inputCell.textLabel.text = leftTitleArray[indexPath.section][indexPath.row];

            return inputCell;
            
        }
        
    }
    else
    {
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationIdentifire];
        }
        cell.textLabel.text = leftTitleArray[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 30;
    }
    else
    {
        return 10;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 30)];
        backView.backgroundColor = [UIColor clearColor];
        
        UILabel *desLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, DeviceWidth, 20)];
        desLable.text = @"等级可获得超市商品的相应优惠";
        desLable.font = Font(_DETAIL_FONT_SIZE_);
        desLable.textAlignment = NSTextAlignmentCenter;
        desLable.textColor = RGBA(93, 93, 93, 1);
        [backView addSubview:desLable];
        
        return backView;
    }
    else
        return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1)
    {
        
    }
}

#pragma mark -- textfield delegate --
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
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



- (void)saveUserInfoToServer
{
    
}



@end
