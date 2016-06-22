//
//  FreeEatHistoryCollectionViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/12.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "FreeEatHistoryCollectionViewCell.h"

@implementation FreeEatHistoryCollectionViewCell
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
        
        
        
        //购买人数
        _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _applyButton.frame = CGRectMake(frame.size.width-70, frame.size.height-30, 60, 25);
        [_applyButton setTitle:@"查看评论" forState:0];
        [_applyButton setTitleColor:[UIColor whiteColor] forState:0];
        [_applyButton setBackgroundColor:RGBA(238, 75, 47, 1)];
        [_applyButton.layer setCornerRadius:3];
        _applyButton.clipsToBounds = YES;
        _applyButton.titleLabel.font = Font(13);
        [self.contentView addSubview:_applyButton];
        

        
    }
    return self;
}

-(void)loadCellData:(NSDictionary *)dicData
{
        
    [_productImageView setImage:[UIImage imageNamed:@""]];
    _productTitleLable.text = @"澳门牛肉干";
    _shareNumberLable.text = @"40份";
    _dateLable.text = @"2015-10-12";
    
}
@end
