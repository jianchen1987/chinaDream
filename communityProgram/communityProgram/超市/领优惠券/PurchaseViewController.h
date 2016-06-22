//
//  PurchaseViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "PurchaseTableViewCell.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"


@interface PurchaseViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    int page;//页数记录
}
@end
