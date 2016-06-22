//
//  MoreProductTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MoreProductTableViewCell.h"

@implementation MoreProductTableViewCell
{
    UIImageView *_productImageView;
    UILabel *_titleLable;
    UILabel *_descptionLable;
    UILabel *_priceLable;
    UILabel *_discountPriceLable;
    UILabel *_buyNumLable;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    //产品图片
    _productImageView = [UIImageView new];
    
    
    
    //产品标题
    _titleLable = [UILabel new];
    _titleLable.font = Font(15);
    
    //产品描述
    _descptionLable = [UILabel new];
    _descptionLable.font = Font(14);
    //产品价格
    _priceLable = [UILabel new];
    _priceLable.textAlignment = NSTextAlignmentLeft;
    //产品折扣价
    _discountPriceLable = [UILabel new];
    _discountPriceLable.font = Font(13);
    
    //购买数量
    _buyNumLable = [UILabel new];
    _buyNumLable.textAlignment = NSTextAlignmentRight;
    _buyNumLable.font = Font(13);
    
    NSArray *viewArray = @[_productImageView,_titleLable,_descptionLable,_priceLable,_discountPriceLable,_buyNumLable];;
    
    [viewArray enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;

    //产品图片
    _productImageView.sd_layout
    .leftSpaceToView(contentView,margin)
    .topSpaceToView(contentView,margin+5)
    .widthIs(100)
    .heightIs(100);

    
    //产品标题
    _titleLable.sd_layout
    .leftSpaceToView(_productImageView,margin)
    .topEqualToView(_productImageView)
    .heightIs(15);
    [_titleLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-120];
    
    
    
    //产品描述
    _descptionLable.sd_layout
    .leftSpaceToView(_productImageView,margin)
    .topSpaceToView(_titleLable,5)
    .heightIs(14)
    .autoHeightRatio(0);
    [_descptionLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-130];
    
    
    //产品价格
    _priceLable.sd_layout
    .leftSpaceToView(_productImageView,margin)
//    .rightSpaceToView(contentView,10)
    .topSpaceToView(_descptionLable,10)
    .heightIs(15);
    [_priceLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-120];
    
    
    //产品折扣价
    _discountPriceLable.sd_layout
    .leftSpaceToView(_productImageView,margin)
    .topSpaceToView(_priceLable,5)
    .heightIs(12);
    [_discountPriceLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-120];
    
    //购买数量
    _buyNumLable.sd_layout
    .rightSpaceToView(contentView,10)
    .topSpaceToView(_priceLable,5)
    .heightIs(12);
    [_buyNumLable setSingleLineAutoResizeWithMaxWidth:100];
    
    [self setupAutoHeightWithBottomView:_productImageView bottomMargin:15];

    
}
- (void)setModel:(BaseProductModel *)model
{
    _productImageView.image = [UIImage imageNamed:@"apple-1"];
    _titleLable.text = @"新味道烟台苹果";
    _descptionLable.text = @"新鲜采摘，原生种植，洗洗果皮立即能吃";
    _descptionLable.sd_layout.maxHeightIs(40);
    _descptionLable.sd_layout.minHeightIs(40);
    _priceLable.text = @"￥3.00/斤";
    _discountPriceLable.text = @"门市价:￥4.00/斤";
    _buyNumLable.text = @"已有222人购买";
//    _buyNumLable.sd_layout.topSpaceToView(_discountPriceLable, 5);

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
