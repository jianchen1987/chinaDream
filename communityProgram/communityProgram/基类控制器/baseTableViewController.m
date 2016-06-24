//
//  baseTableViewController.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/23.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "baseTableViewController.h"


@implementation baseTableViewController

- (nullable instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    if(self)
    {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) style:style];
        self.tableView.delegate   = self;
        self.tableView.dataSource = self;
        self.dataSource = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 60)];
    [footView setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView = footView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.dataSource removeAllObjects];
}


#pragma mark -- tableview delegate --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.dataSource.count > 0)
    {
        return [[self.dataSource objectAtIndex:section] count];
    }
    else
    {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}





@end
