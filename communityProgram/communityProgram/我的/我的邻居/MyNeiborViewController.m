//
//  MyNeiborViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//
static NSString *myNeiborIdentifire = @"myNeiborIdentifire";

#import "MyNeiborViewController.h"

@interface MyNeiborViewController ()

@end

@implementation MyNeiborViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
    
    [self initSearchBar];

}
-(void)initSearchBar
{
    mySearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 44)];
    [mySearchBar setPlaceholder:@"搜索基金名称/代码/拼音"];
    
    myTableView.tableHeaderView = mySearchBar;
    mySearchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];//挂上关系;
    mySearchDisplayController.delegate = self;
    mySearchDisplayController.searchResultsDataSource = self;
    mySearchDisplayController.searchResultsDelegate = self;
    
    
}






-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NeiborTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myNeiborIdentifire];
    if (!cell) {
        cell = [[NeiborTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myNeiborIdentifire];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
