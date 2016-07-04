//
//  FreeSamplesDetailViewController.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/21.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"


#import "BaseViewController.h"
#import "MoreTogetherDetailTableViewCell.h"
#import "ProductCommendTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "CommentModle.h"
#import "ComfirmOrderViewController.h"
@interface FreeSamplesDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    NSMutableArray *commentDataSource;
    
}
@property(nonatomic,copy)NSString * ID;
@end