//
//  ShoppingCarViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/13.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShoppingCarViewModel.h"
#import "UIImageView+WebCache.h"
#import "LXAlertView.h"

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


- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateBadge:) name:@"ShoppingcarUpdate" object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShoppingcarUpdate" object:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn setImage:[UIImage imageNamed:@"shoppingcar_delete"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(deleteSelectedItem) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBaritem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    self.navigationItem.rightBarButtonItem = rightBaritem;//[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoppingcar_delete"] style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonAction)];
    
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - kSTATUSBAR_HEIGHT - kNAVIGATION_HEIGHT - kTABBAR_HEIGHT - _SETTLE_VIEW_HEIGHT_);
    
    self.tableView.footer = nil;

    allPrice = 0.00;
    
    [self initBottomView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self showLoading];
    [self pullDown:self.tableView.header];
}

- (void)initBottomView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, DeviceWidth, _SETTLE_VIEW_HEIGHT_)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAllButton.frame = CGRectMake(10,(_SETTLE_VIEW_HEIGHT_ - 20)/2.0, 60, 20);
    [selectAllButton setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [selectAllButton setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [selectAllButton addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    [selectAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectAllButton.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
    selectAllButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [bottomView addSubview:selectAllButton];
    
    totalMoneyLable               = [[UILabel alloc]initWithFrame:CGRectMake(80, (_SETTLE_VIEW_HEIGHT_-20)/2, 200, 20)];
    totalMoneyLable.textAlignment = NSTextAlignmentLeft;
    totalMoneyLable.font          = Font(_SUBTITLE_FONT_SIZE_);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计:￥%.2f元",allPrice]];
    [str addAttribute:NSFontAttributeName value:Font(_TITLE_FONT_SIZE_) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    totalMoneyLable.attributedText = str;
    [bottomView addSubview:totalMoneyLable];
    
    
    settlementButton                     = [UIButton buttonWithType:UIButtonTypeCustom];
    settlementButton.frame               = CGRectMake(DeviceWidth - 100, (_SETTLE_VIEW_HEIGHT_ - 40)/2, 90, 40);
    settlementButton.backgroundColor     = [UIColor grayColor];
    settlementButton.layer.masksToBounds = YES;
    settlementButton.layer.cornerRadius  = 5;
    [settlementButton setTitle:@"去结算" forState:UIControlStateNormal];
    [settlementButton setBackgroundImage:[UIImage imageNamed:@"结算按钮"] forState:UIControlStateNormal];
    [settlementButton setBackgroundImage:nil forState:UIControlStateDisabled];
    [settlementButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settlementButton.titleLabel.font = Font(_SUBTITLE_FONT_SIZE_);
    settlementButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [settlementButton addTarget:self action:@selector(settlementAction) forControlEvents:UIControlEventTouchUpInside];
    
    [bottomView addSubview:settlementButton];
}

- (void)pullDown:(_Nonnull id)sender
{
    if(!self.dataSource)
    {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    
    [ShoppingCarViewModel getShoppingCarListByUser:self.user
                                      SuccessBlock:^(NSArray *arr)
    {
        [self dismissShow];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:arr];
        [self CalculationPrice];
        [super pullDown:sender];
        
        
    }
                                      FailureBlock:^(int code, NSString *errMsg)
    {
        [self dismissShow];
        [self showPrompt:errMsg];
        [super pullDown:sender];
        
    }];
}



//-(void)loginButtonAction
//{
//    
//    LoginViewController *loginVC = [LoginViewController new];
//    loginVC.hidesBottomBarWhenPushed = YES;
//    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
//    
//    [self presentViewController:nav animated:YES completion:nil];
//    
//    
//}
#pragma mark -------------结算
-(void)settlementAction
{
    NSLog(@"结算");
    DetermineOrderViewController * deter=[[DetermineOrderViewController alloc]initWithNibName:@"DetermineOrderViewController" bundle:nil];;
    [self.navigationController pushViewController:deter animated:YES];
    
}


#pragma mark -- tableview delegate --

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
    ProductModel *modle = self.dataSource[indexPath.row];
    
    cell.shopNameLab.text           = modle.productName;
    cell.selectedButton.selected    = modle.selected;
    [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTURL,modle.productIcon]]];
    cell.oldPriceLab.attributedText = [Utility rebackDiscountPriceAttr:[NSString stringWithFormat:@"￥%.2f",modle.price]];
    cell.priceLab.text              = [NSString stringWithFormat:@"￥%.2f",modle.discountPrice];
    cell.addNumberView.numberString = [NSString stringWithFormat:@"%ld",modle.buyNum];
    
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        ProductModel *model = [self.dataSource objectAtIndex:indexPath.row];
        [self showLoading];
        [ShoppingCarViewModel removeProduct:model forUser:self.user
                               SuccessBlock:^(BOOL isSuccess)
        {
            [self dismissShow];
            if(isSuccess)
            {
                [self.dataSource removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [self CalculationPrice];
            }
        } FailureBlock:^(int code, NSString *errMsg) {
            [self dismissShow];
            [self showPrompt:errMsg];
        }];
    }
    else if(editingStyle == (UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert))
    {
        
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//IOS8+
- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteBtn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
    {

        ProductModel *model = [self.dataSource objectAtIndex:indexPath.row];
        [self showLoading];
        [ShoppingCarViewModel removeProduct:model forUser:self.user
                               SuccessBlock:^(BOOL isSuccess)
         {
             [self dismissShow];
             if(isSuccess)
             {
                 [self.dataSource removeObjectAtIndex:indexPath.row];
                 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
                 [self CalculationPrice];
             }
         }
                               FailureBlock:^(int code, NSString *errMsg)
        {
             [self dismissShow];
             [self showPrompt:errMsg];
         }];
    }];
    
    
    UITableViewRowAction *attentionBtn = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                            title:@"加入收藏"
                                                                          handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath)
    {
        ProductModel *model = [self.dataSource objectAtIndex:indexPath.row];
        [self showLoading];
        [collectionViewModel saveProductCollection:model forUser:self.user SuccessBlock:^(BOOL isSuccess)
        {
            [self dismissShow];
            if(isSuccess)
            {
                [self showSuccess:@"添加成功"];
            }
            else
            {
                [self showPrompt:@"添加失败"];
            }
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
                                      FailureBlock:^(int code, NSString *errMsg)
        {
            [self dismissShow];
            [self showPrompt:errMsg];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    
    return @[deleteBtn,attentionBtn];
}



//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!tableView.editing)
    {
        NSLog(@"详情");
        
        ProductDetailViewController * detail=[[ProductDetailViewController alloc]init];
        detail.unit = [self.dataSource objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else
    {
        //多选
        NSLog(@"多选");
    }
}




-(void)selectAllaction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
    }
    //改变单元格选中状态
    for (int i=0; i<self.dataSource.count;i++)
    {
        ProductModel *model = self.dataSource[i];
        model.selected = sender.selected;
    }
    
    [self CalculationPrice];
    [self.tableView reloadData];
}

//计算价格
-(void)CalculationPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    NSNumber *totalNum = [NSNumber numberWithInteger:0];
    for ( int i =0; i<self.dataSource.count;i++)
    {
        ProductModel *model = self.dataSource[i];
        if (model.selected)
        {
            allPrice = allPrice + model.buyNum *model.discountPrice;
            totalNum = [NSNumber numberWithInteger:model.buyNum + totalNum.integerValue];
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",allPrice]];
    [str addAttribute:NSFontAttributeName value:Font(17) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    totalMoneyLable.attributedText = str;
    allPrice = 0.0;
    [self checkSelectAll];
    [self checkSettlementBtnState];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShoppingcarUpdate" object:@{@"oper":@"0",@"parm":totalNum}];
}


#pragma mark --cell delegate

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ProductModel *model = self.dataSource[index.row];
    switch (flag) {
        case 11:
        {
            //做减法
            if (model.buyNum > 1)
            {
                [self updateProduct:model buyNum:model.buyNum - 1];
            }
        }
            break;
        case 12:
        {
            //做加法
            [self updateProduct:model buyNum:model.buyNum + 1];
        }
            break;
        default:
            break;
    }
}

-(void)selectWithCell:(ShoppingCarCell *)cell WithButtonAction:(BOOL)select
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    ProductModel *model = self.dataSource[index.row];
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

#pragma mark --empty delegate 
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_TITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor blackColor]};
    return [[NSAttributedString alloc] initWithString:@"您的购物车是空的" attributes:attribute];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:@"快去选购你喜欢的商品吧!" attributes:attribute];
}



#pragma mark -------

- (void)updateProduct:(ProductModel *)product buyNum:(NSUInteger)num
{
    [self showLoading];
    [ShoppingCarViewModel modifyNum:num ofProduct:product forUser:self.user
                       SuccessBlock:^(BOOL isSuccess)
    {
        [self dismissShow];
        if(isSuccess)
        {
            product.buyNum = num;
        }
        
        [self.tableView reloadData];
        [self CalculationPrice];
    }
                       FailureBlock:^(int code, NSString *errMsg)
    {
        [self dismissShow];
        [self showPrompt:errMsg];
        [self.tableView reloadData];
        [self CalculationPrice];
    }];
}

- (void)checkSelectAll
{
    for(ProductModel *model in self.dataSource)
    {
        if(!model.selected)
        {
            selectAllButton.selected = NO;
            return;
        }
    }
    
    selectAllButton.selected = YES;
}

- (void)checkSettlementBtnState
{
    for(ProductModel *model in self.dataSource)
    {
        if(model.selected)
        {
            [settlementButton setEnabled:YES];
            return;
        }
    }
    [settlementButton setEnabled:NO];
}


- (void)updateBadge:(NSNotification *)sender
{
    NSString *opera = [sender.object objectForKey:@"oper"];
    int buyNum = self.navigationController.tabBarItem.badgeValue?[self.navigationController.tabBarItem.badgeValue intValue]:0;
    switch ([opera intValue])
    {
        //reset
        case 0:
        {
            buyNum = [[sender.object objectForKey:@"parm"] intValue];
        }
            break;
        case 1:
        {
            buyNum += [[sender.object objectForKey:@"parm"] intValue];
        }
            break;
        default:
            break;
    }
    if(buyNum == 0)
    {
        self.navigationController.tabBarItem.badgeValue = nil;
        [settlementButton setTitle:@"去结算" forState:UIControlStateNormal];
    }
    else
    {
        self.navigationController.tabBarItem.badgeValue = buyNum > 99?@"99+":[NSString stringWithFormat:@"%d",buyNum];
        [settlementButton setTitle:[NSString stringWithFormat:@"去结算(%@)",buyNum > 99?@"99+":[NSString stringWithFormat:@"%d",buyNum]] forState:UIControlStateNormal];
    }
}

- (NSInteger)getSelectedItemCount
{
    NSInteger cnt = 0;
    for(ProductModel *model in self.dataSource)
    {
        if(model.selected)
        {
            cnt = cnt + 1;
        }
    }
    
    return cnt;
}



- (void)deleteSelectedItem
{
    NSUInteger cnt = [self getSelectedItemCount];
    if(cnt == 0)
    {
        return;
    }
    
    
    LXAlertView *alert = [[LXAlertView alloc] initWithTitle:@""
                                                    message:[NSString stringWithFormat:@"是否删除这%ld款商品",cnt]
                                             cancelBtnTitle:@"取消"
                                              otherBtnTitle:@"确认"
                                            clickIndexBlock:^(NSInteger clickIndex)
    {
        if(clickIndex == 1)
        {
            [self showLoading];
            NSArray *temp = [NSArray arrayWithArray:self.dataSource];
            
            for(ProductModel *model in temp)
            {
                if(model.selected)
                {
                    [ShoppingCarViewModel removeProduct:model
                                                forUser:self.user
                                           SuccessBlock:^(BOOL isSuccess){}
                                           FailureBlock:^(int code, NSString *errMsg){}];
                    [self.dataSource removeObject:model];
                }
            }
            
            [self dismissShow];
            [self.tableView reloadData];
            [self CalculationPrice];
        }
    }];
    
    
    [alert showLXAlertView];

}



@end
