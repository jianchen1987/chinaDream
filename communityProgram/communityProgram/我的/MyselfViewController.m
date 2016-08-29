//
//  MyselfViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "MyselfViewController.h"
#import "SystemSettingViewController.h"
#import "LoginViewController.h"
#import "myLabel.h"
#import "UIImageView+WebCache.h"

#import "allProductTableViewController.h"
#import "allTopicTableViewController.h"
#import "attentionTableViewController.h"

#import "MyintegralViewController.h"
#import "IntegralHistoryViewController.h"
#import "ExchangeRecordViewController.h"


#define _MYSELF_BUTTON_SETT_ 901
#define _MYSELF_BUTTON_HELP_ 902

#define _MYSELF_ORDERS_    101
#define _MYSELF_FAVORI_    102
#define _MYSELF_FOLLOW_    103
#define _MYSELF_NEIGHBOUR_ 104
#define _MYSELF_MYINFO_    105

#define _MYSELF_INTEGRAL_SHOP_ 301
#define _MYSELF_VILLAGE_       302
#define _MYSELF_V_             303
#define _MYSELF_RESEARCH_      304


@interface MyselfViewController ()

@end

@implementation MyselfViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor greenColor]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - kTABBAR_HEIGHT);

    UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 200)];
    bottomView.image = [UIImage imageNamed:@"myself_default_headBackImage"];
    [bottomView setUserInteractionEnabled:YES];
    bottomView.contentMode = UIViewContentModeScaleAspectFill;
    
    NSArray *barButtonImages = @[@"myself_setting",@"myself_doubt"];
    for (int i = 0; i < 2; i++)
    {
        UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        settingButton.frame = CGRectMake(DeviceWidth - 30*(i + 1 ) - 10*(i+1), 20, 30, 30);
        settingButton.tag = 901 + i;
        [settingButton setImage:[UIImage imageNamed:barButtonImages[i]] forState:UIControlStateNormal];
        [settingButton addTarget:self action:@selector(settingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:settingButton];
    }
    
    self.tableView.showsVerticalScrollIndicator = NO;

    [self.tableView setParallaxHeaderView:bottomView
                                  mode:VGParallaxHeaderModeFill
                                height:200];
    self.tableView.header = nil;
    self.tableView.footer = nil;
    
}

#pragma mark -- scroll delegate --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView shouldPositionParallaxHeader];
}

#pragma mark -- tableview delegate --
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
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
    
    
    if (indexPath.section == 1)
    {
        if (!secondCell)
        {
            secondCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondIdentifire];
            
        }
        secondCell.textLabel.text = titleArray[indexPath.row];
        secondCell.textLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        secondCell.imageView.image = [UIImage imageNamed:cellImageArray[indexPath.row]];
        secondCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return secondCell;
 
    }
    else if(indexPath.section == 3)
    {
        NSArray *lastSectionArray = @[@"我的帖子",@"我的回复",@"我的闲置"];
        if (!laseCell)
        {
            laseCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lastCellIdentifire];
            
        }
        laseCell.textLabel.text = lastSectionArray[indexPath.row];
        laseCell.textLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        laseCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return laseCell;
    }else
    {
        return nil;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 150;
    }
    else if(section == 1)
    {
        return 10;
    }
    else if (section == 2)
    {
        return 70;
    }
    else
    {
        return 10;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        NSArray *array = @[@"我的订单",@"我的收藏",@"我的关注",@"我的邻居",@"我的资料"];
        NSArray *imagesArray = @[@"myself_myOrder",@"myself_collection",@"myself_myFocus",@"myself_neighbor",@"myself_imformation"];
        UIView *backView = [self getUserInfoView];
        
        for (int i = 0; i < 5; i++)
        {
            CGFloat btnWidth = DeviceWidth/5;
            CustomMyselfButton *btn = [CustomMyselfButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(btnWidth*i, backView.frame.size.height - btnWidth - 10, btnWidth, btnWidth)];
            [btn setTitle:array[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:[imagesArray objectAtIndex:i]] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = Font(_DETAIL_FONT_SIZE_);
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 101 + i;
            [backView addSubview:btn];
        }
        
        
        return backView;
    }
    else if(section == 2)
    {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 70)];
        backView.backgroundColor = [UIColor whiteColor];
        NSArray *secondTitleArray = @[@"积分商城",@"我的小区",@"V认证",@"问卷调查"];
        NSArray *secondImagesArray = @[@"myself_integral_mall",@"myself_community",@"myself_V_certification",@"myself_question_servey"];
        for (int i = 0; i < 4; i++)
        {
            CustomMyselfButton *button = [CustomMyselfButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(DeviceWidth/4*i + (DeviceWidth/4 - 50)/2 , 10, 50, 50)];
            [button setImage:[UIImage imageNamed:secondImagesArray[i]] forState:UIControlStateNormal];
            [button setTitle:secondTitleArray[i] forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.titleLabel.font = Font(_DETAIL_FONT_SIZE_);
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 301 + i;
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
    if(indexPath.section == 1)
    {
        UIViewController *vc = nil;
        switch (indexPath.row) {
            case 0:
                vc = [[MyintegralViewController alloc] init];
                ((MyintegralViewController *)vc).viewControllers = @[[[IntegralHistoryViewController alloc] init],[[ExchangeRecordViewController alloc] init]];
                break;
                
            default:
                break;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.section == 3)
    {
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.01;
    }
    else if(section == 2)
    {
        return 0.01;
    }
    else
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
    if (sender.tag == _MYSELF_ORDERS_)
    {
        
        NSArray *viewControllers = [NSArray arrayWithObjects:[CompletePaymentViewController class],[WaittingPaymentViewController class],[CompleteViewController class], nil];
        NSArray *titles = [NSArray arrayWithObjects:@"已付款",@"待付款",@"已完成", nil];
        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles WithShowMenu:NO];
        pageVC.hidesBottomBarWhenPushed = YES;
        pageVC.pageAnimatable           = YES;
        pageVC.menuItemWidth            = DeviceWidth/3;//85;
        pageVC.menuHeight               = kPageMenusHeight;
        //pageVC.postNotification = YES;
        pageVC.bounces                  = YES;
        pageVC.title                    = @"我的订单";
        pageVC.menuBGColor              = [UIColor whiteColor];//bar背景颜色
        pageVC.titleColorNormal         = [UIColor darkGrayColor];
        pageVC.titleColorSelected       = [UIColor blackColor];
        pageVC.progressColor            = RGBA(68, 180, 17, 1);
        pageVC.menuViewStyle            = WMMenuViewStyleLine;
        pageVC.titleSizeSelected        = 15;
        [self.navigationController pushViewController:pageVC animated:YES];
    }
    else if(sender.tag == _MYSELF_NEIGHBOUR_)
    {
        MyNeiborViewController *neiborVC = [MyNeiborViewController new];
        neiborVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:neiborVC animated:YES];
    }
    else if(sender.tag == _MYSELF_MYINFO_)
    {
        MyImformationViewController *imformationVC = [[MyImformationViewController alloc] init];
        imformationVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:imformationVC animated:YES];
    }
    else if(sender.tag == _MYSELF_FAVORI_)
    {
        NSArray *viewControllers = [NSArray arrayWithObjects:[allProductTableViewController class],[allTopicTableViewController class],nil];
        NSArray *vcTitles = [NSArray arrayWithObjects:@"全部商品",@"全部帖子",nil];
        WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:vcTitles WithShowMenu:NO];
        pageVC.keys = [NSArray arrayWithObjects:@"buttonTitles",@"buttonTitles", nil];
        pageVC.values = [NSArray arrayWithObjects:@[@"超市商品",@"试吃商品",@"众筹商品"],@[@"美邻问问",@"美邻说说",@"美邻闲置"], nil];
        pageVC.hidesBottomBarWhenPushed = YES;
        pageVC.pageAnimatable           = YES;
        pageVC.menuItemWidth            = DeviceWidth/2;
        pageVC.menuHeight               = kPageMenusHeight;
        pageVC.bounces                  = NO;
        pageVC.title                    = @"我的收藏";
        pageVC.menuBGColor              = [UIColor whiteColor];//bar背景颜色
        pageVC.titleColorNormal         = [UIColor darkGrayColor];
        pageVC.titleColorSelected       = [UIColor blackColor];
        pageVC.progressColor            = RGBA(68, 180, 17, 1);
        pageVC.menuViewStyle            = WMMenuViewStyleLine;
        pageVC.titleSizeSelected        = 15;
        
        [self.navigationController pushViewController:pageVC animated:YES];
    }
    else if(sender.tag == _MYSELF_FOLLOW_)
    {
        attentionTableViewController *vc = [[attentionTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)buttonAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"积分商城"])
    {
        IntegralMallViewController *intergralVC = [IntegralMallViewController new];
        intergralVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:intergralVC animated:YES];
    }
}
#pragma mark ------------------------顶部按钮方法
- (void)settingButtonAction:(id)button
{
    if(((UIButton *)button).tag == _MYSELF_BUTTON_HELP_)
    {
        
    }
    else if(((UIButton *)button).tag == _MYSELF_BUTTON_SETT_)
    {
        SystemSettingViewController *vc = [[SystemSettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (UIView *)getUserInfoView
{
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 150)];
    [userInfoView setBackgroundColor:[UIColor whiteColor]];
    if([self.user isLogin])
    {
        UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(20, -40, 60, 60)];
        
        [headView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HOSTURL,self.user.headIcon]]
                    placeholderImage:[UIImage imageNamed:@"上传头像"]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
        {
            NSLog(@"down head icon completed!");
        }];
        
        
        headView.layer.cornerRadius = headView.frame.size.width/2;
        headView.clipsToBounds = YES;
        [userInfoView addSubview:headView];
        
        myLabel *userName = [[myLabel alloc] initWithText:self.user.nickName FontSize:_SUBTITLE_FONT_SIZE_ MaxWidth:150];
        userName.frame = CGRectMake(headView.right + 5, 10, userName.frame.size.width, 25);
        [userInfoView addSubview:userName];
        
        UIImageView *userGenderImg = [[UIImageView alloc] initWithFrame:CGRectMake(userName.right+1, 10, 25, 25)];
    
        if([self.user.gender isEqualToString:@"男"])
        {
            userGenderImg.image = [UIImage imageNamed:@"myself_sex_man"];
        }
        else
        {
            userGenderImg.image = [UIImage imageNamed:@"myself_sex_woman"];
        }
        [userInfoView addSubview:userGenderImg];
        
        UIImageView *userLevel = [[UIImageView alloc] initWithFrame:CGRectMake(userGenderImg.right, 10, 25, 25)];
        userLevel.image = [UIImage imageNamed:[NSString stringWithFormat:@"myself_level_%@",self.user.identityIntegral]];
        [userInfoView addSubview:userLevel];
        
        UIImageView *userMaster = [[UIImageView alloc] initWithFrame:CGRectMake(userLevel.right, 10, 25, 25)];
        if([self.user.master isEqualToString:@"1"])
        {
            userMaster.image = [UIImage imageNamed:@"myself_V"];
        }
        else
        {
            userMaster.image = [UIImage imageNamed:@"myself_V_certification"];
        }
        [userInfoView addSubview:userMaster];
        
        myLabel *userAge = [[myLabel alloc] initWithText:@"20岁" FontSize:_DETAIL_FONT_SIZE_ MaxWidth:30];
        userAge.frame = CGRectMake(headView.right + 5, userName.bottom, userAge.frame.size.width, 25);
        [userInfoView addSubview:userAge];
        
        UIImageView *userLocal = [[UIImageView alloc] initWithFrame:CGRectMake(userAge.right + 5, userName.bottom, 25, 25)];
        userLocal.image = [UIImage imageNamed:@"myself_positioning"];
        [userInfoView addSubview:userLocal];
        
        myLabel *userAddr = [[myLabel alloc] initWithText:@"远洋明珠大厦" FontSize:_DETAIL_FONT_SIZE_ MaxWidth:150];
        userAddr.frame = CGRectMake(userLocal.right, userName.bottom, userAddr.frame.size.width, 25);
        [userInfoView addSubview:userAddr];
        
        
    }
    else
    {
        UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth/2 - 30, -40, 60, 60)];
        headView.image = [UIImage imageNamed:@"上传头像"];
        headView.layer.cornerRadius = 30;
        headView.clipsToBounds = YES;
        [userInfoView addSubview:headView];
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBtn.frame = CGRectMake(DeviceWidth/2 - 50, headView.bottom + 10, 100, 20);
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"注册/登陆"];
        [title addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_] range:NSMakeRange(0, title.length)];
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
        //[loginBtn setTitle:@"注册/登陆" forState:UIControlStateNormal];
        [loginBtn setAttributedTitle:title forState:UIControlStateNormal];
        [loginBtn addTarget:self action:@selector(gotoLoginView:) forControlEvents:UIControlEventTouchUpInside];
        [userInfoView addSubview:loginBtn];
    }
    
    return userInfoView;
}

- (void)gotoLoginView:(id)sender
{
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:nil];
}




@end
