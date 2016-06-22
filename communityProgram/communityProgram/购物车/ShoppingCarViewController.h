//
//  ShoppingCarViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/13.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "ShoppingCarCell.h"
#import "ShoppingProductModel.h"
#import "LoginViewController.h"
@interface ShoppingCarViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ShoppingCarCellDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    UIButton *selectAllButton; //全选按钮
    UIButton *settlementButton; //结算按钮
    UILabel *totalMoneyLable;
    float allPrice;
    
}
@end
