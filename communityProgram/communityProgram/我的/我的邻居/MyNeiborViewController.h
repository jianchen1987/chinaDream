//
//  MyNeiborViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "NeiborTableViewCell.h"
@interface MyNeiborViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    UISearchBar *mySearchBar;
    UISearchDisplayController *mySearchDisplayController;
}
@end
