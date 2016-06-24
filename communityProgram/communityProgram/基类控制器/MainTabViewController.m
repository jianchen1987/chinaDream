//
//  MainTabViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "MainTabViewController.h"
#import "BaseNaviViewController.h"
@interface MainTabViewController ()

@end

@implementation MainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarImage1"];
   
    NSArray *viewControllers = [NSArray arrayWithObjects:[NeighborAskViewController class],[SasuallyTalkViewController class],[IdleItmsViewController class],[SelectPostViewController class], nil];
    NSArray *titles = [NSArray arrayWithObjects:@"邻里问问",@"随便说说",@"闲置东东",@"精选帖子", nil];
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles WithShowMenu:YES];
    pageVC.pageAnimatable = YES;
    pageVC.menuItemWidth = 85;
    pageVC.menuHeight = 42;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    pageVC.title = @"社区";
    pageVC.menuBGColor = [UIColor whiteColor];//bar背景颜色
//    pageVC.titleColorNormal = RGBA(51, 51, 51, 1);
//    pageVC.titleColorSelected = RGBA(28, 163, 230, 1);
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    pageVC.titleSizeSelected = 15;

    BaseNaviViewController *navi1 = [[BaseNaviViewController alloc] initWithRootViewController:pageVC];

    
    SuperMarketViewController *supermarketVC = [SuperMarketViewController new];
    supermarketVC.title = @"超市";
    BaseNaviViewController *navi2 = [[BaseNaviViewController alloc] initWithRootViewController:supermarketVC];
    
    ShoppingCarViewController *shoppingVC = [ShoppingCarViewController new];
    shoppingVC.title = @"购物车";
    BaseNaviViewController *navi3 = [[BaseNaviViewController alloc] initWithRootViewController:shoppingVC];
    
    
    DynamicViewController *dynamicVC = [DynamicViewController new];
    DirectMessageViewController *directVC = [DirectMessageViewController new];
    NotificationViewController *notiVC = [NotificationViewController new];
    
    MessageViewController *messageVC = [MessageViewController new];
    messageVC.viewControllers = @[dynamicVC,directVC,notiVC];
    messageVC.title = @"消息";
    BaseNaviViewController *navi4 = [[BaseNaviViewController alloc] initWithRootViewController:messageVC];
    
    
    MyselfViewController *mySelfVC = [[MyselfViewController alloc] initWithStyle:UITableViewStyleGrouped];
    mySelfVC.title = @"我的";
    BaseNaviViewController *navi5 = [[BaseNaviViewController alloc] initWithRootViewController:mySelfVC];
    NSArray *viewControllersArray = [NSArray arrayWithObjects:navi1,navi2,navi3,navi4,navi5, nil];
    
    self.viewControllers = viewControllersArray;
    self.tabBar.backgroundColor = [UIColor whiteColor];
    UITabBarItem *item0 = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *item3 = [self.tabBar.items objectAtIndex:3];
    UITabBarItem *item4 = [self.tabBar.items objectAtIndex:4];

    
    item0.selectedImage = [[UIImage imageNamed:@"tab_community"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item0.image         = [[UIImage imageNamed:@"tab_community_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];


    item1.selectedImage = [[UIImage imageNamed:@"tab_surpermaket"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item1.image         = [[UIImage imageNamed:@"tab_supermaket_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    item2.selectedImage = [[UIImage imageNamed:@"tab_shoppingCar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item2.image         = [[UIImage imageNamed:@"tab_shoppingCar_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    item3.selectedImage = [[UIImage imageNamed:@"tab_news"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item3.image         = [[UIImage imageNamed:@"tab_news_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];


    item4.selectedImage = [[UIImage imageNamed:@"tab_myself"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item4.image         = [[UIImage imageNamed:@"tab_myself_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
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
