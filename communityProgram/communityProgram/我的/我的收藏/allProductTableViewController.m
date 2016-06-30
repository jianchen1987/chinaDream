//
//  allProductTableViewController.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "allProductTableViewController.h"
#import "MycollectionTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation allProductTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)clickOnButton:(UIButton *)button atIndex:(NSUInteger)index
{
    
}
- (void)pullDown:(id)sender
{
    NSLog(@"pushdown");
    [self.dataSource addObjectsFromArray:@[@"12",@"12",@"12",@"12",@"12",@"12"]];
    [self reloadTableView];
    [super pullDown:sender];
}

- (void)pullUp:(id)sender;
{
    
    [super pullUp:sender];
}




#pragma mark -- tableview delegate --

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _COLLECTION_TABLEVIEW_CELL_HEIGHT_;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionIdentify = @"collection";
    MycollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionIdentify];
    if(!cell)
    {
        cell = [[MycollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectionIdentify];
    }
    
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:@"http://sc.jb51.net/uploads/allimg/140923/10-140923121040V8.jpg"] placeholderImage:[UIImage imageNamed:@"myself_collection"]];
    cell.titleLabel.text = @"一个大苹果";
    cell.detailLabel.text = @"新鲜采摘，原生态种植，洗洗带皮吃。鲜嫩多汁.新鲜采摘，原生态种植，洗洗带皮吃。鲜嫩多汁.新鲜采摘，原生态种植，洗洗带皮吃。鲜嫩多汁.新鲜采摘，原生态种植，洗洗带皮吃。鲜嫩多汁.";
    
    
    return cell;
}

@end
