//
//  IntrgraHistoryTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "IntrgraHistoryTableViewCell.h"

@implementation IntrgraHistoryTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 20)];
        [self.contentView addSubview:_titleLable];
        
        _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 200, 20)];
        [self.contentView addSubview:_dateLable];
        
        
        _integralLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth-100, 15, 85, 30)];
        _integralLable.textAlignment = NSTextAlignmentRight;
        _integralLable.textColor = RGBA(237, 70, 37, 1);
        [self.contentView addSubview:_integralLable];
        
    }
    return self;
}
-(void)cellWithData:(NSDictionary *)dic
{
    _titleLable.text = [dic valueForKey:@"title"];
    _dateLable.text = [dic valueForKey:@"date"];
    _integralLable.text = [NSString stringWithFormat:@"+%@",[dic valueForKey:@"intergral"]];

    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
