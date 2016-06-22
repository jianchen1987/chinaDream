//
//  SasuallyTalkViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/12.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "NeiborTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "NeighborModel.h"
@interface SasuallyTalkViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
}


@end
