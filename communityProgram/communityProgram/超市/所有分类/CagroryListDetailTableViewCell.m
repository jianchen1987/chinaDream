//
//  CagroryListDetailTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CagroryListDetailTableViewCell.h"

@implementation CagroryListDetailTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        _leftImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_leftImageView];
        
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, 10, DeviceWidth-_leftImageView.right-20, 20)];
        _titleLable.text = @"苹果乐园";
        [self.contentView addSubview:_titleLable];
        
        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _titleLable.bottom, DeviceWidth-_leftImageView.right-20, 40)];
        _descriptionLable.text = @"测试测试测试测试测试测试测试测试测试测试";
        [self.contentView addSubview:_descriptionLable];
        
        
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _descriptionLable.bottom, 100, 20)];
        _priceLable.text = @"测试";
        [self.contentView addSubview:_priceLable];
        
        
        _discountLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _priceLable.bottom, 200, 20)];
        _discountLable.text = @"测试";
        [self.contentView addSubview:_discountLable];
        
        _sealLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth-120, _discountLable.top, 100, 20)];
        _sealLable.font = Font(16);
        _sealLable.text = @"已售100";
        [self.contentView addSubview:_sealLable];
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
