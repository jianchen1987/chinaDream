//
//  MyNeiborViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//
static NSString *myNeiborIdentifire = @"myNeiborIdentifire";

#import "MyNeiborViewController.h"
#import "NearUserViewModel.h"
#import "UIImageView+WebCache.h"

@interface MyNeiborViewController()
{
    UISearchBar *_mySearchBar;
    UISearchDisplayController *_mySearchDisplayController;
    NSMutableArray *_searchResult;
}
@end

@implementation MyNeiborViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的邻居";
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight-64);;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.footer = nil;
    
    [self initSearchBar];
    [self showLoading];
    [self pullDown:self.tableView.header];
}
-(void)initSearchBar
{
    _mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 44)];
    [_mySearchBar setPlaceholder:@"输入邻居名称名称/拼音"];
    
    self.tableView.tableHeaderView = _mySearchBar;
    _mySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_mySearchBar contentsController:self];//挂上关系;
    _mySearchDisplayController.delegate = self;
    _mySearchDisplayController.searchResultsDataSource = self;
    _mySearchDisplayController.searchResultsDelegate = self;
    
    
}

- (void)pullDown:(id)sender
{
    if(!self.dataSource)
    {
        self.dataSource = [[NSMutableArray alloc]init];
    }
    
    [NearUserViewModel getNearNeighborByUser:self.user SuccessBlock:^(NSArray *arr)
    {
        [self dismissShow];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:arr];
        
        [super pullDown:sender];
    }
                                FailureBlock:^(int code, NSString *errMsg)
    {
        [self dismissShow];
        [super pullDown:sender];
        [self showPrompt:errMsg];
    }];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyNeiborTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myNeiborIdentifire];
    if (!cell)
    {
        cell = [[MyNeiborTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myNeiborIdentifire];
    }
    UserObject *neighbour = [self.dataSource objectAtIndex:indexPath.row];
    
    cell.nameLable.text = neighbour.nickName;
    cell.placeLable.text = neighbour.quarter.quarterName;
    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTURL,neighbour.headIcon]]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
