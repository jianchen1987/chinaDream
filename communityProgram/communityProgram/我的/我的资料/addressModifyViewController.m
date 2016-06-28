//
//  addressModifyViewController.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "addressModifyViewController.h"
#import "myLabel.h"
#import "addressModify1TableViewCell.h"
#import "addressModify2TableViewCell.h"
#import "addressModel.h"
#import "addressViewModel.h"

#define _QUARTERNAME_ 101
#define _LEVELROOM_   102
#define _SENDNAME_    103
#define _PHONE_       104



@interface addressModifyViewController ()<UITextFieldDelegate>
{
    NSArray *_sectionViewArr;
    NSArray *_placeHolderArr;
    
    UIButton *_saveButton;
}

@end

@implementation addressModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.addressModel)
    {
        self.addressModel = [[addressModel alloc] init];
    }
    self.addressModel.identityName = self.user.identifyName;
    
    _sectionViewArr = @[@"所在地区:",@"详细地址:",@"收货人:",@"联系电话:",@""];
    _placeHolderArr = @[@"小区名",@"请输入详细地址(如单元、楼栋号)",@"请输入收货人姓名",@"请输入收货人联系电话",@""];
    
    self.title = @"收货地址管理";
    
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - kSTATUSBAR_HEIGHT - kNAVIGATION_HEIGHT - kTABBAR_HEIGHT);
    
    UIView *toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, DeviceHeight - kNAVIGATION_HEIGHT - kSTATUSBAR_HEIGHT - kTABBAR_HEIGHT, DeviceWidth, kTABBAR_HEIGHT)];
    
    UIImageView *toolbarBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, kTABBAR_HEIGHT)];
    toolbarBg.image = [UIImage imageNamed:@"tabBarImage"];
    [toolBar addSubview:toolbarBg];
    
    if(!self.newOrModify)  //新增没有
    {
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kTABBAR_HEIGHT, kTABBAR_HEIGHT)];
        [cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        [cancelBtn setBackgroundImage:[UIImage imageNamed:@"订单列表按钮"] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(delAddress:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:cancelBtn];
    }
    
    _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(DeviceWidth - 100 - 10, (kTABBAR_HEIGHT - 39)/2, 100, 39)];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
    [_saveButton setBackgroundImage:[UIImage imageNamed:@"地址保存-资料还未填好"] forState:UIControlStateDisabled];
    [_saveButton setBackgroundImage:[UIImage imageNamed:@"地址保存"] forState:UIControlStateNormal];
    if(self.newOrModify)
    {
        [_saveButton addTarget:self action:@selector(newAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [_saveButton addTarget:self action:@selector(modifyAddress:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_saveButton setEnabled:NO];
    [toolBar addSubview:_saveButton];
    
    //self.addressModel.isDefault = [_saveButton isEnabled];
    
    
    [self.view addSubview:toolBar];
    
    self.tableView.header = nil;
    self.tableView.footer = nil;
    
}

- (void)delAddress:(id)sender
{
    [self showLoading];
    [addressManagerViewModel delUserReceiveAddress:self.addressModel
                                      SuccessBlock:^(BOOL result)
    {
        [self dismissShow];
        if(result)
        {
            [self showSuccess:@"删除成功!"];
        }
        else
        {
            [self showSuccess:@"删除失败!"];
        }
    }
                                      FailureBlock:^(int errCode, NSString *errMsg)
    {
        [self dismissShow];
        [self showPrompt:errMsg];
    }];
}

- (void)newAddress:(id)sender
{
    [self showLoading];
    [addressManagerViewModel addUserReceiveAddress:self.addressModel SuccessBlock:^(NSArray *address)
    {
        [self dismissShow];
        [self showSuccess:@"新增成功!"];
        [_saveButton setEnabled:NO];
    }
                                      FailureBlock:^(int errCode, NSString *errMsg)
    {
        [self dismissShow];
        [self showPrompt:errMsg];
    }];
}

- (void)modifyAddress:(id)sender
{
    [self showLoading];
    [addressManagerViewModel modifyUserReveiveAddress:self.addressModel
                                         SuccessBlock:^(NSArray *address)
    {
        [self dismissShow];
        [self showSuccess:@"修改成功!"];
        [_saveButton setEnabled:NO];
    }
                                         FailureBlock:^(int errCode, NSString *errMsg)
    {
        [self dismissShow];
        [self showPrompt:errMsg];
    }];
}




#pragma mark -- tableView delegate --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if(self.newOrModify)
//    {
//        //新增地址 不显示设置默认
//        return _sectionViewArr.count - 1;
//    }
//    else
//    {
        return _sectionViewArr.count;
//    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 30)];
    sectionView.backgroundColor = [UIColor whiteColor];
    
    myLabel *label = [[myLabel alloc] initWithText:NSLocalizedString([_sectionViewArr objectAtIndex:section], nil) FontSize:_SUBTITLE_FONT_SIZE_ MaxWidth:DeviceWidth];
    CGRect frame = label.frame;
    label.textColor = RGBA(98, 98, 98, 1);
    label.frame = CGRectMake(10, (30 - frame.size.height)/2, frame.size.width, frame.size.height);
    [sectionView addSubview:label];
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == (_sectionViewArr.count - 1))
    {
        return 0.001f;
    }
    else
    {
        return 30.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *style1 = @"style1";
    static NSString *style2 = @"style2";
    
    if(indexPath.section == (_sectionViewArr.count - 1))
    {
        addressModify2TableViewCell *cell2 = [self.tableView dequeueReusableCellWithIdentifier:style2];
        if(!cell2)
        {
            cell2 = [[addressModify2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:style2];
            cell2.textLabel.text = @"设置为默认地址";
            cell2.textLabel.font = [UIFont systemFontOfSize:_TITLE_FONT_SIZE_];
            
            [cell2.checkBoxBtn addTarget:self action:@selector(clickOnCheckBox:) forControlEvents:UIControlEventTouchUpInside];
            if(self.addressModel.isDefault)
            {
                [cell2.checkBoxBtn setSelected:YES];
            }
        }
        
        return cell2;
    }
    else
    {
        addressModify1TableViewCell *cell1 = [self.tableView dequeueReusableCellWithIdentifier:style1];
        if(!cell1)
        {
            cell1 = [[addressModify1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:style1];
            cell1.textField.delegate = self;
        }
        cell1.textField.placeholder = [_placeHolderArr objectAtIndex:indexPath.section];
        cell1.textField.tag = 101 + indexPath.section;
        cell1.textField.text = [self showContentByTag:cell1.textField.tag];
        
        return cell1;

    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark -- textField delegate --
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case _QUARTERNAME_:
        {
            self.addressModel.quarterName = textField.text;
        }
            break;
        case _LEVELROOM_:
        {
            self.addressModel.levelRoom = textField.text;
        }
            break;
        case _SENDNAME_:
        {
            self.addressModel.sendName = textField.text;
        }
            break;
        case _PHONE_:
        {
            self.addressModel.phone = textField.text;
        }
        default:
            break;
    }
    
    [_saveButton setEnabled:YES];
}


- (NSString *)showContentByTag:(NSUInteger)tag
{
    NSString *result = nil;
    switch (tag)
    {
        case _QUARTERNAME_:
        {
            result = self.addressModel.quarterName;
        }
            break;
        case _LEVELROOM_:
        {
            result = self.addressModel.levelRoom;
        }
            break;
        case _SENDNAME_:
        {
            result = self.addressModel.sendName;
        }
            break;
        case _PHONE_:
        {
            result = self.addressModel.phone;
        }
            break;
        default:
            break;
    }
    
    return result;
}

- (void)clickOnCheckBox:(id)sender
{
    UIButton *button  = (UIButton *)sender;
    
    if(self.newOrModify)
    {
        [self showPrompt:@"请先添加地址"];
        return;
    }
    
    if(![button isSelected])
    {
        [self showLoading];
        [addressManagerViewModel setUserDefaultAddress:self.addressModel
                                          SuccessBlock:^(BOOL result)
        {
            [self dismissShow];
            [self showSuccess:@"设置成功"];
            [button setSelected:YES];
             self.addressModel.isDefault = YES;
        }
                                          FailureBlock:^(int errCode, NSString *errMsg)
        {
            [self dismissShow];
            [self showPrompt:errMsg];
        }];
    }
//    else
//    {
//        [button setSelected:NO];
//        self.addressModel.isDefault = NO;
//    }
    
}



@end
