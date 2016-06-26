//
//  addressModifyViewController.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "baseTableViewController.h"
#import "addressModel.h"

@interface addressModifyViewController : baseTableViewController

@property (nonatomic,assign) BOOL newOrModify;
@property (nonatomic,strong) addressModel *addressModel;

@end
