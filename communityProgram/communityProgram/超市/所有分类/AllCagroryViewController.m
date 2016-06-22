//
//  AllCagroryViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//


#import "AllCagroryViewController.h"

@interface AllCagroryViewController ()

@end

@implementation AllCagroryViewController
#pragma mark ------------------获取广告图
-(void)LoadAdvertise
{
    NSArray *paramsArray = @[@"supermarket"];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:paramsArray WithPath:GetAllChipLogoPath successBlock:^(id successJsonData) {
        
        NSLog(@"successJsonData = %@",successJsonData);
        NSMutableArray *imageArray = [NSMutableArray array];
        
        if (successJsonData) {
            for (NSDictionary *dic in successJsonData) {
                [imageArray addObject:[AppendingImageUrl stringByAppendingString:[dic valueForKey:@"imageLogo"]]];
            }
            NSLog(@"imageArray = %@",imageArray);
            // 异步下载图片
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                self.imgsArr = [NSMutableArray array];
                for (NSString *str in imageArray) {
                    NSURL *imageUrl = [NSURL URLWithString:str];
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
                    
                    if (!image) {
                        UIImage *newsImage = [UIImage imageNamed:@"banner"];
                        [self.imgsArr addObject:newsImage];
                    }else
                    {
                        [self.imgsArr addObject:image];
                    }
                }
                // 当图片下载完成后，在主线程设置tableHeaderView的数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loopView setLoopViewImages:self.imgsArr autoPlay:YES delay:3.0];
                    
                });
            });
        }
        
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc] init];
    self.title=@"所有分类";
    
    
    TSEXCARLoopView *loopView = [[TSEXCARLoopView alloc] initWithFrame:CGRectMake(0.0, 0.0, DeviceWidth, DeviceWidth/3)];
    loopView.delegate = self;
    loopView.userInteractionEnabled = YES;
    self.loopView = loopView;
    [self.view addSubview:self.loopView];
    [self LoadAdvertise];
    
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, loopView.bottom+10, DeviceWidth, 80)];
    firstView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:firstView];
    
    NSArray *firstTitleArray = @[@"美邻众筹",@"领优惠券",@"免费试吃",@"摇摇红包"];
    NSArray *firstImageArray = @[@"categories_preparations",@"categories_preferential",@"categories_tryEat",@"categories_shake"];
    for (int i = 0; i < 4; i++) {
        CustomSupermarketBtn *btn = [CustomSupermarketBtn buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(DeviceWidth/4*i, 0, DeviceWidth/4, 80);
        [btn setTitle:firstTitleArray[i] forState:0];
        [btn setTitleColor:[UIColor grayColor] forState:0];
        [btn setImage:[UIImage imageNamed:firstImageArray[i]] forState:0];
        btn.titleLabel.font = Font(13);
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [firstView addSubview:btn];
    }

    
    UIView *secondView = [[UIView alloc] initWithFrame:CGRectMake(0, firstView.bottom+10, DeviceWidth, 1000)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];

    NSArray *titlesArray = @[@"美邻推荐",@"美邻上新",@"新鲜水果",@"精品蔬菜",@"肉禽蛋品",@"奶品冻品",@"休闲食品",@"粮油调味",@"酒水饮料",@"个人护理",@"家居日品",@"进口商品"];
    NSArray *imagesArray = @[@"categories_recommend",@"categories_new",@"categories_fruit",@"categories_vegetables",@"categories_eggs",@"categories_frozen_goods",@"categories_food",@"categories_seasoning",@"categories_drinks",@"categories_nursing",@"categories_dailyItems",@"categories_imported_goods"];
    for (int i  = 0; i < titlesArray.count; i++) {
        CustomSupermarketBtn *button = [CustomSupermarketBtn buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(DeviceWidth/4*(i%4), DeviceWidth/4*(i/4), DeviceWidth/4, DeviceWidth/4);
        [button setTitle:titlesArray[i] forState:0];
        [button setTitleColor:[UIColor grayColor] forState:0];
        [button setImage:[UIImage imageNamed:imagesArray[i]] forState:0];
        button.titleLabel.font = Font(13);
        button.tag = 5000+i;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button.layer setBorderColor:RGBA(200, 200, 200, 1).CGColor];
        [button.layer setBorderWidth:0.5];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [secondView addSubview:button];
    }
    
}

-(void)buttonAction:(UIButton *)sender
{
    NSLog(@"sender.tag = %ld",(long)sender.tag);
    [self.navigationController pushViewController:[CagroryListDetailViewController new] animated:YES];
    
    
}



@end
