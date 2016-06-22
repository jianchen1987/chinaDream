//
//  OrderSectionTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "OrderSectionTableViewCell.h"

@implementation OrderSectionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        _leftImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_leftImageView];
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, 10, 200, 20)];
        _titleLable.text = @"苹果乐园";
        _titleLable.font = Font(15);
        [self.contentView addSubview:_titleLable];
    
        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _titleLable.bottom, 200, 20)];
        _descriptionLable.text = @"测试测试测试测试测试测试测试测试测试";
        [self.contentView addSubview:_descriptionLable];
        
        
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _descriptionLable.bottom, 200, 20)];
        _priceLable.font = Font(15);
        _priceLable.text = @"￥4.00/斤";
        [self.contentView addSubview:_priceLable];
        
        
        _discountLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _priceLable.bottom, 200, 20)];
        _discountLable.text = @"￥4.00/斤";
        [self.contentView addSubview:_discountLable];
        
        UIView *firstLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _leftImageView.bottom+5, DeviceWidth, 1)];
        firstLineView.backgroundColor = RGBA(240, 240, 240, 1);
        [self.contentView addSubview:firstLineView];
        
        _numberLable = [[UILabel alloc] initWithFrame:CGRectMake(10, firstLineView.bottom+10, 100, 30)];
        _numberLable.font = Font(15);
        _numberLable.text = @"购买数量";
        [self.contentView addSubview:_numberLable];
        
        _addNumView = [[AddNumberView alloc] initWithFrame:CGRectMake(DeviceWidth-160, _numberLable.top, 120, 30)];
        _addNumView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_addNumView];
        
        UIView *secondLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _addNumView.bottom+5, DeviceWidth, 1)];
        secondLineView.backgroundColor = RGBA(240, 240, 240, 1);
        [self.contentView addSubview:secondLineView];
        
        
        _messageLable = [[UILabel alloc] initWithFrame:CGRectMake(10, secondLineView.bottom+10, 100, 30)];
        _messageLable.text = @"买家留言";
        [self.contentView addSubview:_messageLable];
        
        
        _messageTextField = [[UITextField alloc] initWithFrame:CGRectMake(_messageLable.right, _messageLable.top, 200, 40)];
        _messageTextField.placeholder = @"信息留言 (限制30字以内)";
        _messageTextField.font = Font(16);
        [self.contentView addSubview:_messageTextField];
        
        
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
