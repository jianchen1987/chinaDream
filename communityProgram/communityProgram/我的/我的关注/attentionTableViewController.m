//
//  attentionTableViewController.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "attentionTableViewController.h"
#import "attentionViewModel.h"

@implementation attentionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的关注";
    
    self.tableView.frame = CGRectMake(0, 50, DeviceWidth, DeviceHeight - kSTATUSBAR_HEIGHT - kNAVIGATION_HEIGHT - 40);
    
    self.segCtrl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(20, 5, DeviceWidth - 40, 30)];
    [self.segCtrl insertSegmentWithTitle:@"我的关注" atIndex:0 animated:NO];
    [self.segCtrl insertSegmentWithTitle:@"关注我的" atIndex:1 animated:NO];
    [self.segCtrl setTintColor:RGBA(68, 180, 17, 1)];
    [self.segCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_]} forState:UIControlStateNormal];
    [self.segCtrl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_]} forState:UIControlStateSelected];
    [self.segCtrl addTarget:self action:@selector(clickOnSeg:) forControlEvents:UIControlEventValueChanged];
    self.segCtrl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segCtrl];
    
    [self getDataByType:self.segCtrl.selectedSegmentIndex];
    
}

- (void)clickOnSeg:(id)sender
{
    [self.dataSource removeAllObjects];
    [self getDataByType:self.segCtrl.selectedSegmentIndex];
    
    
}

- (void)getDataByType:(NSInteger)type
{
    [self showLoading];
    if(type == 0)
    {
        [attentionViewModel getAttentionUsersByUser:self.user
                                       SuccessBlock:^(NSArray *usersArr)
         {
             [self dismissShow];
             [self.dataSource addObjectsFromArray:usersArr];
             [self reloadTableView];
             
         } FailureBlock:^(int code, NSString *errMsg)
         {
             [self dismissShow];
             [self showPrompt:errMsg];
             [self reloadTableView];
         }];
    }
    else if(type == 1)
    {
        [attentionViewModel getUsersAttentionMy:self.user
                                   SuccessBlock:^(NSArray *usersArr)
         {
             [self dismissShow];
             [self.dataSource addObjectsFromArray:usersArr];
             [self reloadTableView];
             
         } FailureBlock:^(int code, NSString *errMsg)
         {
             [self dismissShow];
             [self showPrompt:errMsg];
             [self reloadTableView];
         }];
    }
}



#pragma mark -- empty delegate --
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSArray *title = @[@"您还没有关注过任何人",@"您还没有被任何人关注"];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_TITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor blackColor]};
    return [[NSAttributedString alloc] initWithString:title[self.segCtrl.selectedSegmentIndex] attributes:attribute];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSArray *detail = @[@"去寻找您身边的左邻右舍吧!",@"积极和您的左邻右舍互动赢得关注吧!"];
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:detail[self.segCtrl.selectedSegmentIndex] attributes:attribute];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"attentionEmpty"];
}


@end
