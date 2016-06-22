//
//  RegisterNextViewController.m
//  policyManager
//
//  Created by tru on 15/10/8.
//  Copyright (c) 2015年 创必承. All rights reserved.
//

#import "RegisterNextViewController.h"

@interface RegisterNextViewController ()

@end

@implementation RegisterNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];

    
    int height = 30;
    
    for (int i = 0; i < 4; i++) {
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
    
    phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(middleView.right+10, height, DeviceWidth-middleView.right-20, 44)];
    phoneTextField.placeholder = @"请输入11位手机号码";
    phoneTextField.delegate = self;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneTextField];
    
    
    vertificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, height+44, 200, 44)];
    vertificationTextField.placeholder = @"请输入验证码";
    vertificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    vertificationTextField.delegate = self;
    vertificationTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:vertificationTextField];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(DeviceWidth-125, vertificationTextField.top+7, 1, 30)];
    
    lineView.backgroundColor = RGBA(240, 240, 240, 1);
    [self.view addSubview:lineView];
    
    UIButton *sendVertify = [UIButton buttonWithType:UIButtonTypeCustom];
    sendVertify.frame = CGRectMake(DeviceWidth-120, vertificationTextField.top+7, 110, 30);
    [sendVertify setTitle:@"发送验证码" forState:0];
    sendVertify.layer.cornerRadius = 5;
    sendVertify.clipsToBounds = YES;
    [sendVertify setTitleColor:[UIColor grayColor] forState:0];
    [sendVertify addTarget:self action:@selector(getVertificationAgain:) forControlEvents:UIControlEventTouchUpInside];
    sendVertify.titleLabel.font = Font(14);
    
    [self.view addSubview:sendVertify];
    
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, vertificationTextField.bottom, DeviceWidth-40, 44)];
    passwordTextField.placeholder = @"请设置登录密码";
    passwordTextField.textColor = RGBA(51, 51, 51, 1);
    passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
    [self.view addSubview:passwordTextField];
    
    
    UIButton *netButton = [UIButton buttonWithType:UIButtonTypeCustom];
    netButton.frame = CGRectMake(20, passwordTextField.bottom+30, DeviceWidth-40, 44);
    [netButton setTitle:@"下一步" forState:0];
    [netButton setTitleColor:[UIColor whiteColor] forState:0];
    netButton.layer.cornerRadius = 5;
    [netButton setBackgroundColor:[UIColor greenColor]];
    netButton.titleLabel.font = Font(14);
    [netButton addTarget:self action:@selector(registerNextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:netButton];
    
    
    UILabel *descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth/2-130, netButton.bottom+30, 260, 40)];
    descriptionLable.text = @"注册代表您已同意美邻说用户协议\n[目前只开通广州地区，其他地区敬请期待]";
    descriptionLable.font = Font(13);
    descriptionLable.numberOfLines = 0;
    descriptionLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:descriptionLable];

    
    
}
#pragma mark --------------------------------获取验证码
-(void)getVertificationAgain:(UIButton *)sender
{
    if ([Utility isMobileNumber:phoneTextField.text]) {
        [self countdown:sender];
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:phoneTextField.text,@"phone", nil];
        NSLog(@"dic = %@",params);
        NSArray *paramas = @[phoneTextField.text];
        [NetworkEngine postRequestWithUrl:AppService paramsArray:paramas WithPath:GetVerifyCodePath successBlock:^(id successJsonData) {
            NSLog(@"successJsonData = %@",successJsonData);
        } errorBlock:^(int code, NSString *errorJsonData) {
            NSLog(@"errorJsonData = %@",errorJsonData);
            
        }];
    }else
    {
        NSLog(@"请检查您的手机号码是否正确");
    }

    
}
#pragma mark --------------------------------倒计时
-(void)countdown:(UIButton *)sender
{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                sender.titleLabel.font = Font(14);
                sender.titleLabel.textAlignment = NSTextAlignmentCenter;
//                [sender setBackgroundColor:RGBA(39, 122, 194, 1)];
                sender.userInteractionEnabled=YES;
            });
        }else{
            int seconds = timeout % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                sender.titleLabel.font = Font(14);
                sender.titleLabel.textAlignment = NSTextAlignmentCenter;
                [sender setTitle:[NSString stringWithFormat:@"%.2d秒后重新获取", seconds] forState:UIControlStateNormal];
//                [sender setBackgroundColor:RGBA(177, 178, 179, 1)];
                sender.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}
#pragma mark ------------------下一步
-(void)registerNextButtonAction
{
    
//    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
//    registerVC.phoneString = phoneTextField.text;
//    registerVC.password = passwordTextField.text;
//    registerVC.code = vertificationTextField.text;
//    [self.navigationController pushViewController:registerVC animated:YES];
    
    if ([Utility isMobileNumber:phoneTextField.text]) {
        
        if (vertificationTextField.text.length) {
            if (passwordTextField.text.length) {
                RegisterViewController *registerVC = [[RegisterViewController alloc] init];
                registerVC.phoneString = phoneTextField.text;
                registerVC.password = passwordTextField.text;
                registerVC.code = vertificationTextField.text;
                [self.navigationController pushViewController:registerVC animated:YES];
            }else
            {
                NSLog(@"密码不能为空");
                [NetworkEngine showHUDString:@"密码不能为空" Withshowtime:2 WithView:self.view];
            }
        }else
        {
            NSLog(@"验证码不能为空");
            [NetworkEngine showHUDString:@"验证码不能为空" Withshowtime:2 WithView:self.view];

        }
    }else
    {
        NSLog(@"您输入的手机号码不正确");
        [NetworkEngine showHUDString:@"您输入的手机号码不正确" Withshowtime:2 WithView:self.view];

    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneTextField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }else if(textField == vertificationTextField)
    {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 6) {
            return NO;
        }
    }
    
    return YES;
}
-(void)textfielddidChange:(UITextField *)textField
{
    if (textField == phoneTextField) {
        if (textField.text.length>11) {
            textField.text = [textField.text substringFromIndex:11];
        }
    }else if(textField == vertificationTextField)
    {
        if (textField.text.length>6) {
            textField.text = [textField.text substringFromIndex:6];
        }
    }
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
