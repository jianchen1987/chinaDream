//
//  MyCollectionViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "MycollectionTableViewCell.h"
@interface MyCollectionViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
}
@end
