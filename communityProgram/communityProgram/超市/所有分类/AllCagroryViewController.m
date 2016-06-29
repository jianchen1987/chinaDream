//
//  AllCagroryViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//


#import "AllCagroryViewController.h"
#import "UpImageButton.h"
#import "UIView+Getlength.h"
#import "UIImageView+WebCache.h"
@interface AllCagroryViewController ()
@property(nonatomic,strong)UIView *secondView;
@property(nonatomic,strong)NSMutableArray * alltypeArray;
@end

@implementation AllCagroryViewController
@synthesize secondView;
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
-(void)getAlltype{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[@""] WithPath:@"getProductType" successBlock:^(id successJsonData) {
        NSLog(@"%@",successJsonData);
        
        _alltypeArray=successJsonData;
        float border=0.5;
        for (int i  = 0; i < _alltypeArray.count; i++) {
            float unit_W=(DeviceWidth/4);
            float Image_W=40;
            UIView * unit =[[UIView alloc]initWithFrame:CGRectMake((DeviceWidth/4)*(i%4), (DeviceWidth/4)*(i/4), DeviceWidth/4, DeviceWidth/4)];
            
            unit.layer.borderWidth=border;
            unit.layer.borderColor=[UIColor grayColor].CGColor;
            NSDictionary * dic_unit=_alltypeArray[i];
            UIImageView * unitImage=[[UIImageView alloc]initWithFrame:CGRectMake((unit_W-Image_W)/2, (unit_W-Image_W)/2, Image_W, Image_W)];
            NSString * path=[dic_unit objectForKey:@"typeImageIcon"];
            
            [unitImage sd_setImageWithURL:urlImage(path) placeholderImage:[UIImage imageNamed:@"cell图片"]];
            [unit addSubview:unitImage];
            UILabel * name=[[UILabel alloc]initWithFrame:CGRectMake(0, unitImage.getH_Y, unit_W, unit_W-unitImage.getH_Y)];
            name.textAlignment=NSTextAlignmentCenter;
            name.text=[dic_unit objectForKey:@"typeName"];
            name.font=[UIFont systemFontOfSize:12];
            name.textColor=[UIColor grayColor];
            [unit addSubview:name];
            [secondView addSubview:unit];
            UIButton * action=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, unit_W, unit_W)];
            action.tag=i;
            [action addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
            [unit addSubview:action];
        }
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        
    }];
    
    
}
-(void)detailAction:(UIButton*)sender
{
    CagroryListDetailViewController * cagrory=[CagroryListDetailViewController new];
    cagrory.allDataArray=self.alltypeArray;
    cagrory.NowDataDic=self.alltypeArray[sender.tag];
    [self.navigationController pushViewController: cagrory animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataSource = [[NSMutableArray alloc] init];
    self.title=@"所有分类";
    
    [self getAlltype];
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
    
    
    secondView = [[UIView alloc] initWithFrame:CGRectMake(0, firstView.bottom+10, DeviceWidth, 1000)];
    secondView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:secondView];
    
    
}




@end
