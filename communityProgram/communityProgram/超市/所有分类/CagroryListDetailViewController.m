//
//  CagroryListDetailViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//
static NSString *cagroryListDetailIdentifire = @"cagroryListDetailIdentifire";
#define Display_BV CGRectMake(0, 50, DeviceWidth, 50)
#define Hiden_BV CGRectMake(0, -50, DeviceWidth, 50)
#import "TitleButton.h"
#import "CagroryListDetailViewController.h"
#import "SelectBar.h"
#import "MenuBarView.h"
@interface CagroryListDetailViewController ()<SelectBarDelegte>
{
    UIButton *targetButton;
    UIView *backView;
    UIButton * upButton;
    UIButton * downButton;
   
}
@property(nonatomic,strong) MenuBarView * menuView;//选项列表
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
    
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    
    upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.frame = CGRectMake(10, 10, (DeviceWidth-30)/2, 30);
    [upButton setTitle:@"从低到高" forState:UIControlStateNormal];
    upButton.selected=YES;
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
    [search creatTitle:topTitleArray color:[UIColor grayColor] selectColor:RGBA(90, 200, 30, 1) frame:CGRectMake(0, 0, DeviceWidth, 50)];
    search.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:search];
    search.delegte=self;
    

}
-(void)Click:(NSInteger)numberButton{
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
            
        }
    }else if ([sender isEqual:downButton]){
        if (!downButton.selected){
            upButton.selected=NO;
            downButton.selected=YES;
        }
    }
 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CagroryListDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cagroryListDetailIdentifire];
    if (!cell) {
        cell = [[CagroryListDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cagroryListDetailIdentifire];
    }
    
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
        if (self.menuView.MenuArray.count<=0) {
            
            self.menuView.MenuArray=@[@"苹果",@"苹果",@"苹果",@"苹果",@"苹果",@"苹果",@"苹果",@"苹果",@"苹果",];

        }
        
        [self.view addSubview:self.menuView];
        __weak typeof(self) weakself = self;
        self.menuView.click=^(NSInteger number){
            NSLog(@"%ld",(long)number);
            weakself.titleButton.selected=!weakself.titleButton.selected;
        };
    }else{
        [self.menuView removeFromSuperview];
    }
    sender.selected=!sender.selected;

}
-(void)cagroryAction:(UIButton *)sender
{
    NSLog(@"sender.title = %@",sender.titleLabel.text);
    bottomView.hidden = YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
