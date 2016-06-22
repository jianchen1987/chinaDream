//
//  FreeEatActivityViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//
static NSString *freeEatActivityIdentifire = @"freeEatActivityIdentifire";

#import "FreeEatActivityViewController.h"

@interface FreeEatActivityViewController ()

@end

@implementation FreeEatActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    dataSource = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-49) collectionViewLayout:layout];
    myCollectionView.backgroundColor = [UIColor whiteColor];
    myCollectionView.dataSource = self;
    myCollectionView.delegate = self;
    [self.view addSubview:myCollectionView];
    [myCollectionView registerClass:[FreeEatActivityCollectionViewCell class] forCellWithReuseIdentifier:freeEatActivityIdentifire];
    
    
    
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    myCollectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    
    // 马上进入刷新状态
    [myCollectionView.header beginRefreshing];
    
    [self pullUpToLoadMoreNews];
    
    
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"super1",@"image",@"英伦风格子衫",@"title",@"￥188.00",@"price",@"原价￥300",@"discountPrice", nil];
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"super2",@"image",@"保罗商务包",@"title",@"￥188.00",@"price",@"原价￥300",@"discountPrice", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"super2",@"image",@"保罗商务包",@"title",@"￥188.00",@"price",@"原价￥300",@"discountPrice", nil];
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"super1",@"image",@"保罗商务包",@"title",@"￥188.00",@"price",@"原价￥300",@"discountPrice", nil];
    NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"super1",@"image",@"太空创意杯",@"title",@"￥188.00",@"price",@"原价￥300",@"discountPrice", nil];
    NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"super2",@"image",@"保罗商务包",@"title",@"￥188.00",@"price",@"原价￥300",@"discountPrice", nil];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    
    [dataSource addObject:dic3];
    
    [dataSource addObject:dic4];
    
    [dataSource addObject:dic5];
    [dataSource addObject:dic6];
    [dataSource addObject:dic1];
    [dataSource addObject:dic2];
    
    [dataSource addObject:dic3];
    
    [dataSource addObject:dic4];
    
    [dataSource addObject:dic5];
    [dataSource addObject:dic6];

    
}
-(void)loadData
{
    [myCollectionView.header endRefreshing];

}
- (void)pullUpToLoadMoreNews
{    __weak __typeof(self) weakSelf = self;
    
    myCollectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadMoreData];
        
    }];
}
-(void)loadMoreData
{
    [myCollectionView.footer endRefreshing];
    
}

#pragma mark -------------------collectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:freeEatActivityIdentifire forIndexPath:indexPath];
    
    NSDictionary *dic = dataSource[indexPath.row];
    [cell loadCellData:nil];
    cell.layer.cornerRadius = 4;
    cell.clipsToBounds = YES;
    [cell.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.layer setBorderWidth:0.2];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(DeviceHeight > 568)
    {
        return CGSizeMake((DeviceWidth-40)/2, DeviceWidth/2*1.3);
    }else{
        
        return CGSizeMake((DeviceWidth-30)/2, DeviceWidth/2*1.3);
    }
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(DeviceHeight > 568)
    {
        return UIEdgeInsetsMake(20, 10, 0, 10);
    }else{
        
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (FreeEatActivityCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    NSLog(@"cell.teexx = %@",cell.titleLable.text);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
