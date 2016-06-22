//
//  WaittingPaymentViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/2/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "WaittingPaymentTableViewCell.h"
@interface WaittingPaymentViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    UIButton *selectAllButton; //全选按钮
    UIButton *settlementButton; //结算按钮
    UILabel *totalMoneyLable;
    float allPrice;
}
@end
