//
//  CompleteViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/2/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "WaittingPaymentTableViewCell.h"

@interface CompleteViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
    
}
@end
