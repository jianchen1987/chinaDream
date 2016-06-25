//
//  MyImformationViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyImformationViewController.h"
#import "ProgressView.h"
#import "AddressManagerViewController.h"
#import "NetworkEngine.h"

@interface MyImformationViewController ()<UITextFieldDelegate>
{
    NSArray *_titleArr;
    NSDictionary *_placeholder;
    NSMutableDictionary *_cellContent;
}

@end

@implementation MyImformationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"我的资料";
    
    _titleArr    = @[@[@"nickName",@"gender",@"birth",@"hobbile",@"homeTown",@"room"],@[@"地址管理"]];
    _placeholder = @{@"nickName":@"",@"gender":@"",@"birth":@"",@"hobbile":@"",@"homeTown":@"",@"room":@"如501"};
    _cellContent = [[NSMutableDictionary alloc] initWithDictionary:@{@"nickName":self.user.nickName?self.user.nickName:@"",
                                                                    @"gender":self.user.gender?self.user.gender:@"",
                                                                    @"birth":self.user.birth?self.user.birth:@"",
                                                                    @"hobbile":self.user.hobbile?self.user.hobbile:@"",
                                                                    @"homeTown":self.user.homeTown?self.user.homeTown:@"",
                                                                    @"room":self.user.room?self.user.room:@""}];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserInfoToServer)];
    [saveButton setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    
   
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
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myImformationIdentifire];
    
    if (indexPath.section == 0)
    {
        MyImformationInputTableViewCell *inputCell = [tableView dequeueReusableCellWithIdentifier:myImformationInputIdentifire];
        if (!inputCell)
        {
            inputCell = [[MyImformationInputTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationInputIdentifire];
        }
        NSString *key = _titleArr[indexPath.section][indexPath.row];
        inputCell.textLabel.text = NSLocalizedString(key, nil);
        
        inputCell.inputTextFeild.delegate = self;
        inputCell.inputTextFeild.placeholder = [_placeholder objectForKey:key];
        inputCell.inputTextFeild.text = [_cellContent objectForKey:key];
        inputCell.inputTextFeild.tag = 101 + indexPath.row;
        return inputCell;
    }
    else
    {
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myImformationIdentifire];
        }
        cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
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
        AddressManagerViewController *vc = [[AddressManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -- textfield delegate --
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSUInteger row = textField.tag - 101;
    NSString *key = [[_titleArr objectAtIndex:0] objectAtIndex:row];
    NSString *value = textField.text;
    [_cellContent setValue:value?value:@""
                    forKey:key];
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.tableView reloadData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIView *supView = [textField superview];
    CGFloat position = 0 + textField.frame.origin.y;
    while (supView != nil && supView != self.view)
    {
        position += supView.frame.origin.y;
        supView = [supView superview];
    }
    
    CGFloat offset = position + textField.frame.size.height + 64 - (DeviceHeight/2) - self.tableView.contentOffset.y;
    if(offset > 0)
    {
        CGPoint oldPoint = self.tableView.contentOffset;
        [self.tableView setContentOffset:CGPointMake(oldPoint.x, oldPoint.y + offset) animated:YES];
    }
    
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isDragging])
    {
        [self.view endEditing:YES];
    }
}





- (void)saveUserInfoToServer
{
    NSArray *reqArr = @[self.user.identifyName,
                        @"weqweqweqwe",
                        [_cellContent objectForKey:@"gender"],
                        @"address",
                        [_cellContent objectForKey:@"room"],
                        [_cellContent objectForKey:@"birth"],
                        [_cellContent objectForKey:@"hobbile"],
                        [_cellContent objectForKey:@"homeTown"],
                        [_cellContent objectForKey:@"nickName"]
                        ];
    
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:reqArr
                             WithPath:ModifyUserPath
                         successBlock:^(id successJsonData)
    {
        NSLog(@"%@",successJsonData);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        
    }];
}



@end
