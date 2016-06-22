//
//  GetCommunityViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/1/10.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"

@interface GetCommunityViewController : BaseViewController<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    NSMutableArray *searchDataSouce;
    
    UISearchBar *mySearchBar;
    UISearchDisplayController *mySearchDisplayController;
}
@property(nonatomic,copy)NSDictionary *userDic;

@end
