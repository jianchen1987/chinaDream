//
//  ExchangeRecordViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/16.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "ExchangeRecordTableViewCell.h"
#import "ExchangeResultViewController.h"
@interface ExchangeRecordViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
}
@end
