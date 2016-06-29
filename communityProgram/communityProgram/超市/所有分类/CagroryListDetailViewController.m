//
//  CagroryListDetailViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//
static NSString *cagroryListDetailIdentifire = @"cagroryListDetailIdentifire";
#import "ProductDetailViewController.h"
#define Display_BV CGRectMake(0, 50, DeviceWidth, 50)
#define Hiden_BV CGRectMake(0, -50, DeviceWidth, 50)
#import "TitleButton.h"
#import "CagroryListDetailViewController.h"
#import "SelectBar.h"
#import "MenuBarView.h"
#import "NetworkEngine.h"
#import "UIImageView+WebCache.h"
@interface CagroryListDetailViewController ()<SelectBarDelegte>
{
    UIButton *targetButton;
    UIView *backView;
    UIButton * upButton;
    UIButton * downButton;
    NSMutableArray * allDateArray;
    
}
@property(nonatomic,assign)int  result;// 0默认按时间排序 1 代表销量 2 代表人气  3 价格
@property(nonatomic,assign)int level;// 0不排序 1 代表从高到低 2 代表从低到高
@property(nonatomic,strong)NSString * nowName;
@property(nonatomic,strong)NSString * code;//类型
@property(nonatomic,strong) MenuBarView * menuView;//选项列表
@property(nonatomic,assign)NSInteger  nowPage;//当前页数
@property(nonatomic,strong)NSString * keyWord;

@property(nonatomic,strong)  TitleButton *titleButton;
@end

@implementation CagroryListDetailViewController
@synthesize titleButton;
-(MenuBarView *)menuView
{
    
    if (!_menuView) {
        _menuView=[[MenuBarView alloc]init];
        [self.view addSubview:_menuView];
    }
    return _menuView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    allDateArray=[NSMutableArray array];
    self.code= [self.NowDataDic objectForKey:@"id"];
    self.keyWord=[self.NowDataDic objectForKey:@"typeName"];
    self.level=0;
    self.result=0;
    self.nowPage=1;
    
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    
    upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.frame = CGRectMake(10, 10, (DeviceWidth-30)/2, 30);
    [upButton setTitle:@"从低到高" forState:UIControlStateNormal];
    //    upButton.selected=YES;
    [upButton setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [upButton setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    
    downButton = [UIButton buttonWithType:UIButtonTypeCustom];
    downButton.frame = CGRectMake((DeviceWidth-30)/2+10*2, 10, (DeviceWidth-30)/2, 30);
    [downButton setTitle:@"从高到低" forState:UIControlStateNormal];
    [downButton setBackgroundImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [downButton setBackgroundImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [downButton setTitleColor:[UIColor grayColor] forState:0];
    [upButton setTitleColor:[UIColor grayColor] forState:0];
    
    [backView addSubview:downButton];
    [backView addSubview:upButton];
    [upButton addTarget:self action:@selector(updown:) forControlEvents:UIControlEventTouchUpInside];
    [downButton addTarget:self action:@selector(updown:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame=CGRectMake(0, 0, 100, 50);
    [titleButton setTitle:@"新鲜水果" forState:0];
    [titleButton setImage:[UIImage imageNamed:@"超市展开"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"收起"] forState:UIControlStateSelected];
    
    [titleButton setTitleColor:[UIColor grayColor] forState:0];
    [titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    [self.view addSubview:backView];
    
    NSArray *topTitleArray = @[@"全部",@"销量",@"人气",@"价格"];
    SelectBar * search =[[SelectBar alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    search.SelectBarClick=^(NSInteger num){
        NSLog(@"选择%@",topTitleArray[num]);
        upButton.selected=NO;
        downButton.selected=NO;
        
    };
    [search creatTitle:topTitleArray color:[UIColor grayColor] selectColor:RGBA(90, 200, 30, 1) frame:CGRectMake(0, 0, DeviceWidth, 50)];
    search.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:search];
    search.delegte=self;
    
    [self getAlldataRequest];
}
//请求获取数据
-(void)getAlldataRequest
{
    NSArray * array=@[self.user.quarter.id?self.user.quarter.id:@"",
                      self.keyWord,
                      self.code,
                      Number(self.nowPage),
                      Number(10),
                      Number(self.result),
                      Number(self.level)
                      ];
    [titleButton setTitle: self.keyWord forState:0];
    
    if (self.nowPage==1) {
        [allDateArray removeAllObjects];
    }
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array
                             WithPath:@"getProductByCode" successBlock:^(id successJsonData) {
                                 NSLog(@"successJsonData===%@",successJsonData);
                                 NSArray * success=successJsonData;
                                 if (success.count>0) {
                                     [allDateArray addObjectsFromArray:successJsonData];
                                 }
                                 [myTableView reloadData];
                                 
                                 
                             } errorBlock:^(int code, NSString *errorJsonData) {
                                 
                             }];
    
}
-(void)Click:(NSInteger)numberButton{
    _result=numberButton;
    if (numberButton==0) {
        [UIView animateWithDuration:0.2 animations:^{
            backView.frame=Hiden_BV;
            myTableView.frame=CGRectMake(0, 0, DeviceWidth, DeviceHeight);
            
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            backView.frame=Display_BV;
            myTableView.frame=CGRectMake(0, 50, DeviceWidth, DeviceHeight-50);
            
        }];
    }
    
}
-(void)updown:(UIButton*)sender
{
    if ([sender isEqual:upButton]) {
        if (!upButton.selected) {
            upButton.selected=YES;
            downButton.selected=NO;
            _level=2;//代表从低到高
            
        }
    }else if ([sender isEqual:downButton]){
        if (!downButton.selected){
            upButton.selected=NO;
            downButton.selected=YES;
            _level=1;//代表从高到低
        }
    }
    
    [self getAlldataRequest];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allDateArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CagroryListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cagroryListDetailIdentifire];
    if (!cell) {
        cell = [[CagroryListDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cagroryListDetailIdentifire];
    }
    
    
    NSDictionary * unit =[allDateArray objectAtIndex:indexPath.row];
    cell.titleLable.text=[unit objectForKey:@"productName"];
    cell.descriptionLable.text=NSStringType([unit objectForKey:@"simpleIntro"]);
    cell.priceLable.text=NSStringType([unit objectForKey:@"discountPrice"]);
    cell.discountLable.text=NSStringType( [unit objectForKey:@"price"]);
    [cell.leftImageView sd_setImageWithURL:urlImage([unit objectForKey:@"productIcon"]) placeholderImage:[UIImage imageNamed:@"cell图片"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductDetailViewController * detail=[[ProductDetailViewController alloc]init];
    detail.dicData=[allDateArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}
#pragma mark -----------------------ButtonAction
-(void)selectButtonAction:(UIButton *)sender
{
    NSLog(@"sender.title = %@",sender.titleLabel.text);
}
#pragma mark ----------------------titleButtonAction
-(void)titleButtonAction:(UIButton *)sender
{
    if (!sender.selected)
    {
        //        if (self.menuView.MenuArray.count<=0) {
        //
        //            self.menuView.MenuArray= @[@"美邻推荐",@"美邻上新",@"新鲜水果",@"精品蔬菜",@"肉禽蛋品",@"奶品冻品",@"休闲食品",@"粮油调味",@"酒水饮料",@"个人护理",@"家居日品",@"进口商品"];
        //        }
        
        NSMutableArray * alldata=[NSMutableArray array];
        for (int i=0; i<self.allDataArray.count; i++)
        {
            NSDictionary * dic =[_allDataArray objectAtIndex:i];
            [alldata addObject:[dic objectForKey:@"typeName"]];
        }
        self.menuView.MenuArray=alldata;
        
        [self.view addSubview:self.menuView];
        __weak CagroryListDetailViewController* weakself = self;
        self.menuView.click=^(NSInteger number){
            weakself.titleButton.selected=!weakself.titleButton.selected;
            
            if (number==-1) {
                
                return ;
            }
            //点击选择某个选项搜索
            weakself.NowDataDic=weakself.allDataArray[number];
            weakself.code= [weakself.NowDataDic objectForKey:@"id"];
            weakself.keyWord=[weakself.NowDataDic objectForKey:@"typeName"];
            weakself.level=0;
            weakself.result=0;
            weakself.nowPage=1;
            [weakself getAlldataRequest];
            weakself.title=weakself.keyWord;
            weakself.nowName=weakself.menuView.MenuArray[number];
            NSLog(@"%ld %@",(long)number,weakself.nowName);
            [weakself getAlldataRequest];
            //            weakself.titleButton.selected=!weakself.titleButton.selected;
        };
    }else{
        [self.menuView removeFromSuperview];
    }
    sender.selected=!sender.selected;
    
}
-(void)cagroryAction:(UIButton *)sender
{
    //    NSLog(@"sender.title = %@",sender.titleLabel.text);
    [bottomView removeFromSuperview];
}
#pragma mark ----------------------点击透明层隐藏
-(void)myToolBarAction
{
    [UIView animateWithDuration:0.5 animations:^{
        bottomView.hidden = YES;
        targetButton.selected = NO;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
