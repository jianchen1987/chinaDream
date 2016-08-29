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
        //self.dataSource = [[NSMutableArray alloc] init];
        
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown:)];
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp:)];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 20)];
    [footView setBackgroundColor:[UIColor clearColor]];
    self.tableView.tableFooterView = footView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.dataSource removeAllObjects];
}



#pragma mark reflush
- (void)pullDown:(id)sender
{
    [self.tableView.header endRefreshing];
    [self reloadTableView];
}

- (void)pullUp:(id)sender
{
    [self.tableView.footer endRefreshing];
    [self reloadTableView];
}


#pragma mark -- tableview delegate --
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView.editing)
    {
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }
    else
    {
        return UITableViewCellEditingStyleDelete;
    }
}



- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark -- scrollview delegate --
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([scrollView isDragging])
    {
        [self.view endEditing:YES];
    }
}

#pragma mark -- empty delete --
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    if(self.dataSource == nil)
    {
        return NO;
    }
    else if(self.dataSource.count == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{

    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_TITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor blackColor]};
    return [[NSAttributedString alloc] initWithString:@"数据为空" attributes:attribute];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:@"没有找到合适的记录" attributes:attribute];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"collectionEmpty"];
}


- (void)reloadTableView
{
    [self.tableView reloadData];
    [self.tableView reloadEmptyDataSet];
}




@end
