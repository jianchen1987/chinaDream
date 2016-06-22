//
//  FreeEatActivityCollectionViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "FreeEatActivityCollectionViewCell.h"

@implementation FreeEatActivityCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //产品图片
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height*0.7)];
        [self.contentView addSubview:_productImageView];
        
        CGFloat height = frame.size.height*0.3;
        CGFloat leftFloat = [Utility marginLeftDistanceAccordingDeviceWidth];
        
        //产品标题
        _productTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _productImageView.bottom+3, frame.size.width-10, (height-10)/3)];
        _productTitleLable.font = Font(16);
        [self.contentView addSubview:_productTitleLable];
        
        
        //产品价格
        _shareNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _productTitleLable.bottom, frame.size.width, (height-10)/3)];
        _shareNumberLable.font = Font(14);
        [self.contentView addSubview:_shareNumberLable];
        
        
        //折扣价
        _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _shareNumberLable.bottom, frame.size.width/2, (height-10)/3)];
        _dateLable.font = Font(12);
        [self.contentView addSubview:_dateLable];
        
        _applyNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth-120, frame.size.height-30, 110, 25)];
        _applyNumberLable.font = Font(12);
        _applyNumberLable.textColor = [UIColor grayColor];
        [self.contentView addSubview:_applyNumberLable];
        
    }
    return self;
}
-(void)loadCellData:(NSDictionary *)dicData
{
    
//    [_productImageView sd_setImageWithURL:[NSURL URLWithString:[AppendingImageUrl stringByAppendingString:[dicData valueForKey:@"productIcon"]]] placeholderImage:[UIImage imageNamed:@""]];
    
    [_productImageView setImage:[UIImage imageNamed:@""]];
    _productTitleLable.text = @"澳门牛肉干";
    _shareNumberLable.text = @"40份";
    _dateLable.text = @"2015-10-12";
    _applyNumberLable.text = @"66人已申请";
    
}


@end
