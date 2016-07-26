//
//  IntegralMallTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/2/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "IntegralMallTableViewCell.h"

@implementation IntegralMallTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        _leftImageView.image = [UIImage imageNamed:@"shoes"];
        [self.contentView addSubview:_leftImageView];
        
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, 10, DeviceWidth-_leftImageView.right-15, 20)];
        _titleLable.text = @"最新款NIKI";
        [self.contentView addSubview:_titleLable];
        
        
        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _titleLable.bottom, DeviceWidth-_leftImageView.right-15, 40)];
        _descriptionLable.font = Font(14);
        _descriptionLable.text = @"测试测试测试测试测试测试测试测试测试测试";
        [self.contentView addSubview:_descriptionLable];
        
        
        _integralLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _descriptionLable.bottom, 200, 30)];
        _integralLable.text = @"3000积分";
        [self.contentView addSubview:_integralLable];
        
        _detailIntegralLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _leftImageView.bottom-20, 200, 20)];
        _detailIntegralLable.text = @"或者是2000积分+100元";
        [self.contentView addSubview:_detailIntegralLable];
        
        
        
        _sealNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth-70, _leftImageView.bottom-20, 60, 20)];
        _sealNumberLable.text = @"已售12";
        [self.contentView addSubview:_sealNumberLable];
        
        
        
    }
    return self;
}
-(void)setCellData:(NSDictionary *)dic
{
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
