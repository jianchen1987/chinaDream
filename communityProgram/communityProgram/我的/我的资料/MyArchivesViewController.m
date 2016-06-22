//
//  MyArchivesViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/7.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyArchivesViewController.h"

@interface MyArchivesViewController ()

@end

@implementation MyArchivesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的档案";
    self.view.backgroundColor = RGBA(236, 234, 238, 1);
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 160)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth/2-40, 20, 80, 80)];
    headImageView.image = [UIImage imageNamed:@"commendImage"];
    [headView addSubview:headImageView];
    
    
    UITextField *menu_tf = [[UITextField alloc] initWithFrame:CGRectMake(DeviceWidth/2-100, headImageView.bottom+10, 200, 30)];
    menu_tf.placeholder = @"请输入单元号";
    menu_tf.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:menu_tf];
    
    
    UILabel *nickNameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, headView.bottom+10, DeviceWidth-40, 40)];
    nickNameLable.backgroundColor = [UIColor whiteColor];
    nickNameLable.text = @"测试单元";
    nickNameLable.layer.cornerRadius = 5;
    nickNameLable.clipsToBounds = YES;
    nickNameLable.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nickNameLable];
    
    NSArray *sexArray = @[@"男",@"女"];
    
    for (int i = 0; i < 2; i++) {
        UIButton *sexButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sexButton.frame = CGRectMake((DeviceWidth-160)/2+80*i, nickNameLable.bottom+20, 80, 40);
        [sexButton setTitle:[sexArray objectAtIndex:i] forState:0];
        [sexButton setTitleColor:[UIColor grayColor] forState:0];
        sexButton.layer.cornerRadius = sexButton.width/2;
        sexButton.clipsToBounds = YES;
        [self.view addSubview:sexButton];
    }
    
    
    
    
    
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
