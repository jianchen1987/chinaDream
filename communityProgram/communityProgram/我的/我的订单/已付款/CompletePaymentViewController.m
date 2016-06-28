//
//  CompletePaymentViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//


#import "CompletePaymentViewController.h"


@interface CompletePaymentViewController ()

@end

@implementation CompletePaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - kSTATUSBAR_HEIGHT - kNAVIGATION_HEIGHT - 42);

}


- (void)pushDown:(id)sender
{
    
}

- (void)pullDown:(_Nonnull id)sender
{
    [orderViewModel getOrdersByUser:self.user
                       SuccessBlock:^(NSArray *orders)
     {
         [self.dataSource addObjectsFromArray:@[@"1",@"2",@"3"]];
         [self.tableView reloadData];
         [self.tableView reloadEmptyDataSet];
         
     }
                       FailureBlock:^(int code, NSString *errMsg)
     {
         [self showPrompt:errMsg];
     }];
    
    [super pullDown:sender];
}
- (void)pullUp:(_Nonnull id)sender
{
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    orderListTableViewCell *cell = nil;;
    
    if(indexPath.section == 1)
    {
        static NSString *identify2 = @"style2";
        cell = [tableView dequeueReusableCellWithIdentifier:identify2];
        if(!cell)
        {
            cell = [[orderListTableViewCell alloc] initWithUpStyle:OrderListTableViewCellUpStyleMutable BottomStyle:OrderListTableViewCellBottomStyleNormal reuseIdentifier:identify2];
        }
        
        [cell.previewImgView1 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        [cell.previewImgView2 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        [cell.previewImgView3 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
        cell.upDetailsLabel.text = @"一共5款商品";
        
    }
    else
    {
        static NSString *identifiy1 = @"style1";
        cell = [tableView dequeueReusableCellWithIdentifier:identifiy1];
        if (!cell)
        {
            cell = [[orderListTableViewCell alloc] initWithUpStyle:OrderListTableViewCellUpStyleNormal BottomStyle:OrderListTableViewCellBottomStyleNormal reuseIdentifier:identifiy1];
        }
        cell.upTitleLabel.text = @"新味道烟台苹果";
        cell.upDetailsLabel.text =  @"烟台苹果是山东名优特产之一，产地以烟台辖区内的栖霞市、龙口市";
        [cell.previewImgView1 sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"上传头像"]];
    }
    
    [cell.button1 setTitle:@"申请退款" forState:UIControlStateNormal];
    cell.button1.tag = 1000 + indexPath.section;
    [cell.button1 addTarget:self action:@selector(applyFund:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.button2 setTitle:@"私信商家" forState:UIControlStateNormal];
    cell.button2.tag = 3000 + indexPath.section;
    [cell.button2 addTarget:self action:@selector(sendMsgToMer:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.button3 setTitle:@"确认收货" forState:UIControlStateNormal];
    cell.button3.tag = 6000 + indexPath.section;
    [cell.button3 addTarget:self action:@selector(confirmReceive:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _COMPLETEDPAYCELL_HEIGHT_;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- empty delete --

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_TITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor blackColor]};
    return [[NSAttributedString alloc] initWithString:@"你还没有相关订单" attributes:attribute];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:@"实惠商品等着您，快去逛逛超市吧!" attributes:attribute];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"orderEmpty"];
}



@end
