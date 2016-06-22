//
//  ExchangeRecordTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "ExchangeRecordTableViewCell.h"

@implementation ExchangeRecordTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _leftImageView.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:_leftImageView];
        
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 20)];
        _titleLable.text = @"600积分";
        _titleLable.font = Font(16);
        [self.contentView addSubview:_titleLable];
        
        
        _statusLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 200, 20)];
        _statusLable.text = @"成功";
        [self.contentView addSubview:_statusLable];
        
    }
    return self;
}
-(void)cellWithData:(NSDictionary *)dic
{
    _leftImageView.image = [UIImage imageNamed:[dic valueForKey:@"image"]];
    _titleLable.text = [dic valueForKey:@"title"];
    _statusLable.text = [dic valueForKey:@"status"];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
