//
//  WaittingPaymentViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//


#import "WaittingPaymentViewController.h"

@interface WaittingPaymentViewController ()

@end

@implementation WaittingPaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}


- (void)pullDown:(_Nonnull id)sender
{
    [orderViewModel getOrdersByUser:self.user
                       SuccessBlock:^(NSArray *orders)
     {
         [self.dataSource addObjectsFromArray:@[@"1",@"2",@"3"]];
         [self.tableView reloadData];
         [self.tableView reloadEmptyDataSet];
         [super pullDown:sender];
     }
                       FailureBlock:^(int code, NSString *errMsg)
     {
         [self showPrompt:errMsg];
         [super pullDown:sender];
     }];
}
- (void)pullUp:(_Nonnull id)sender
{
    [super pullUp:sender];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderListTableViewCell *cell = nil;
    if(indexPath.section == 1)
    {
        static NSString *identify2 = @"style2";
        cell = [tableView dequeueReusableCellWithIdentifier:identify2];
        if(!cell)
        {
            cell = [[orderListTableViewCell alloc] initWithUpStyle:OrderListTableViewCellUpStyleMutable
                                                       BottomStyle:OrderListTableViewCellBottomStylePrice
                                                   reuseIdentifier:identify2];
        }
        
        [cell.previewImgView1 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        [cell.previewImgView2 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        [cell.previewImgView3 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        cell.upDetailsLabel.text = @"一共5款商品";
    }
    else
    {
        static NSString *style1 = @"style1";
        cell = [tableView dequeueReusableCellWithIdentifier:style1];
        if(!cell)
        {
            cell = [[orderListTableViewCell alloc] initWithUpStyle:OrderListTableViewCellUpStyleNormal
                                                       BottomStyle:OrderListTableViewCellBottomStylePrice
                                                   reuseIdentifier:style1];
        }
        
        [cell.previewImgView1 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        cell.upTitleLabel.text = @"山东大苹果";
        cell.upDetailsLabel.text = @"烟台苹果是山东名优特产之一，产地以烟台辖区内的栖霞市、龙口市";
        [cell setCostAmt:[NSNumber numberWithFloat:99.22]];
    }
    
    
    [cell.button2 setTitle:@"删除订单" forState:UIControlStateNormal];
    cell.button2.tag = 3000 + indexPath.section;
    [cell.button2 addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.button3 setTitle:@"立即付款" forState:UIControlStateNormal];
    cell.button3.tag = 6000 + indexPath.section;
    [cell.button3 addTarget:self action:@selector(payNow:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}







@end
