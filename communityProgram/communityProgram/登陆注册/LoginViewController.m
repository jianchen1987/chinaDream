//
//  LoginViewController.m
//  PulanManager
//
//  Created by tru on 15/11/3.
//  Copyright © 2015年 创必承. All rights reserved.
//

#import "LoginViewController.h"
#import "UserObject.h"
@interface LoginViewController ()
{
    UITextField *phoneNumber_tf; //账号输入
    UITextField *password_tf; //密码输入
    UIButton *login_btn;//登陆按钮
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登陆";
    

    int height = 30;
    
    for (int i = 0; i < 3; i++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, height+44*i, DeviceWidth-10, 1)];
        lineView.backgroundColor= RGBA(240, 240, 240, 1);
        
        [self.view addSubview:lineView];
    }
    
    UILabel *nativeLable = [[UILabel alloc] initWithFrame:CGRectMake(5, height, 80, 44)];
    nativeLable.text = @"+86";
    nativeLable.font = Font(16);
    nativeLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nativeLable];

    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(nativeLable.right, height+3, 1, 44-6)];
    middleView.backgroundColor = RGBA(240, 240, 240, 1);
    [self.view addSubview:middleView];
    
    phoneNumber_tf = [[UITextField alloc] initWithFrame:CGRectMake(middleView.right+10, height, DeviceWidth-middleView.right-20, 44)];
    phoneNumber_tf.placeholder = @"请输入11位手机号码";
    phoneNumber_tf.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumber_tf.delegate = self;
    [self.view addSubview:phoneNumber_tf];
    
    
    password_tf = [[UITextField alloc] initWithFrame:CGRectMake(20, phoneNumber_tf.bottom, 200, 44)];
    password_tf.placeholder = @"密码";
    password_tf.keyboardType = UIKeyboardTypeAlphabet;
    password_tf.delegate = self;
    [self.view addSubview:password_tf];
    
    
    login_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    login_btn.frame = CGRectMake(10, password_tf.bottom+40, DeviceWidth-20, 44);
    [login_btn setTitle:@"登录" forState:0];
    [login_btn setBackgroundColor:[UIColor greenColor]];
    [login_btn.layer setCornerRadius:5];
    [login_btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login_btn];

    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(10, login_btn.bottom+20, 100, 30);
    [forgetButton setTitle:@"忘记密码" forState:0];
    [forgetButton setTitleColor:[UIColor grayColor] forState:0];
    forgetButton.titleLabel.font = Font(14);
    [forgetButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetButton];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake((DeviceWidth - 100)/2, login_btn.bottom+20, 100, 30);
    [cancelButton setTitle:@"取消" forState:0];
    [cancelButton setTitleColor:[UIColor grayColor] forState:0];
    cancelButton.titleLabel.font = Font(14);
    [cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(DeviceWidth-10-60, login_btn.bottom+20, 60, 30);
    [registerButton setTitle:@"注册" forState:0];
    [registerButton setTitleColor:[UIColor grayColor] forState:0];
    registerButton.titleLabel.font = Font(14);
    [registerButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneNumber_tf) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    return YES;
}
-(void)textfielddidChange:(UITextField *)textField
{
    if (textField == phoneNumber_tf) {
        if (textField.text.length>11) {
            textField.text = [textField.text substringFromIndex:11];
        }
    }
}

-(void)clickEyeButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    UITextField *tf = [self.view viewWithTag:2001];
    if (sender.selected) {
        tf.secureTextEntry = NO;
    }else
    {
        tf.secureTextEntry = YES;
    }
}
#pragma mark -------------注册
-(void)registerButtonAction
{
    RegisterNextViewController *registerNextVC = [[RegisterNextViewController alloc] init];
    [self.navigationController pushViewController:registerNextVC animated:YES];
}
#pragma mark -----------buttonAction
-(void)buttonAction:(UIButton *)sender
{
    [self.view endEditing:YES];
    if ([sender.titleLabel.text isEqualToString:@"注册"])
    {
        NSLog(@"注册");
        [self.navigationController pushViewController:[RegisterNextViewController new] animated:YES];
    }
    else if([sender.titleLabel.text isEqualToString:@"忘记密码"])
    {
        
        ForgetPasswordViewController *forgetVC = [ForgetPasswordViewController new];
        [self.navigationController pushViewController:forgetVC animated:YES];

    }
    else if([sender.titleLabel.text isEqualToString:@"取消"])
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {        
        NSArray *loginArray = @[phoneNumber_tf.text,password_tf.text.md5];
        [NetworkEngine postRequestWithUrl:AppService
                              paramsArray:loginArray
                                 WithPath:LoginUserPath
                             successBlock:^(id successJsonData)
        {
            NSLog(@"successJsonData = %@",successJsonData);
            
            UserObject *user = [UserObject shareUser];
            [user updateInfo:successJsonData];
            if ([successJsonData valueForKey:@"quarter"])
            {
                [Utility saveToDefaults:[[successJsonData valueForKey:@"quarter"] valueForKey:@"id"] forKey:@"quarterID"];
            }
            
//            [NetworkEngine postRequestWithUrl:AppService paramsArray:@[user.identifyName] WithPath:GetUserLevel
//                                 successBlock:^(id successJsonData)
//            {
//                NSLog(@"%@",successJsonData);
//            }
//                                   errorBlock:^(int code, NSString *errorJsonData)
//            {
//               NSLog(@"errorJsonData = %@",errorJsonData);
//            }];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
                               errorBlock:^(int code, NSString *errorJsonData)
        {
            NSLog(@"errorJsonData = %@",errorJsonData);

        }];
    }
}
#pragma mark --------------登陆
-(void)clickLoginButtonAction
{
    [self.view endEditing:YES];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
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
