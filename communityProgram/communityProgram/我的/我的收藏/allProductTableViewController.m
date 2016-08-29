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
#import "collectionViewModel.h"
#import "ProductDetailViewController.h"

@implementation allProductTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showLoading];
    [self pullDown:self.tableView.header];
    
}



- (void)clickOnButton:(UIButton *)button atIndex:(NSUInteger)index
{
    [self showLoading];
    [self pullDown:self.tableView.header];
}

- (void)pullDown:(id)sender
{
    [collectionViewModel getCollectionProductsByUser:self.user
                                              TypeId:[self getSelectedButton]
                                           pageIndex:1
                                            pageSize:_COLLECTION_PAGE_SIZE_
                                        SuccessBlock:^(NSArray *arr)
    {
        if(!self.dataSource)
        {
            self.dataSource = [[NSMutableArray alloc] init];
        }
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:arr];
        [self reloadTableView];
        [super pullDown:sender];
        [self dismissShow];
        [self.tableView.footer resetNoMoreData];
        
    }
                                        FailureBlock:^(int code, NSString *errMsg)
    {
        [self showPrompt:errMsg];
        [super pullDown:sender];
        [self dismissShow];
    }];
}

- (void)pullUp:(id)sender;
{
    if(!self.dataSource)
    {
        [super pullUp:sender];
        return;
    }
    
    if(self.dataSource.count < _COLLECTION_PAGE_SIZE_)
    {
        [self.tableView.footer endRefreshingWithNoMoreData];
        return;
    }
    
    [collectionViewModel getCollectionProductsByUser:self.user
                                              TypeId:[self getSelectedButton]
                                           pageIndex:(self.dataSource.count/_COLLECTION_PAGE_SIZE_) + 1
                                            pageSize:_COLLECTION_PAGE_SIZE_
                                        SuccessBlock:^(NSArray *arr)
     {
         [self dismissShow];
         if(!self.dataSource)
         {
             self.dataSource = [[NSMutableArray alloc] init];
         }
         
         [self.dataSource addObjectsFromArray:arr];
        
         if(arr.count < _COLLECTION_PAGE_SIZE_)
         {
             [self.tableView.footer endRefreshingWithNoMoreData];
         }
         else
         {
             [super pullDown:sender];
         }
         
         [self reloadTableView];
     }
                                        FailureBlock:^(int code, NSString *errMsg)
     {
         [self showPrompt:errMsg];
         [super pullDown:sender];
         [self dismissShow];
     }];
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
    ProductModel *model = [self.dataSource objectAtIndex:indexPath.section];
    MycollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collectionIdentify];
    if(!cell)
    {
        cell = [[MycollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectionIdentify];
    }
    
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTURL,model.productIcon]] placeholderImage:[UIImage imageNamed:@"cell图片"]];
    cell.titleLabel.text = model.productName;
    cell.detailLabel.text = model.simpleIntro;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductModel *model = [self.dataSource objectAtIndex:indexPath.section];
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.unit = model;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        ProductModel *model = [self.dataSource objectAtIndex:indexPath.section];
        [self showLoading];
        [collectionViewModel removeCollectionProduct:model
                                         productType:[self getSelectedButton]
                                              byUser:self.user
                                        SuccessBlock:^(BOOL isSuccess)
        {
            [self dismissShow];
            if(isSuccess)
            {
                [self.dataSource removeObject:model];
            }
            else
            {
                [self showPrompt:@"删除失败!"];
            }
            
            [self reloadTableView];
        }
                                        FailureBlock:^(int code, NSString *errMsg)
        {
            [self dismissShow];
            [self showPrompt:errMsg];
            [self reloadTableView];
        }];
        
    }
    else if(editingStyle == (UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert))
    {
        //无
    }
    
}

@end
