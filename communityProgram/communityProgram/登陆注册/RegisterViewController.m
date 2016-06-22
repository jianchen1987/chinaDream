//
//  RegisterViewController.m
//  policyManager
//
//  Created by tru on 15/7/16.
//  Copyright (c) 2015年 高国峰. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    UIScrollView *scrollView;
    UIButton *targetBtn;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];

    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth/2-50, 30, 100, 100)];
    headImageView.image = [UIImage imageNamed:@""];
    headImageView.backgroundColor = [UIColor grayColor];
    headImageView.layer.cornerRadius = headImageView.width/2;
    headImageView.clipsToBounds = YES;
    headImageView.userInteractionEnabled = YES;
    [headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadHeadImage)]];
    [self.view addSubview:headImageView];
    
    
    for (int i = 0; i < 2; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, headImageView.bottom+40+44*i, DeviceWidth-10, 1)];
        lineView.backgroundColor = RGBA(240, 240, 240, 1);
        [self.view addSubview:lineView];
    }

    nicknameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, headImageView.bottom+40, DeviceWidth-60, 44)];
    nicknameTextField.placeholder = @"请输入昵称";
    [self.view addSubview:nicknameTextField];
    
    UILabel *desLable = [[UILabel alloc] initWithFrame:CGRectMake(30, nicknameTextField.bottom+5, DeviceWidth-60, 20)];
    desLable.text = @"15个字符以内，不包含特殊字符";
    desLable.font = Font(13);
    desLable.textColor = RGBA(153, 153, 153, 1);
    [self.view addSubview:desLable];
    
    
    NSArray *selectHeadTitleArray = @[@"男",@"女"];
    for (int i = 0; i < 2; i++) {
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(DeviceWidth/2*i, desLable.bottom+30, DeviceWidth/2, 30);
        selectButton.tag = 1000+i;
        [selectButton setImage:[UIImage imageNamed:@"vertification_non"] forState:0];
        [selectButton setImage:[UIImage imageNamed:@"vertification_select"] forState:UIControlStateSelected];
        [selectButton setTitle:selectHeadTitleArray[i] forState:0];
        [selectButton setTitleColor:[UIColor grayColor] forState:0];
        selectButton.titleLabel.font = Font(13);
        selectButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        selectButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 7);
        if (i== 0) {
            selectButton.selected = YES;
            targetBtn = selectButton;
        }
        [selectButton addTarget:self action:@selector(selectAdictionAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:selectButton];
    }


    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, desLable.bottom+40+50, DeviceWidth-20, 44);
    button.layer.cornerRadius = 5;
    [button setTitle:@"注册" forState:UIControlStateNormal];
    button.layer.cornerRadius = 22;
    [button setBackgroundColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
 
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth/2-100, button.bottom+5, 200, 20)];
    lable.text = @"个人资料可更改更多设置";
    lable.font = Font(13);
    [self.view addSubview:lable];
}
#pragma mark ----------------选择性别
-(void)selectAdictionAction:(UIButton *)sender
{
    if (sender == targetBtn) {
        return;
    }else
    {
        targetBtn.selected = !targetBtn.selected;
        sender.selected = YES;
        targetBtn = sender;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (DeviceHeight == 480) {
        if (textField.tag == 11001)
        {
            [UIView beginAnimations:@"moveAnimation" context:@"move"];//设置动画名称和参数信息.可以用来传值;
            [UIView setAnimationDuration:0.2];//设置动画时长
            [UIView setAnimationDelegate:self];//设置动画代理
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//设置动画缓进缓出
            [self.view setFrame:CGRectMake(0, -10, DeviceWidth, DeviceHeight)];
            [UIView commitAnimations];//提交动画 动画的开始.
        }
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (DeviceHeight == 480)
    {
        if (textField.tag == 11001)
        {
            [UIView beginAnimations:@"moveAnimation" context:@"move"];//设置动画名称和参数信息.可以用来传值;
            [UIView setAnimationDuration:0.2];//设置动画时长
            [UIView setAnimationDelegate:self];//设置动画代理
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//设置动画缓进缓出
            [self.view setFrame:CGRectMake(0, 64, DeviceWidth, DeviceHeight)];
            [UIView commitAnimations];//提交动画 动画的开始.
            
        }
    }
    


}
-(void)clickEyeButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.tag == 4001) {
        UITextField *tf_password = (UITextField *)[self.view viewWithTag:11001];
        if (sender.selected) {
            tf_password.secureTextEntry = NO;
        }else
        {
            tf_password.secureTextEntry = YES;
        }
    }else
    {
        UITextField *tf_secondPassword = (UITextField *)[self.view viewWithTag:11002];
        if (sender.selected) {
            tf_secondPassword.secureTextEntry = NO;
        }else
        {
            tf_secondPassword.secureTextEntry = YES;
        }
    }
}

#pragma mark ----------------选择图片上传
-(void)uploadHeadImage
{
    // 类方法
    LCActionSheet *sheet = [LCActionSheet sheetWithTitle:nil
                                            buttonTitles:@[@"拍照", @"从相册选择"]
                                          redButtonIndex:-1
                                                delegate:self];
    [sheet show];
}
#pragma mark -----------------LCActionSheetDelegate
- (void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 2) {
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
        
    }else{
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
    headImageView.image = image;
    

    

}
#pragma mark ---------------注册账号
-(void)registerButtonAction
{
    [self.view endEditing:YES];
    if (nicknameTextField.text.length) {
        NSArray *array = @[self.phoneString,self.password.md5,self.code,targetBtn.titleLabel.text,nicknameTextField.text];
        [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:RegisterPath successBlock:^(id successJsonData) {
            NSLog(@"successJsonData = %@",successJsonData);
            if (successJsonData) {
                [Utility saveToDefaults:[successJsonData valueForKey:@"gender"] forKey:@"gender"];
                [Utility saveToDefaults:[successJsonData valueForKey:@"nickName"] forKey:@"nickName"];
                [Utility saveToDefaults:[successJsonData valueForKey:@"id"] forKey:@"userID"];
                [Utility saveToDefaults:[successJsonData valueForKey:@"phone"] forKey:@"phone"];
                
                GetCommunityViewController *getCommunityVC  = [GetCommunityViewController new];
                getCommunityVC.userDic = successJsonData;
                [self.navigationController pushViewController:getCommunityVC animated:YES];
            }
            
        } errorBlock:^(int code, NSString *errorJsonData) {
            NSLog(@"errorJsonData = %@",errorJsonData);
            [NetworkEngine showHUDString:errorJsonData Withshowtime:2 WithView:self.view];
        }];
    }else
        NSLog(@"请输入昵称");
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
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
