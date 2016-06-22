//
//  SupermarketCollectionViewCell.m
//  communityProgram
//
//  Created by xiaogao on 15/12/13.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "SupermarketCollectionViewCell.h"

@implementation SupermarketCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        //产品图片
        _superHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height*0.7)];
        [self.contentView addSubview:_superHeadImageView];
        
        CGFloat height = frame.size.height*0.3;
        CGFloat leftFloat = [Utility marginLeftDistanceAccordingDeviceWidth];
        
        //产品标题
        _superTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _superHeadImageView.bottom+3, frame.size.width-10, (height-10)/3)];
        _superTitleLable.font = Font(16);
        [self.contentView addSubview:_superTitleLable];
        
        
        //产品价格
        _superDiscountLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _superTitleLable.bottom, frame.size.width, (height-10)/3)];
        _superDiscountLable.font = Font(14);
        [self.contentView addSubview:_superDiscountLable];
        
        
        //折扣价
        _superPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(leftFloat, _superDiscountLable.bottom, frame.size.width/2, (height-10)/3)];
        _superPriceLable.font = Font(10);
        [self.contentView addSubview:_superPriceLable];
        
        
        //购买人数
        _superDateLable = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2, _superDiscountLable.bottom, frame.size.width/2-5, (height-10)/3)];
        _superDateLable.font = Font(10);
        _superDateLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_superDateLable];
        
        
        self.layer.cornerRadius = 4;
        self.clipsToBounds = YES;
        [self.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.layer setBorderWidth:0.2];
    }
    return self;
    
}
-(void)loadCellData:(NSDictionary *)dicData
{
    
    [_superHeadImageView sd_setImageWithURL:[NSURL URLWithString:[AppendingImageUrl stringByAppendingString:[dicData valueForKey:@"productIcon"]]] placeholderImage:[UIImage imageNamed:@"cell图片"]];
    _superTitleLable.text = [dicData valueForKey:@"productName"];
 
    NSString* superDiscountLable = [NSString stringWithFormat:@"￥%.1f/斤",[[dicData valueForKey:@"discountPrice"] floatValue]];
    _superPriceLable.attributedText = [Utility rebackDiscountPriceAttr:[NSString stringWithFormat:@"￥%.2f",[[dicData valueForKey:@"price"] floatValue]]];
    _superDiscountLable.font=[UIFont systemFontOfSize:10];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:superDiscountLable];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:16.0]
     
                          range:NSMakeRange(0,superDiscountLable.length-2)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange(0, superDiscountLable.length-2)];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:10.0]
     
                          range:NSMakeRange( superDiscountLable.length-2,2)];
    
    _superDiscountLable.attributedText = AttributedStr;
    _superDateLable.text=[NSString stringWithFormat:@"已有%@人购买",[dicData objectForKey:@"saleNum"]];
    

}

@end
