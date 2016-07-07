//
//  ShoppingCarViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/13.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShoppingCarViewModel.h"

#define _SETTLE_VIEW_HEIGHT_   50.0f

@interface ShoppingCarViewController ()
{
    UIButton *selectAllButton; //全选按钮
    UIButton *settlementButton; //结算按钮
    UILabel *totalMoneyLable;
    float allPrice;
    
}

@end

@implementation ShoppingCarViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonAction)];
    
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - kSTATUSBAR_HEIGHT - kNAVIGATION_HEIGHT - kTABBAR_HEIGHT - _SETTLE_VIEW_HEIGHT_);
    
    self.tableView.footer = nil;

    allPrice = 0.00;
    
    [self initBottomView];
}


- (void)initBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceWidth, _SETTLE_VIEW_HEIGHT_)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    

    
    selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAllButton.frame = CGRectMake(10,(50-20)/2.0, 60, 20);
    [selectAllButton setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [selectAllButton setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [selectAllButton addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectAllButton.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
    selectAllButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [bottomView addSubview:selectAllButton];
    
    
    
    totalMoneyLable = [[UILabel alloc]initWithFrame:CGRectMake(DeviceWidth/2-100, (50-20)/2, 200, 20)];
    totalMoneyLable.textAlignment = NSTextAlignmentCenter;
    totalMoneyLable.font = Font(_SUBTITLE_FONT_SIZE_);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f元",allPrice]];
    [str addAttribute:NSFontAttributeName value:Font(_TITLE_FONT_SIZE_) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    totalMoneyLable.attributedText = str;
    [bottomView addSubview:totalMoneyLable];
    
    
    settlementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settlementButton.frame = CGRectMake(DeviceWidth-70, (50-30)/2, 60, 30);
    settlementButton.backgroundColor =[UIColor grayColor];
    settlementButton.layer.masksToBounds = YES;
    settlementButton.layer.cornerRadius =8;
    [settlementButton setTitle:@"结算" forState:UIControlStateNormal];
    [settlementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settlementButton.titleLabel.font = Font(_SUBTITLE_FONT_SIZE_);
    settlementButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [settlementButton addTarget:self action:@selector(settlementAction) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:settlementButton];
}

- (void)pullDown:(_Nonnull id)sender
{
    [ShoppingCarViewModel getShoppingCarListByUser:self.user
                                      SuccessBlock:^(NSArray *arr)
    {
        [self.dataSource addObjectsFromArray:arr];
        [super pullDown:sender];
        
    } FailureBlock:^(int code, NSString *errMsg) {
        [self showPrompt:errMsg];
        [super pullDown:sender];
    }];
}



-(void)loginButtonAction
{
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
    
    
}
#pragma mark -------------结算
-(void)settlementAction
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"cell";
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[ShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    ShoppingProductModel *modle = self.dataSource[indexPath.row];
    cell.shoppingModel = modle;
    cell.delegate = self;
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
    return 110;
}
//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     * 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
//    ShoppingProductModel *model = dataSource[indexPath.row];
//    if (model.selected)
//    {
//        model.selected = NO;
//    }
//    else
//    {
//        model.selected = YES;
//    }
    
    
    //刷新当前行
//    [myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [self CalculationPrice];
    
//    [myTableView reloadData];
//    [self CalculationPrice];
}
-(void)selectWithCell:(ShoppingCarCell *)cell WithButtonAction:(BOOL)select
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ShoppingProductModel *model = self.dataSource[index.row];
    if (select)
    {
        model.selected = YES;
    }
    else
    {
        model.selected = NO;
    }

    [self.tableView reloadData];
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
    for (int i=0; i<self.dataSource.count;i++)
    {
        ShoppingProductModel *model = self.dataSource[i];
        model.selected = sender.tag;
    }
    
    [self CalculationPrice];
    [self.tableView reloadData];
}

//计算价格
-(void)CalculationPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.dataSource.count;i++)
    {
        ShoppingProductModel *model = self.dataSource[i];
        if (model.selected)
        {
            allPrice = allPrice + model.goodsNum *[model.productDiscountPrice intValue];
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
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            ShoppingProductModel *model = self.dataSource[index.row];
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            ShoppingProductModel *model = self.dataSource[index.row];
            
            model.goodsNum ++;
        }
            break;
        default:
            break;
    }
    
    //刷新表格
    [self.tableView reloadData];
    //计算总价
    [self CalculationPrice];
}




@end
