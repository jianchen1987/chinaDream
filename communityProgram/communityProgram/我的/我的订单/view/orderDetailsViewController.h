//
//  orderDetailsViewController.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/28.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "baseTableViewController.h"
#import "AddressManagerTableViewCell.h"
#import "orderModel.h"

@interface orderDetailsViewController : baseTableViewController

@property (nonatomic, strong) orderModel *order;

@end
