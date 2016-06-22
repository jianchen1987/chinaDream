//
//  RecommendProductBtn.m
//  communityProgram
//
//  Created by xiaogao on 16/1/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "RecommendProductBtn.h"

@implementation RecommendProductBtn
-(id)initWithFrame:(CGRect)frame WithDic:(NSDictionary *)dic
{
    if (self = [super initWithFrame:frame]) {
        //产品图片
        _superHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height*0.7)];
        [self addSubview:_superHeadImageView];
        
        CGFloat height = frame.size.height*0.3;
        CGFloat leftFloat = [Utility marginLeftDistanceAccordingDeviceWidth];
        
        //产品标题
        _superTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _superHeadImageView.bottom+3, frame.size.width-10, (height-10)/3)];
        _superTitleLable.font = Font(16);
        [self addSubview:_superTitleLable];
        
        
        //产品价格
        _superDiscountLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _superTitleLable.bottom, frame.size.width, (height-10)/3)];
        _superDiscountLable.font = Font(14);
        [self addSubview:_superDiscountLable];
        
        
        //折扣价
        _superPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _superDiscountLable.bottom, frame.size.width/2, (height-10)/3)];
        _superPriceLable.font = Font(10);
        [self addSubview:_superPriceLable];
        
        
        //购买人数
        _superDateLable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, _superDiscountLable.bottom, frame.size.width/2-5, (height-10)/3)];
        _superDateLable.font = Font(10);
        _superDateLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:_superDateLable];
        
        
        
    }
    return self;
}


@end
