//
//  CagroryListDetailViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/3/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "CagroryListDetailTableViewCell.h"
#import "baseTableViewController.h"
@interface CagroryListDetailViewController : baseTableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
//    UITableView *myTableView;
    
    
    UIView *cagroryView;
    UIToolbar *myToolBar;
    UIView *bottomView;
}
@property(nonatomic,strong)NSArray * allDataArray;
@property(nonatomic,strong)NSDictionary * NowDataDic;
@end
