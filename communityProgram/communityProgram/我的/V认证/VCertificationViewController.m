//
//  VCertificationViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "VCertificationViewController.h"

@interface VCertificationViewController ()

@end

@implementation VCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *topLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, DeviceWidth-20, 20)];
    topLable.text = @"认证一下您是南昌小区的住户";
    topLable.font = Font(16);
    [self.view addSubview:topLable];
    
    for (int i = 0; i < 2; i++) {
        UILabel *leftLable = [[UILabel alloc] initWithFrame:CGRectMake(5, topLable.bottom+100, 100, 20)];
        leftLable.text = @"单元号";
        [self.view addSubview:leftLable];
        
        
        UITextField *rightTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, topLable.bottom+100, 140, 40)];
        
        [self.view addSubview:rightTextField];
    }
    
    // Do any additional setup after loading the view.
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
