//
//  baseTableViewController.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/23.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import <Foundation/Foundation.h>

@interface baseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

- (nullable instancetype)init;

- (nullable instancetype)initWithStyle:(UITableViewStyle)style;

@property (nonatomic, strong, nullable) UITableView *tableView;

@property (nonatomic, strong, nullable) UIRefreshControl *refreshControl;

@property (nonatomic, strong, nullable) NSMutableArray *dataSource;


@end
