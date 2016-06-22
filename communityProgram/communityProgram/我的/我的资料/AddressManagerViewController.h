//
//  AddressManagerViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/3/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressManagerViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
}
@end
