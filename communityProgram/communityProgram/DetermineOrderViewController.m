//
//  DetermineOrderViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/28.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "DetermineOrderViewController.h"
#import "UIImageView+WebCache.h"
@interface DetermineOrderViewController ()
/**
 * 收货地址
 */
@property (weak, nonatomic) IBOutlet UILabel *address_LB;
/**
 *  等级折扣
 */
@property (weak, nonatomic) IBOutlet UILabel *OffsetAmount_LB;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UILabel *offsetAmountPercentage_LB;
@property (weak, nonatomic) IBOutlet UIImageView *CommodityPictures;
/**
 *  商品名字
 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/**
 *  以前价格
 */
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
/**
 *  真实价格
 */
@property (weak, nonatomic) IBOutlet UILabel *NewPrice;
/**
 *  购买数额
 */
@property (weak, nonatomic) IBOutlet UILabel *count;
/**
 *  与卖家
 */
@property (weak, nonatomic) IBOutlet UITextField *Merchants_LB;
/**
 *  优惠劵名字
 */
@property (weak, nonatomic) IBOutlet UILabel *Coupon_LB;
/**
 *  折扣金额
 */
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
/**
 *  优惠劵抵扣
 */
@property (weak, nonatomic) IBOutlet UILabel *OffsetAmountMoney_LB;

@end

@implementation DetermineOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.CommodityPictures sd_setImageWithURL:urlImage([_information_Dic objectForKey:@"productIcon"]) placeholderImage:[UIImage imageNamed:@"cell图片"]];
    self.name.text=[_information_Dic objectForKey:@"productName"];
    self.count.text=[[NSString  alloc]initWithFormat:@"X%d",_Number];
    self.NewPrice.text=NSStringType([_information_Dic objectForKey:@"discountPrice"]);
    self.oldPrice.text=NSStringType([_information_Dic objectForKey:@"price"]);
    self.mainScrollView.contentSize=CGSizeMake(DeviceWidth, 570);
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.identifyName] WithPath:@"getLevel" successBlock:^(NSDictionary* successJsonData) {
        NSLog(@"%@",successJsonData);
        
        self.offsetAmountPercentage_LB.text=[NSString stringWithFormat:@"%@%%",[successJsonData objectForKey:@"reduct"]];
        float discountPrice=[[successJsonData objectForKey:@"discountPrice"] floatValue];
        float reduct=[[successJsonData objectForKey:@"reduct"] floatValue];
    
        self.OffsetAmount_LB.text=[NSString stringWithFormat:@"%f",discountPrice*reduct*0.01];
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        
    }];



    // Do any additional setup after loading the view from its nib.
}
- (IBAction)address:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)youhuijuan:(id)sender {
    
}
- (IBAction)sure:(id)sender {
    
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
