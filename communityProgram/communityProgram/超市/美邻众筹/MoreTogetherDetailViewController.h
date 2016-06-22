//
//  MoreTogetherDetailViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/3/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "MoreTogetherDetailTableViewCell.h"
#import "ProductCommendTableViewCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "CommentModle.h"
#import "ComfirmOrderViewController.h"
@interface MoreTogetherDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTableView;
    NSMutableArray *dataSource;
    NSMutableArray *commentDataSource;
    
}
@property(nonatomic,copy)NSString * ID;
@end
