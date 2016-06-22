//
//  IntegralMallViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/2/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "IntegralMallTableViewCell.h"
@interface IntegralMallViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
}
@end
