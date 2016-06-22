//
//  MycollectionTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MycollectionTableViewCell.h"

@implementation MycollectionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
        _productImageView.image = [UIImage imageNamed:@"img"];
        [self.contentView addSubview:_productImageView];
        
        
        _productLable = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+5, 10, 200, 20)];
        _productLable.font = Font(14);
        _productLable.text = @"苹果";
        [self.contentView addSubview:_productLable];
        
        
        
        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+5, _productLable.bottom+5, 200, 20)];
        
        [self.contentView addSubview:_descriptionLable];
        
        
        
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(_productImageView.right+5, _descriptionLable.bottom, 200, 20)];
        _priceLable.text = @"测试";
        
        [self.contentView addSubview:_priceLable];
        
        
        
        _businessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _businessButton.frame = CGRectMake(DeviceWidth-120, _productImageView.top, 100, 20);
        [_businessButton setTitle:@"超市商品" forState:0];
        _businessButton.backgroundColor = RGBA(200, 200, 200, 1);
        _businessButton.layer.cornerRadius = 4;
        _businessButton.clipsToBounds = YES;
        [self.contentView addSubview:_businessButton];
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
