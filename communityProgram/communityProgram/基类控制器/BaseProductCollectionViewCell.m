//
//  BaseProductCollectionViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/23.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseProductCollectionViewCell.h"

@implementation BaseProductCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = frame.size.width;
        CGFloat contentHeight = frame.size.height*0.3; //内容高度
        CGFloat leftFloat = [Utility marginLeftDistanceAccordingDeviceWidth];//根据屏幕宽度设置左边距离

        //产品图片
        _productHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, frame.size.height*0.7)];
        
        [self.contentView addSubview:_productHeadImageView];
        
        
        //产品昵称
        _productNameLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _productHeadImageView.bottom+3, width-2*leftFloat, (contentHeight-6)/3)];
        _productNameLable.font = Font(16);
        _productNameLable.textColor = RGBA(50, 50, 50, 1);
        [self.contentView addSubview:_productNameLable];
        
        //产品价格
        _productPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _productNameLable.bottom, width-2*leftFloat, (contentHeight-6)/3)];
        _productPriceLable.font = Font(17);
        [self.contentView addSubview:_productPriceLable];
        
        
        //产品折扣价
        _productDiscountPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _productPriceLable.bottom, width-100-leftFloat, (contentHeight-6)/3)];
        _productDiscountPriceLable.font = Font(15);
        [self.contentView addSubview:_productDiscountPriceLable];
        
        
        
        //购买数量
        _productBuyNumber = [[UILabel alloc] initWithFrame:CGRectMake(width-100, _productPriceLable.bottom, 95, (contentHeight-6)/3)];
        _productBuyNumber.textColor = RGBA(153, 153, 153, 1);
        _productBuyNumber.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_productBuyNumber];
        
    }
    return self;
}

-(void)loadCellData:(NSDictionary *)dicData
{
//    _productHeadImageView.image = [UIImage imageNamed:@"financial_article"];
//    _productNameLable.text = [dicData valueForKey:@""];
//    _productPriceLable.text = [dicData valueForKey:@""];
//    _productDiscountPriceLable.text = [dicData valueForKey:@""];
//    _productBuyNumber.text = [dicData valueForKey:@""];
    
    _productHeadImageView.image = [UIImage imageNamed:@"financial_article"];
    _productNameLable.text = @"测试标题";
    _productPriceLable.text = @"￥383.00元";
    _productDiscountPriceLable.attributedText = [Utility rebackDiscountPriceAttr:@"74974"];
    _productBuyNumber.text = @"已有122人购买";
    
}





@end
