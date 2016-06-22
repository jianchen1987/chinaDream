//
//  ComfirmOrderViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/3/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressTableViewCell.h"
#import "OrderSectionTableViewCell.h"
@interface ComfirmOrderViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
    
}
@end
