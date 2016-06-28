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
#import "UIImageView+WebCache.h"

#import "LCActionSheet.h"

@interface MyImformationViewController ()<UITextFieldDelegate,LCActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray *_titleArr;
    NSDictionary *_placeholder;
    NSMutableDictionary *_cellContent;
    
    UIImageView *_userHeadImg;
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
    [saveButton setEnabled:NO];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    
   
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 120)];
    topView.backgroundColor = [UIColor whiteColor];
    
    
    _userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 80, 80)];
    
    [_userHeadImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTURL,self.user.headIcon]] placeholderImage:[UIImage imageNamed:@"上传头像"]];
    
    _userHeadImg.layer.cornerRadius = _userHeadImg.frame.size.width/2;
    _userHeadImg.clipsToBounds = YES;
    [_userHeadImg setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnUploadHeadIcon:)];
    singleGesture.numberOfTapsRequired = 1;
    [_userHeadImg addGestureRecognizer:singleGesture];
    [topView addSubview:_userHeadImg];
    
    
    UILabel *quarterName = [[UILabel alloc] initWithFrame:CGRectMake(_userHeadImg.right+10, 20, 200, 20)];
    quarterName.text      = [NSString stringWithFormat:@"我的小区:%@",self.user.quarter.quarterName];
    quarterName.textColor = RGBA(51, 51, 51, 1);
    quarterName.font      = Font(_SUBTITLE_FONT_SIZE_);
    [topView addSubview:quarterName];
    
    
    UILabel *userLevelLable = [[UILabel alloc] initWithFrame:CGRectMake(_userHeadImg.right+10, (120 - 20)/2, 200, 20)];
    userLevelLable.text      = [NSString stringWithFormat:@"我的等级:LV%@",self.user.identityIntegral];
    userLevelLable.font      = Font(_DETAIL_FONT_SIZE_);
    userLevelLable.textColor = RGBA(93, 93, 93, 1);
    [topView addSubview:userLevelLable];
    
    ProgressView *progress = [[ProgressView alloc] initWithFrame:CGRectMake(_userHeadImg.right + 10, _userHeadImg.bottom -20, 200, 20)];
    [progress setProgressValue:0.71];
    [topView addSubview:progress];
    
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableHeaderView = topView;
    
    self.tableView.header = nil;
    self.tableView.footer = nil;
}

- (void)clickOnUploadHeadIcon:(id)sender
{
    [self uploadHeadImage];
}


#pragma mark ----------------选择图片上传
-(void)uploadHeadImage
{
    // 类方法
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:@"上传头像"
                                            buttonTitles:@[@"拍照", @"从相册选择"]
                                          redButtonIndex:-1
                                                delegate:self];
    [sheet show];
}
#pragma mark -----------------LCActionSheetDelegate
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 2)
    {
        return;
    }
    
    UIImagePickerControllerSourceType sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
        imagePickerController.allowsEditing=YES; //设置用户是否可以编辑图片
        imagePickerController.delegate=self;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        //[SVProgressHUD showErrorWithStatus:UI_language(@"本机不支持", @"Not Support")];
        NSLog(@"本机不支持");
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    if (!image)
    {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    _userHeadImg.image = image;
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
        cell.textLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
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
    
    [self.navigationItem.rightBarButtonItem setEnabled:YES];
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


- (void)saveUserInfoToServer
{
    NSData *imgData = UIImageJPEGRepresentation(_userHeadImg.image, 0.5);
    NSString *base64HeadImg = [imgData base64EncodedStringWithOptions:0];
    
    
    NSArray *reqArr = @[self.user.identifyName,
                        base64HeadImg,
                        [_cellContent objectForKey:@"gender"],
                        @"address",
                        [_cellContent objectForKey:@"room"],
                        [_cellContent objectForKey:@"birth"],
                        [_cellContent objectForKey:@"hobbile"],
                        [_cellContent objectForKey:@"homeTown"],
                        [_cellContent objectForKey:@"nickName"]
                        ];
    [self showLoading];
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:reqArr
                             WithPath:ModifyUserPath
                         successBlock:^(id successJsonData)
    {
        [self dismissShow];
        UserObject *user = [UserObject shareUser];
        [user updateInfo:successJsonData];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        [self showSuccess:@"保存成功!"];

    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        [self dismissShow];
    }];
}



@end
