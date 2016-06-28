//
//  attentionTableViewController.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "attentionTableViewController.h"

@implementation attentionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的关注";
    
    UISegmentedControl *segCtrl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(20, 5, DeviceWidth - 40, 30)];
    [segCtrl insertSegmentWithTitle:@"我的关注" atIndex:0 animated:NO];
    [segCtrl insertSegmentWithTitle:@"关注我的" atIndex:1 animated:NO];
    [segCtrl setTintColor:RGBA(68, 180, 17, 1)];
    [segCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_]} forState:UIControlStateNormal];
    [segCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_]} forState:UIControlStateSelected];
    [segCtrl addTarget:self action:@selector(clickOnSeg:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segCtrl];
    
    self.tableView.frame = CGRectMake(0, 50, DeviceWidth, DeviceHeight - kSTATUSBAR_HEIGHT - kNAVIGATION_HEIGHT - 40);
    
}

- (void)clickOnSeg:(id)sender
{
    
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_TITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor blackColor]};
    return [[NSAttributedString alloc] initWithString:@"您还没有关注过任何人" attributes:attribute];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:@"去寻找您身边的左邻右舍吧!" attributes:attribute];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"attentionEmpty"];
}


@end
