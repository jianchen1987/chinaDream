//
//  ShoppingCarViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/13.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "ShoppingCarViewController.h"

@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

-(void)loginButtonAction
{
    LoginViewController *loginVC = [LoginViewController new];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
    
    
}
#pragma mark ---------------获取购物车数据
-(void)loadShoppingData
{
//    NSArray *array = @[];
//    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:@"getShopCar" successBlock:^(id successJsonData) {
//        NSLog(@"successJsonData = %@",successJsonData);
//    } errorBlock:^(int code, NSString *errorJsonData) {
//        NSLog(@"errorJsonData = %@",errorJsonData);
//    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc] init];
    [self loadShoppingData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonAction)];
    
    allPrice = 0.00;
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-49-50) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, myTableView.bottom, DeviceWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    
    selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAllButton.frame = CGRectMake(10,(50-20)/2.0, 60, 20);
    [selectAllButton setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [selectAllButton setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [selectAllButton addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectAllButton.titleLabel.font = Font(15.0);
    selectAllButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [bottomView addSubview:selectAllButton];
    
    
    
    totalMoneyLable = [[UILabel alloc]initWithFrame:CGRectMake(DeviceWidth/2-100, (50-20)/2, 200, 20)];
    totalMoneyLable.textAlignment = NSTextAlignmentCenter;
    totalMoneyLable.font = Font(13.0);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f元",allPrice]];
    [str addAttribute:NSFontAttributeName value:Font(17) range:NSMakeRange(4,str.length-4)];
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
    settlementButton.titleLabel.font = Font(15.0);
    settlementButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [settlementButton addTarget:self action:@selector(settlementAction) forControlEvents:UIControlEventTouchUpInside];

    [bottomView addSubview:settlementButton];
    
    
    
    NSMutableArray *muArr = [NSMutableArray array];
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"欧客家手工曲奇饼干",@"title",@"300",@"originalPrice",@"199",@"discountPrice",@"1",@"productNum",@"packege",@"image",@"NO",@"selected", nil];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"纯正手工麦芽糖",@"title",@"300",@"originalPrice",@"99",@"discountPrice",@"1",@"productNum",@"packege",@"image",@"NO",@"selected", nil];
    NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"巧克力饼干",@"title",@"300",@"originalPrice",@"9",@"discountPrice",@"1",@"productNum",@"packege",@"image",@"NO",@"selected", nil];
    
    NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"穷巧克力糖果",@"title",@"300",@"originalPrice",@"19",@"discountPrice",@"1",@"productNum",@"packege",@"image",@"NO",@"selected", nil];
    
    [muArr addObject:dic1];
    [muArr addObject:dic2];
    [muArr addObject:dic3];
    [muArr addObject:dic4];
    
    
    for (NSDictionary *dic in muArr)
    {
        ShoppingProductModel *goodsModel = [[ShoppingProductModel alloc]initWithShopDict:dic];
        [dataSource addObject:goodsModel];
    }
    
}
#pragma mark -------------结算
-(void)settlementAction
{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifire = @"cell";
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifire];
    if (!cell) {
        cell = [[ShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifire];
    }
    ShoppingProductModel *modle = dataSource[indexPath.row];
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
    NSIndexPath *index = [myTableView indexPathForCell:cell];
    ShoppingProductModel *model = dataSource[index.row];
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
        ShoppingProductModel *model = dataSource[i];
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
        ShoppingProductModel *model = dataSource[i];
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
    NSIndexPath *index = [myTableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            ShoppingProductModel *model = dataSource[index.row];
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            ShoppingProductModel *model = dataSource[index.row];
            
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
