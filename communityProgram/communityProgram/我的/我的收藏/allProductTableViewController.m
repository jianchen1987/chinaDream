//
//  allProductTableViewController.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "allProductTableViewController.h"

@implementation allProductTableViewController

- (void)clickOnButton:(UIButton *)button atIndex:(NSUInteger)index
{
    
}
- (void)pullDown:(id)sender
{
    NSLog(@"pushdown");
    
    [super pullDown:sender];
}

- (void)pullUp:(id)sender;
{
    
    [super pullUp:sender];
}




#pragma mark -- tableview delegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

@end
