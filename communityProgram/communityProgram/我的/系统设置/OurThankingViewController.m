//
//  OurThankingViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/6.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "OurThankingViewController.h"

@interface OurThankingViewController ()

@end

@implementation OurThankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我们的理念";
    self.view.backgroundColor = RGBA(234, 236, 238, 1);

    
    
    //创建NSMutableAttributedString实例，并将text传入
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"以分享，互动为初衷\n为小区邻居提供便捷的\n交流交友线上平台\n急事难事求助迅速回应\n志趣相投的邻友爽快约起\n家中二手闲置轻松转让\n邻里情谊触手可及\n在这里，发现你身边的好邻居"];
    //创建NSMutableParagraphStyle实例
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    //设置行距
    [style setLineSpacing:10.0f];
    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attStr.length)];

    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, DeviceWidth-20, 25*10)];
    lable.attributedText = attStr;
    lable.numberOfLines = 0;
    [self.view addSubview:lable];

    
    
    
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
