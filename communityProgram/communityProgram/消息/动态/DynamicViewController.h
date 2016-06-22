//
//  DynamicViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "DirectMessageTableViewCell.h"

@interface DynamicViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
    
}
@end
