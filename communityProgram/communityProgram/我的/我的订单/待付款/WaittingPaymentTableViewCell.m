//
//  WaittingPaymentTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/2/28.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "WaittingPaymentTableViewCell.h"

@implementation WaittingPaymentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{

    
    //产品图片
    _productImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 60, 60)];
    //    self.shopImageView.image = [UIImage imageNamed:@"img"];
    [self.contentView addSubview:_productImageView];
    
    //产品名称
    _productLable = [[UILabel alloc]initWithFrame:CGRectMake(_productImageView.right+10,_productImageView.top,DeviceWidth-_productImageView.right-20-_productLable.width, 20)];
    //    self.shopNameLab.text = @"合生元金装3段1-3岁";
    _productLable.font = Font(16);
    [self.contentView addSubview:_productLable];
    
    
    //产品描述
    _productDesLable = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+10, _productLable.bottom, DeviceWidth-_productImageView.right-20, 40)];
    _productDesLable.font = Font(14);
    _productDesLable.numberOfLines = 2;
    [self.contentView addSubview:_productDesLable];
    

    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _productImageView.bottom+5, DeviceWidth, 1)];
    _lineView.backgroundColor = RGBA(240, 240, 240, 1);
    [self.contentView addSubview:_lineView];
    
    
    UILabel *paymentLable = [[UILabel alloc] initWithFrame:CGRectMake(10, _lineView.bottom+10, 200, 30)];
    paymentLable.text = @"实际付款";
    [self.contentView addSubview:paymentLable];
    
    
    _cancleOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleOrderButton.frame = CGRectMake(DeviceWidth-200, _lineView.bottom+10, 80, 30);
    [_cancleOrderButton setTitle:@"立即付款" forState:0];
    [_cancleOrderButton setTitleColor:[UIColor whiteColor] forState:0];
    _cancleOrderButton.titleLabel.font = Font(14);
    [_cancleOrderButton setBackgroundColor:[UIColor redColor]];
    _cancleOrderButton.layer.cornerRadius = 5;
    _cancleOrderButton.clipsToBounds = YES;
    [self.contentView addSubview:_cancleOrderButton];

    
    _paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _paymentButton.frame = CGRectMake(DeviceWidth-100, _lineView.bottom+10, 80, 30);
    [_paymentButton setTitle:@"取消订单" forState:0];
    [_paymentButton setTitleColor:[UIColor whiteColor] forState:0];
    _paymentButton.titleLabel.font = Font(14);
    [_paymentButton setBackgroundColor:[UIColor redColor]];
    _paymentButton.layer.cornerRadius = 5;
    _paymentButton.clipsToBounds = YES;
    [self.contentView addSubview:_paymentButton];
    
}




-(void)setModel:(WaittingPaymentModel *)model{
    
    _model = model;
    self.productImageView.image = [UIImage imageNamed:@"img"];
    self.productLable.text = @"新味道烟台苹果";
    self.productDesLable.text = @"新鲜采摘,原生态种植,新鲜采摘,原生态种植,新鲜采摘,原生态种植，好产品要说三遍";
    self.productPriceLable.text = @"￥3.00/斤";
    self.addNumberView.numberString = @"3";

    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
