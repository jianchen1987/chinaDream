//
//  FreeSamplesViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/20.
//  Copyright © 2016年 高国峰. All rights reserved.
//
#import <MJExtension.h>
#import "FreeSamplesViewController.h"
#import "SelectBar.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshBackGifFooter.h"
#import "FreeSamplesViews.h"
#import "SelectBar.h"
#import "UIImageView+WebCache.h"
#import "MyTryEatTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "FreeCollectionViewCell.h"
#import "FreeSamplesDetailViewController.h"
#import "PublishCommentViewController.h"
#import "FreeEatModel.h"
#import "FreeEatRecordModel.h"
#import "mySampleDetailsViewController.h"
#define DefaultCount  Number(9)
@interface FreeSamplesViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIView * downView;
    UIScrollView * mainScrollView;
    UIScrollView * topScrollview;
    UIScrollView * dowmScrollview;
    
}
@property(nonatomic,strong)NSMutableArray * FreeArray;
@property(nonatomic,strong)NSMutableArray * AllFreeRecord;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UICollectionView * FreeCollectionView;
@end

@implementation FreeSamplesViewController
-(void)creatView{
    mainScrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    downView =[[UIView alloc]initWithFrame:CGRectMake(0, mainScrollView.frame.size.height, self.view.frame.size.width,  self.view.frame.size.height)];
    //    downView.backgroundColor=[UIColor greenColor];
    [mainScrollView addSubview:downView];
    
    [self.view addSubview:mainScrollView];
    topScrollview=[[UIScrollView alloc]initWithFrame:self.view.frame];
    [mainScrollView addSubview:topScrollview];
    
    dowmScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, mainScrollView.frame.size.height, self.view.frame.size.width,  self.view.frame.size.height)];
    UIScrollView * scrol=[[UIScrollView alloc]initWithFrame:self.view.frame];
    [dowmScrollview addSubview:scrol];
    [mainScrollView addSubview:dowmScrollview];
    
    
    
    // 1.设置 顶部设置 上拉显示更多商品
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            mainScrollView.contentOffset = CGPointMake(0, mainScrollView.height);
        } completion:^(BOOL finished) {
            [topScrollview.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = mainScrollView.backgroundColor;
    [footer setTitle:@"往上拉可以查看全部试吃活动" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开可以查看全部试吃活动" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开可以查看全部试吃活动" forState:MJRefreshStateRefreshing];
    topScrollview.footer = footer;
    
    // 2.设置 更多商品添加 下拉返回
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            mainScrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            //结束加载
            [dowmScrollview.header endRefreshing];
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉，返回试吃详情" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回试吃详情" forState:MJRefreshStatePulling];
    [header setTitle:@"释放，返回试吃详情" forState:MJRefreshStateRefreshing];
    dowmScrollview.header = header;
#pragma mark 设置试吃活动视图
    //    490 320
//    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc]init];
//    
//    flowLayout.itemSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
//    flowLayout.minimumLineSpacing=1;
//    flowLayout.minimumInteritemSpacing=1;
//    //    flowLayout.
//    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
//    _FreeCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 70, DeviceWidth, 250+DeviceWidth) collectionViewLayout:flowLayout];
//    _FreeCollectionView.pagingEnabled=YES;
//    
//    [topScrollview addSubview: _FreeCollectionView];
//    topScrollview.contentSize=CGSizeMake(DeviceWidth, _FreeCollectionView.getH_Y);
//    
//    _FreeCollectionView.delegate=self;
//    _FreeCollectionView.backgroundColor=self.view.backgroundColor;
//    _FreeCollectionView.dataSource=self;
    
    [self.collectionView registerClass:[FreeCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];
    [dowmScrollview addSubview:self.collectionView];
    
    
    
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    UIEdgeInsets ed=UIEdgeInsetsMake(0, 0, 0, 10);
//    return ed;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _FreeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FreeCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
   FreeEatModel * model =[_FreeArray objectAtIndex:indexPath.row];
    
    
    [cell.FreeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AppendingImageUrl,model.freeIcon]] placeholderImage:[UIImage imageNamed:@"cell图片"]];
    
    cell.title_LB.text=model.productName;
   
    cell.detail.text= [NSString stringWithFormat:@"%@",model.simpleIntro];
    cell.numberCount.text=[NSString stringWithFormat:@"%@份",model.freeNum];
    cell.applyCount.text=[NSString stringWithFormat:@"%ld人申请",(long)model.applyNum];
    cell.expireDate=model.expireDate;
    
    cell.applyAction=^{
        FreeEatModel * u=_FreeArray[indexPath.row];
        [self appleyFree:u.id];
    };
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击第%ld个",(long)indexPath.row);
    FreeSamplesDetailViewController* detail=[[FreeSamplesDetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    
}


#pragma mark 获得所有的试吃记录
-(void)getAllFreerecord:(NSInteger)page
{
    
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.identifyName,Number(page),@10] WithPath:@"getFreeEatRecordByPage" successBlock:^(NSArray* successJsonData) {
        NSLog(@"所有的试吃纪录%@",successJsonData);
        for (int i=0; i<successJsonData.count; i++) {
            NSDictionary * di = successJsonData[i];
            FreeEatRecordModel * model =[FreeEatRecordModel mj_objectWithKeyValues:di];
            [_AllFreeRecord addObject:model];

        }

        
      
        
        if (_AllFreeRecord.count>0) {
            [self.tableView reloadData];
        };
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData==%@",errorJsonData);
    }];
}

//申请试吃
-(void)appleyFree:(NSString *)ID
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.identifyName,self.user.phone,ID] WithPath:@"applyFreeEat" successBlock:^(id successJsonData) {
        NSLog(@"申请＝＝＝＝＝%@",successJsonData);
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData==%@",errorJsonData);
    }];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake((DeviceWidth - 1)/2, (DeviceWidth - 1)/2 + 90);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.0f;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"免费试吃";
    _AllFreeRecord=[NSMutableArray array];
    [self creatView];
    FreeSamplesViews * freeView=[[[NSBundle mainBundle]loadNibNamed:@"FreeSamplesViews" owner:nil options:nil]lastObject];
   freeView.frame=CGRectMake(0, 60, DeviceWidth, DeviceWidth/2+200);
    topScrollview.contentSize=CGSizeMake(DeviceWidth, freeView.getH_Y);
    [topScrollview addSubview:freeView];
    
    SelectBar * selectBar=[[SelectBar alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    selectBar.backgroundColor=[UIColor whiteColor];
    [selectBar creatTitle:@[@"试吃活动",@"我的试吃"] color:RGBA(156, 156, 156, 1) selectColor:RGBA(69, 180, 17, 1) frame:CGRectMake(0, 0, DeviceWidth, 50)];
    
    _FreeArray=[NSMutableArray array];
    _FreeCollectionView.frame=CGRectMake(0, 0, DeviceWidth, DeviceHeight);
    //获得所有的试吃
    [self GetFreeEatrequest:Number(1)];
    selectBar.SelectBarClick=^(NSInteger number){
        switch (number) {
            case 0:
                _FreeCollectionView.hidden=NO;
                _tableView.hidden=YES;
                topScrollview.contentSize=CGSizeMake(DeviceWidth, 20+freeView.getH_Y);
                
                break;
            case 1:
                if (_AllFreeRecord.count<=0) {
                    [self getAllFreerecord:1];
                }
                
                _FreeCollectionView.hidden=YES;
                _tableView.hidden=NO;
                topScrollview.contentSize=CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
                break;
            default:
                break;
        }
    };
    [topScrollview addSubview:selectBar];
    topScrollview.backgroundColor=self.view.backgroundColor;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-50)];
    [topScrollview addSubview:_tableView];
    _tableView.hidden=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
}
#pragma mark 获得所有的试吃
-(void)GetFreeEatrequest:(NSNumber*)number
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[number,DefaultCount] WithPath:getFreeEat successBlock:^(NSArray* successJsonData)
     {
         NSDictionary * dic =successJsonData[0];
         for (int i=0; i<successJsonData.count; i++) {
             FreeEatModel * model =[FreeEatModel mj_objectWithKeyValues:successJsonData[i]];
             [_FreeArray addObject:model];
         }

         [self.dataSource addObject:_FreeArray];
         
         
         //         [actionView.stateImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AppendingImageUrl,[dic objectForKey:@"freeIcon"]]]placeholderImage:[UIImage imageNamed:@"cell图片"]];
//         NSLog(@"%@",[NSString stringWithFormat:@"%@%@",AppendingImageUrl,[dic objectForKey:@"freeIcon"]]);
         //         actionView.detailinformation.text=[dic objectForKey:@"imageText"];
         //         actionView.name.text=[dic objectForKey:@"productName"];
         //         actionView.count.text=[NSString stringWithFormat:@"%@份",[dic objectForKey:@"freeNum"]];
         
//         [_FreeArray addObjectsFromArray:successJsonData];
         [self.collectionView reloadData];
         
     } errorBlock:^(int code, NSString *errorJsonData) {
         
     }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _AllFreeRecord.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTryEatTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"MyTryEatTableViewCell"];
    
    
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTryEatTableViewCell" owner:nil options:nil]firstObject];
    }
  
    cell.mytitle.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
     FreeEatRecordModel * model  =_AllFreeRecord[indexPath.row];
    FreeEatModel * detail=model.freeEat;
    cell.mytitle.text =detail.productName;
    cell.mytime.text=[NSString stringWithFormat:@"申请时间%@",model.createTime];
    cell.mycount.text=[NSString stringWithFormat:@"%@份",detail.freeNum];
    [cell.Myimage sd_setImageWithURL:urlImage(detail.freeIcon) placeholderImage: [UIImage imageNamed:@"cell图片"]];
    
    __weak typeof(self) weakself=self;
    cell.delete=^{
        NSLog(@"%ld",   (long)indexPath.row);
    };
    cell.Mcommont=^{
        NSLog(@"%ld",   (long)indexPath.row);
        PublishCommentViewController * publish =[[PublishCommentViewController alloc]init];
        publish.model=self.AllFreeRecord[indexPath.row];
        [weakself.navigationController pushViewController:publish  animated:YES];
        
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#pragma mark 试吃详情
    mySampleDetailsViewController * myDetail=[mySampleDetailsViewController new];
    myDetail.model=self.AllFreeRecord[indexPath.row];
    [self.navigationController pushViewController:myDetail animated:YES];
    NSLog(@"%ld",(long)indexPath.row);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

@end
