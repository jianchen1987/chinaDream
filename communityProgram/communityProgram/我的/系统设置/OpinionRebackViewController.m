//
//  OpinionRebackViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/7.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "OpinionRebackViewController.h"

@interface OpinionRebackViewController ()

@end

@implementation OpinionRebackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = RGBA(234, 236, 238, 1);

    UILabel *descriptionLable = [RHMethods labelWithFrame:CGRectMake(20, 10, DeviceWidth-40, 40) font:Font(14) color:[UIColor grayColor] text:@"欢迎您提出宝贵的意见或建议，您留下的每一个字都能使我们做得更好"];
    descriptionLable.numberOfLines = 0;
    
    [self.view addSubview:descriptionLable];
    
    
    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, descriptionLable.bottom+10, DeviceWidth-40, 100)];
    myTextView.backgroundColor = [UIColor whiteColor];
    myTextView.text = @"请输入您的反馈意见(500字以内)";
    myTextView.textColor = RGBA(240, 240, 240, 1);
    myTextView.delegate = self;
    
    [self.view addSubview:myTextView];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(10, myTextView.bottom+20, DeviceWidth-20, 44);
    [submitButton setBackgroundImage:[UIImage imageNamed:@""] forState:0];
    [submitButton setTitle:@"提交" forState:0];
    [submitButton addTarget:self action:@selector(submitButtonActin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入您的反馈意见(500字以内)"]) {
        textView.text = @"";
        textView.textColor = RGBA(51, 51, 51, 1);
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入您的反馈意见(500字以内)"]) {
        textView.textColor = RGBA(240, 240, 240, 1);
    }
}
-(void)submitButtonActin
{
    if ([myTextView.text isEqualToString:@"请输入您的反馈意见(500字以内)"]) {
        NSLog(@"请填写反馈信息");
    }else
    {
        NSArray *array = @[[Utility defaultsForKey:@"userID"],myTextView.text];
        [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:@"submitSubject" successBlock:^(id successJsonData) {
            NSLog(@"successJsonData = %@",successJsonData);
        } errorBlock:^(int code, NSString *errorJsonData) {
            NSLog(@"errorJsonData = %@",errorJsonData);

        }];
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
