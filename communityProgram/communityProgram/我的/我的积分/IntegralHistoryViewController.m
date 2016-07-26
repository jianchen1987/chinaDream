//
//  IntegralHistoryViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/16.
//  Copyright © 2015年 高国峰. All rights reserved.
//
static NSString *exchangeIdentifire = @"exchangeIdentifire";

#import "IntegralHistoryViewController.h"
#import "integralViewModel.h"
#import "IntegralRecordModel.h"


#define _INTEGRAL_HISTORY_RECORD_PAGE_SIZE_ 20

@implementation IntegralHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight- kSTATUSBAR_NAVIGATION_HEIGHT - kTABBAR_HEIGHT - 50);
    [self showLoading];
    [self pullDown:self.tableView.header];
}

-(void)pullDown:(id)sender
{
    if(!self.dataSource)
    {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    
    [integralViewModel getIntegralRecordHisByUser:self.user
                                        pageIndex:1
                                         pageSize:_INTEGRAL_HISTORY_RECORD_PAGE_SIZE_
                                     SuccessBlock:^(NSArray *arr)
    {
        [self dismissShow];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:arr];
        if(arr.count < _INTEGRAL_HISTORY_RECORD_PAGE_SIZE_)
        {
            [self.tableView.footer endRefreshingWithNoMoreData];
        }
        else
        {
            [self.tableView.footer resetNoMoreData];
        }
        [self reloadTableView];
        [super pullDown:sender];
    }
                                     FailureBlock:^(int code, NSString *errMsg)
    {
        [self dismissShow];
        [self showPrompt:errMsg];
        [super pullDown:sender];
    }];
}

- (void)pullUp:(id)sender
{
    if(!self.dataSource)
    {
        return;
    }
    
    if(self.dataSource.count < _INTEGRAL_HISTORY_RECORD_PAGE_SIZE_ )
    {
        return;
    }
    
    [integralViewModel getIntegralRecordHisByUser:self.user
                                        pageIndex:(self.dataSource.count/_INTEGRAL_HISTORY_RECORD_PAGE_SIZE_) + 1
                                         pageSize:_INTEGRAL_HISTORY_RECORD_PAGE_SIZE_
                                     SuccessBlock:^(NSArray *arr)
     {
         [self dismissShow];
         [self.dataSource removeAllObjects];
         [self.dataSource addObjectsFromArray:arr];
         if(arr.count < _INTEGRAL_HISTORY_RECORD_PAGE_SIZE_)
         {
             [self.tableView.footer endRefreshingWithNoMoreData];
         }
         else
         {
             [self.tableView.footer endRefreshing];
         }
         [self reloadTableView];
     }
                                     FailureBlock:^(int code, NSString *errMsg)
     {
         [self dismissShow];
         [self showPrompt:errMsg];
         [super pullUp:sender];
     }];
}








-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntrgraHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exchangeIdentifire];
    if (!cell) {
        cell = [[IntrgraHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exchangeIdentifire];
    }
    IntegralRecordModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell cellWithData:model];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}



@end
