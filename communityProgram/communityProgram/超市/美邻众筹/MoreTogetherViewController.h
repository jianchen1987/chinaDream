//
//  MoreTogetherViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "SupermarketCollectionViewCell.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "AdvRunLoopView.h"
#import "MoreTogetherTableViewCell.h"
#import "MoreTogetherDetailViewController.h"
#import "baseTableViewController.h"
@interface MoreTogetherViewController : baseTableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataSource;
//    UITableView *myTableView;
}

@property (nonatomic, weak) AdvRunLoopView *loopView;
@property (nonatomic, strong) NSMutableArray *imgsArr;

@end
