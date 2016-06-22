//
//  ProductDetailTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ProductDetailTableViewCell.h"

@implementation ProductDetailTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _productTitleLable = [RHMethods labelWithFrame:CGRectMake(10, 5, DeviceWidth-20, 20) font:Font(16) color:RGBA(51, 51, 51, 1) text:@""];
 
        [self.contentView addSubview:_productTitleLable];
        
        _productDescriptionLable = [RHMethods labelWithFrame:CGRectMake(10, _productTitleLable.bottom+5, DeviceWidth-20, 20) font:Font(13) color:[UIColor grayColor] text:@""];
        [self.contentView addSubview:_productDescriptionLable];
        
        _productPriceLable = [RHMethods labelWithFrame:CGRectMake(10, _productDescriptionLable.bottom+5, 100, 20) font:Font(16) color:[UIColor redColor] text:@""];
        [self.contentView addSubview:_productPriceLable];
        
        
        _productDiscountLable = [RHMethods labelWithFrame:CGRectMake(_productPriceLable.right+20, _productDescriptionLable.bottom+5, 120, 20) font:Font(13) color:[UIColor grayColor] text:@""];
        [self.contentView addSubview:_productDiscountLable];
        
        
        _productBuyNumberLable = [RHMethods labelWithFrame:CGRectMake(DeviceWidth-100, _productDescriptionLable.bottom+5, 90, 20) font:Font(13) color:[UIColor grayColor] text:@""];
        [self.contentView addSubview:_productBuyNumberLable];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _productBuyNumberLable.bottom+5, DeviceWidth, 1)];
        lineView.backgroundColor = RGBA(240, 240, 240, 1);
        [self.contentView addSubview:lineView];
        
        
        
        UILabel *buyLable = [RHMethods labelWithFrame:CGRectMake(15, lineView.bottom+10, 100, 30) font:Font(12) color:[UIColor grayColor] text:@"购买数量"];
        [self.contentView addSubview:buyLable];
        
        
//        _numberView = [[AddNumberView alloc] initWithFrame:CGRectMake(DeviceWidth-120, lineView.bottom+10, 100, 30)];
//        _numberView.middleNumberLable.text = @"1";
//        [self.contentView addSubview:_numberView];
        _AdditionSubtraction=[[AdditionSubtractionControl alloc]initWithFrame:CGRectMake(DeviceWidth-120, lineView.bottom+10, 100, 28)];
        [self.contentView addSubview:_AdditionSubtraction];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, buyLable.bottom+9, DeviceWidth, 1)];
        lineView.backgroundColor = RGBA(240, 240, 240, 1);
        [self.contentView addSubview:lineView];
        
        
        
    }
    return self;
}
-(void)loadCellData:(NSDictionary *)dic
{
    NSLog(@"dic = %@",dic);
    if (dic) {
        _productTitleLable.text = [dic valueForKey:@"productName"];
        _productDescriptionLable.text = [dic valueForKey:@"simpleIntro"];
        _productPriceLable.text = [NSString stringWithFormat:@"￥%@元/斤",[dic valueForKey:@"price"]];
       
        _productPriceLable.attributedText=[self AttributedString:[NSString stringWithFormat:@"￥%@元/斤",[dic valueForKey:@"price"]] rangeString:@"/斤" color: [UIColor grayColor]];
        _productDiscountLable.text = [NSString stringWithFormat:@"原价￥%@/斤",[dic valueForKey:@"discountPrice"]];
        _productBuyNumberLable.text = [NSString stringWithFormat:@"已有%@人购买",[dic valueForKey:@"stock"]];
        self.frame = CGRectMake(0, 0, DeviceWidth, _AdditionSubtraction.bottom+10);

    }
}
-(NSMutableAttributedString*)AttributedString:(NSString*)allstring rangeString:(NSString*)rangeString color:(UIColor*)color
{
    NSMutableAttributedString* string=[[NSMutableAttributedString alloc]initWithString:allstring];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[allstring rangeOfString:allstring]];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[allstring rangeOfString:rangeString]];
    [string addAttribute:NSForegroundColorAttributeName value:color range:[allstring rangeOfString:rangeString]];
    
    return string;
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
