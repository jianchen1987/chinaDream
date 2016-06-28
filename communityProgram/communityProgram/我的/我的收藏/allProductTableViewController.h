//
//  allProductTableViewController.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface allProductTableViewController : MyCollectionViewController

- (void)clickOnButton:(UIButton *)button atIndex:(NSUInteger)index;
- (void)pullDown:(id)sender;

- (void)pullUp:(id)sender;

@end
