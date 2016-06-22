//
//  ForgetPasswordViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "NetworkEngine.h"
#import "NSString+expanded.h"

#import "AFNetworking.h"
@interface ForgetPasswordViewController ()
@property(nonatomic,strong)NSString * OldPassword;
@property(nonatomic,strong)NSString * NewPassword;
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    self.view.backgroundColor = [UIColor whiteColor];
    _NewPassword=@"123456";
    _OldPassword=@"111111";
  
    NSArray * array =@[@"18825158710",_OldPassword.md5,_NewPassword.md5];
  
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:@"modifyUserPass" successBlock:^(id successJsonData) {
        NSLog(@"成功%@",successJsonData);
    } errorBlock:^(int code, NSString *errorJsonData) {
         NSLog(@"错误%@",errorJsonData);
    }];
    
    
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
