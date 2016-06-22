//
//  InvitationGiftViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/12.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"

@interface InvitationGiftViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
}
@end
