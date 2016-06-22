//
//  MyselfViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "MyselfViewController.h"

@interface MyselfViewController ()

@end

@implementation MyselfViewController
-(void)viewWillDisappear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
//    self.navigationController.navigationBarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 200)];
    bottomView.image = [UIImage imageNamed:@"myself_default_headBackImage"];
    
    NSArray *barButtonImages = @[@"myself_doubt",@"myself_setting"];
    for (int i = 0; i < 2; i++) {
        UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        settingButton.frame = CGRectMake(DeviceWidth-100+30*i+20*i, 10, 30, 30);
        [settingButton setImage:[UIImage imageNamed:barButtonImages[i]] forState:0];
        [settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:settingButton];
    }
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-49) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
//    myTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    [self.view addSubview:myTableView];
    
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, DeviceWidth, 210)];
    view.backgroundColor = [UIColor clearColor];
    [myTableView setParallaxHeaderView:view
                                  mode:VGParallaxHeaderModeFill
                                height:210];
    
    
    
    myTableView.parallaxHeader.stickyViewPosition = VGParallaxHeaderStickyViewPositionBottom;
    [myTableView.parallaxHeader setStickyView:bottomView
                                   withHeight:210];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [myTableView shouldPositionParallaxHeader];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return 3;
            break;
        case 3:
            return 3;
            break;
            
        default:
            return 0;
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleArray = @[@"我的积分",@"邀请有礼",@"我的优惠券"];
    NSArray *cellImageArray = @[@"myself_integral",@"myself_invitation_polite",@"myself_coupons"];
    static NSString *secondIdentifire = @"secondIdentifire";
    static NSString *lastCellIdentifire = @"lastIdentifire";
    UITableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:secondIdentifire];
    UITableViewCell *laseCell = [tableView dequeueReusableCellWithIdentifier:lastCellIdentifire];
    
    
    if (indexPath.section == 1) {
        if (!secondCell) {
            secondCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIdentifire];
            
        }
        secondCell.textLabel.text = titleArray[indexPath.row];
        secondCell.imageView.image = [UIImage imageNamed:cellImageArray[indexPath.row]];
        secondCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return secondCell;
 
    }else if(indexPath.section == 3)
    {
        NSArray *lastSectionArray = @[@"我的帖子",@"我的回复",@"我的闲置"];
        if (!laseCell) {
            laseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCellIdentifire];
            
        }
        laseCell.textLabel.text = lastSectionArray[indexPath.row];
        laseCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return laseCell;
    }else
    {
        return nil;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 100;
    }else if(section == 1)
        return 10;
    else if (section == 2)
        return 60;
    else
    {
        return 10;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        NSArray *array = @[@"我的订单",@"我的收藏",@"我的关注",@"我的邻居",@"我的资料"];
        NSArray *imagesArray = @[@"myself_myOrder",@"myself_collection",@"myself_myFocus",@"myself_neighbor",@"myself_imformation"];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
        backView.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, -40, 60, 60)];
        userHeadImageView.backgroundColor = [UIColor grayColor];
        userHeadImageView.layer.cornerRadius = 30;
        userHeadImageView.clipsToBounds = YES;
        [backView addSubview:userHeadImageView];
        
        UILabel *ageLable = [[UILabel alloc] initWithFrame:CGRectMake(userHeadImageView.right+30, 10, 40, 20)];
        ageLable.text = @"25岁";
        ageLable.font = Font(15);
        [backView addSubview:ageLable];
        
        UIButton *placeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        placeButton.frame = CGRectMake(ageLable.right+5, 10, 100, 20);
        [placeButton setImage:[UIImage imageNamed:@""] forState:0];
        [placeButton setTitle:@"南洋苑" forState:0];
        placeButton.titleLabel.font = Font(13);
        [placeButton setTitleColor:[UIColor grayColor] forState:0];
        [backView addSubview:placeButton];

        
        
        for (int i = 0; i < 5; i++) {
            CustomMyselfButton *btn = [CustomMyselfButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(DeviceWidth/5*i, userHeadImageView.bottom+20, DeviceWidth/5, 60)];
            [btn setTitle:array[i] forState:0];
            [btn setImage:[UIImage imageNamed:[imagesArray objectAtIndex:i]] forState:0];
            [btn setTitleColor:[UIColor grayColor] forState:0];
            btn.titleLabel.font = Font(15);
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
        }
        
        
        return backView;
    }else if(section == 2)
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 60)];
        backView.backgroundColor = [UIColor whiteColor];
        NSArray *secondTitleArray = @[@"积分商城",@"我的小区",@"V认证",@"问卷调查"];
        NSArray *secondImagesArray = @[@"myself_integral_mall",@"myself_community",@"myself_V_certification",@"myself_question_servey"];
        for (int i = 0; i < 4; i++) {
            CustomMyselfButton *button = [CustomMyselfButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(DeviceWidth/4*i, 0, DeviceWidth/4, 60)];
            [button setImage:[UIImage imageNamed:secondImagesArray[i]] forState:0];
            [button setTitle:secondTitleArray[i] forState:0];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = Font(15);
            [button setTitleColor:[UIColor grayColor] forState:0];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:button];
        }
        return backView;
    }else
    {
        return nil;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row == 8) {
//        SystemSettingViewController *settingVC = [SystemSettingViewController new];
//        settingVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:settingVC animated:YES];
//    }else if(indexPath.row == 2)
//    {
//        MyArchivesViewController *myArchiverVC = [MyArchivesViewController new];
//        myArchiverVC.hidesBottomBarWhenPushed = YES;
//        
//        [self.navigationController pushViewController:myArchiverVC animated:YES];
//    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.01;
    }else if(section == 2)
    {
        return 0.01;
    }
    {
        return 10;
    }
}

#pragma mark ---------------------------我的积分
-(void)intergranlButton
{
    
    IntegralHistoryViewController *historyVC = [IntegralHistoryViewController new];
    ExchangeRecordViewController *exchangeVC = [ExchangeRecordViewController new];
    MyintegralViewController *myIntegralVC = [[MyintegralViewController alloc] init];
    myIntegralVC.hidesBottomBarWhenPushed = YES;
    myIntegralVC.viewControllers = @[historyVC,exchangeVC];
    [self.navigationController pushViewController:myIntegralVC animated:YES];
}
-(void)clickButtonAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"我的订单"]) {
        
        NSArray *viewControllers = [NSArray arrayWithObjects:[CompletePaymentViewController class],[WaittingPaymentViewController class],[CompleteViewController class], nil];
        NSArray *titles = [NSArray arrayWithObjects:@"已付款",@"待付款",@"已完成", nil];
        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles WithShowMenu:NO];
        pageVC.hidesBottomBarWhenPushed = YES;
        pageVC.pageAnimatable = YES;
        pageVC.menuItemWidth = 85;
        pageVC.menuHeight = 42;
        pageVC.postNotification = YES;
        pageVC.bounces = YES;
        pageVC.title = @"我的订单";
        pageVC.menuBGColor = [UIColor whiteColor];//bar背景颜色
        //    pageVC.titleColorNormal = RGBA(51, 51, 51, 1);
        //    pageVC.titleColorSelected = RGBA(28, 163, 230, 1);
        pageVC.menuViewStyle = WMMenuViewStyleLine;
        pageVC.titleSizeSelected = 15;
        [self.navigationController pushViewController:pageVC animated:YES];
    }else if([sender.titleLabel.text isEqualToString:@"我的邻居"])
    {
        MyNeiborViewController *neiborVC = [MyNeiborViewController new];
        neiborVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:neiborVC animated:YES];
    }else if([sender.titleLabel.text isEqualToString:@"我的资料"])
    {
        MyImformationViewController *imformationVC = [MyImformationViewController new];
        imformationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:imformationVC animated:YES];
    }else if([sender.titleLabel.text isEqualToString:@"我的收藏"])
    {
        MyCollectionViewController *myCollectionVC = [MyCollectionViewController new];
        myCollectionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myCollectionVC animated:YES];
    }
    
}
-(void)buttonAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"积分商城"]) {
        IntegralMallViewController *intergralVC = [IntegralMallViewController new];
        intergralVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:intergralVC animated:YES];
    }
}
#pragma mark ------------------------顶部按钮方法
-(void)settingButtonAction:(UIButton *)sender
{
    
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
