//
//  WaittingPaymentViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//
static NSString *waittingPaymentIdentifire = @"waittingPaymentIdentifire";

#import "WaittingPaymentViewController.h"

@interface WaittingPaymentViewController ()

@end

@implementation WaittingPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-40) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, myTableView.bottom, DeviceWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WaittingPaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:waittingPaymentIdentifire];
    if (!cell) {
        cell = [[WaittingPaymentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waittingPaymentIdentifire];
    }
    
    cell.model = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return 125;
}
#pragma mark -------------结算
-(void)settlementAction
{
    
}
-(void)selectWithCell:(WaittingPaymentTableViewCell *)cell WithButtonAction:(BOOL)select
{
    NSIndexPath *index = [myTableView indexPathForCell:cell];
    WaittingPaymentModel *model = dataSource[index.row];
    if (select)
    {
        model.selected = YES;
    }
    else
    {
        model.selected = NO;
    }
    
    [myTableView reloadData];
    [self CalculationPrice];
}

-(void)selectAllaction:(UIButton *)sender
{
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
    }
    //改变单元格选中状态
    for (int i=0; i<dataSource.count;i++)
    {
        WaittingPaymentModel *model = dataSource[i];
        model.selected = sender.tag;
    }
    
    [self CalculationPrice];
    [myTableView reloadData];
}

//计算价格
-(void)CalculationPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<dataSource.count;i++)
    {
        WaittingPaymentModel *model = dataSource[i];
        if (model.selected)
        {
            allPrice = allPrice + model.goodsNum *[model.productNum intValue];
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",allPrice]];
    [str addAttribute:NSFontAttributeName value:Font(17) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    totalMoneyLable.attributedText = str;
    
    allPrice = 0.0;
}
-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [myTableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            WaittingPaymentModel *model = dataSource[index.row];
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            WaittingPaymentModel *model = dataSource[index.row];
            
            model.goodsNum ++;
        }
            break;
        default:
            break;
    }
    
    //刷新表格
    [myTableView reloadData];
    //计算总价
    [self CalculationPrice];
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
