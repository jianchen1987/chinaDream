//
//  DirectMessageTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "DirectMessageTableViewCell.h"

@implementation DirectMessageTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        _leftImageView.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:_leftImageView];
        
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, DeviceWidth-50, 20)];
        [self.contentView addSubview:_titleLable];
        
        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(40, _titleLable.frame.origin.y+_titleLable.frame.size.height+5, DeviceWidth-50, 20)];
        _descriptionLable.font = Font(14);
        [self.contentView addSubview:_descriptionLable];
        
        
        _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(40, _descriptionLable.frame.origin.y+_descriptionLable.frame.size.height+5, DeviceWidth-50, 20)];
        _dateLable.font = Font(12);
        [self.contentView addSubview:_dateLable];
        
        
        self.frame = CGRectMake(0, 0, DeviceWidth, _dateLable.frame.origin.y+_dateLable.frame.size.height+5);
    }
    return self;
}
-(void)cellWithData:(NSDictionary *)dic
{
    _leftImageView.image = [UIImage imageNamed:@""];
    _titleLable.text = @"客服";
    _descriptionLable.text = @"您好，我是客服，请问有什么可以帮到您的吗？";
    _dateLable.text = @"2015-12-28";
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
