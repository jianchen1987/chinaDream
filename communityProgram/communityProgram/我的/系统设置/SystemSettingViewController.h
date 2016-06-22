//
//  SystemSettingViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "AboutUsViewController.h"
#import "OurThankingViewController.h"
#import "OpinionRebackViewController.h"
@interface SystemSettingViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    
}
@end
