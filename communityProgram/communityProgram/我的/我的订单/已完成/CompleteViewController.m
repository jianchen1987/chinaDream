//
//  CompleteViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CompleteViewController.h"

@interface CompleteViewController ()

@end

@implementation CompleteViewController

- (void)viewDidLoad {
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
        static NSString *style2 = @"style2";
        cell = [tableView dequeueReusableCellWithIdentifier:style2];
        if(!cell)
        {
            cell = [[orderListTableViewCell alloc] initWithUpStyle:OrderListTableViewCellUpStyleMutable
                                                       BottomStyle:OrderListTableViewCellBottomStyleNormal
                                                   reuseIdentifier:style2];
        }
        [cell.previewImgView1 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        [cell.previewImgView2 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        [cell.previewImgView3 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        cell.upDetailsLabel.text = @"一共5款商品";
        
        
    }
    else
    {
        static NSString *style2 = @"style2";
        cell = [tableView dequeueReusableCellWithIdentifier:style2];
        if(!cell)
        {
            cell = [[orderListTableViewCell alloc] initWithUpStyle:OrderListTableViewCellUpStyleNormal
                                                       BottomStyle:OrderListTableViewCellBottomStyleNormal
                                                   reuseIdentifier:style2];
        }
        cell.upTitleLabel.text = @"新味道烟台苹果";
        cell.upDetailsLabel.text =  @"烟台苹果是山东名优特产之一，产地以烟台辖区内的栖霞市、龙口市";
        [cell.previewImgView1 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
    }
    
    [cell.button1 setTitle:@"删除订单" forState:UIControlStateNormal];
    cell.button1.tag = 1000 + indexPath.section;
    [cell.button1 addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.button2 setTitle:@"再次购买" forState:UIControlStateNormal];
    cell.button2.tag = 3000 + indexPath.section;
    [cell.button2 addTarget:self action:@selector(buyAgain:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.button3 setTitle:@"立即评论" forState:UIControlStateNormal];
    cell.button3.tag = 6000 + indexPath.section;
    [cell.button3 addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}



@end
