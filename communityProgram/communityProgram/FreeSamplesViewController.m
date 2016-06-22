//
//  FreeSamplesViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/20.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "FreeSamplesViewController.h"
#import "SelectBar.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshBackGifFooter.h"
#import "FreeSamplesViews.h"
#import "SelectBar.h"
#import "UIImageView+WebCache.h"
#import "MyTryEatTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface FreeSamplesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView * downView;
    UIScrollView * mainScrollView;
    UIScrollView * topScrollview;
    UIScrollView * dowmScrollview;
}
@property(nonatomic,strong)NSMutableArray * FreeArray;
@property(nonatomic,strong)NSMutableArray * AllFreeRecord;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation FreeSamplesViewController
-(void)creatView{
    mainScrollView=[[UIScrollView alloc]initWithFrame:self.view.frame];
    downView =[[UIView alloc]initWithFrame:CGRectMake(0, mainScrollView.frame.size.height, self.view.frame.size.width,  self.view.frame.size.height)];
    downView.backgroundColor=[UIColor greenColor];
    [mainScrollView addSubview:downView];
    
    [self.view addSubview:mainScrollView];
    topScrollview=[[UIScrollView alloc]initWithFrame:self.view.frame];
    [mainScrollView addSubview:topScrollview];
    
    dowmScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, mainScrollView.frame.size.height, self.view.frame.size.width,  self.view.frame.size.height)];
    UIScrollView * scrol=[[UIScrollView alloc]initWithFrame:self.view.frame];
    [dowmScrollview addSubview:scrol];
    scrol.backgroundColor=[UIColor yellowColor];
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

}
#pragma mark 获得所有的试吃记录
-(void)getAllFreerecord{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.id,@1,@10] WithPath:@"getFreeEatRecordByPage" successBlock:^(id successJsonData) {
        NSLog(@"所有的试吃纪录%@",successJsonData);
//        self.AllFreeRecord=successJsonData;
        [_AllFreeRecord addObjectsFromArray:successJsonData];

        [self.tableView reloadData];
         [self appleyFree];
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData==%@",errorJsonData);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}
//申请试吃
-(void)appleyFree
{
    NSDictionary * dic =_FreeArray[0];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.id,self.user.phone,[dic objectForKey:@"id"]] WithPath:@"applyFreeEat" successBlock:^(id successJsonData) {
        NSLog(@"申请＝＝＝＝＝%@",successJsonData);
    } errorBlock:^(int code, NSString *errorJsonData) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"免费试吃";
    _AllFreeRecord=[NSMutableArray array];
    [self getAllFreerecord];
    [self creatView];
    _AllFreeRecord=[NSMutableArray array];
    FreeSamplesViews* actionView=[[[NSBundle mainBundle]loadNibNamed:@"FreeSamplesViews" owner:nil options:nil]lastObject];
    
    actionView.commodityimage.image=[UIImage imageNamed:@"cell图片"];
    actionView.frame=CGRectMake(0, 50, self.view.frame.size.width, 200+self.view.frame.size.width*2/3-30);
    [topScrollview addSubview:actionView];
    SelectBar * selectBar=[[SelectBar alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    selectBar.backgroundColor=[UIColor whiteColor];
    [selectBar creatTitle:@[@"试吃活动",@"我的试吃"] color:RGBA(156, 156, 156, 1) selectColor:RGBA(69, 180, 17, 1) frame:CGRectMake(0, 0, DeviceWidth, 50)];
    
    _FreeArray=[NSMutableArray array];
    
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[@1,@4] WithPath:@"getFreeEat" successBlock:^(id successJsonData)
     {
         NSDictionary * dic =successJsonData[0];
         [actionView.stateImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AppendingImageUrl,[dic objectForKey:@"freeIcon"]]]placeholderImage:[UIImage imageNamed:@"cell图片"]];
         NSLog(@"%@",[NSString stringWithFormat:@"%@%@",AppendingImageUrl,[dic objectForKey:@"freeIcon"]]);
         actionView.detailinformation.text=[dic objectForKey:@"imageText"];
         actionView.name.text=[dic objectForKey:@"productName"];
         actionView.count.text=[NSString stringWithFormat:@"%@份",[dic objectForKey:@"freeNum"]];
         [_FreeArray addObjectsFromArray:successJsonData];
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        
    }];
    
    selectBar.SelectBarClick=^(NSInteger number){
        switch (number) {
            case 0:
                actionView.hidden=NO;
                _tableView.hidden=YES;
             topScrollview.contentSize=CGSizeMake(self.view.frame.size.width, actionView.frame.size.height+actionView.frame.origin.y);
                
                break;
            case 1:
                actionView.hidden=YES;
                _tableView.hidden=NO;
                 topScrollview.contentSize=CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
                break;
            default:
                break;
        }
    };
    topScrollview.contentSize=CGSizeMake(self.view.frame.size.width,50+ actionView.frame.size.height+actionView.frame.origin.y);
    [topScrollview addSubview:selectBar];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-50)];
//    _tableView.backgroundColor=[UIColor orangeColor];
    [topScrollview addSubview:_tableView];
    _tableView.hidden=YES;
    _tableView.delegate=self;
    _tableView.dataSource=self;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _AllFreeRecord.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTryEatTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"MyTryEatTableViewCell"];
    cell.mytitle.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.Myimage.image=[UIImage imageNamed:@"cell图片"];
    NSDictionary * unit =[_AllFreeRecord objectAtIndex:indexPath.row];
    NSDictionary * detailUnit =[unit objectForKey:@"freeEat"];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@",AppendingImageUrl,[detailUnit objectForKey:@"freeIcon"]]);
    [cell.Myimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",AppendingImageUrl,[detailUnit objectForKey:@"freeIcon"]]]placeholderImage:[UIImage imageNamed:@"cell图片"]];
    
    if (!cell)
    {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"MyTryEatTableViewCell" owner:nil options:nil]firstObject];
    }
    
    cell.mytitle.text=[NSString stringWithFormat:@"%@",[detailUnit objectForKey:@"productName"]];
    cell.delete=^{
        NSLog(@"%ld",   (long)indexPath.row);
    };
    cell.Mcommont=^{
        NSLog(@"%ld",   (long)indexPath.row);

    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

@end
