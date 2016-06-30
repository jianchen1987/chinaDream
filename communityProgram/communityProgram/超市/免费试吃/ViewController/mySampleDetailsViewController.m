//
//  mySampleDetailsViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "mySampleDetailsViewController.h"
#import "UIImageView+WebCache.h"
#import "SystemFunction.h"
@interface mySampleDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *QRcodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *addressDetail;
@end

@implementation mySampleDetailsViewController
- (IBAction)delete:(id)sender {
}
- (IBAction)PingLun:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _address.text=self.model.user.quarter.quarterName;
    _addressDetail.text=self.model.user.quarter.quarterAddress;
    [_iconImageView sd_setImageWithURL:urlImage(self.model.freeEat.freeIcon) placeholderImage:[UIImage imageNamed:@"cell图片"]];
    self.QRcodeImageView.image= [SystemFunction SystemCodeimageString:self.model.freeEatCode];
  
    self.count.text=[NSString stringWithFormat:@"%@份",  self.model.freeEat.freeNum];
    
    self.time.text=[NSString stringWithFormat:@"申请时间:%@",self.model.createTime];
    
    // Do any additional setup after loading the view from its nib.
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
