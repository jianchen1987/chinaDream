//
//  BaseTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [_headImageView.layer setCornerRadius:_headImageView.width/2];
        _headImageView.clipsToBounds = YES;
        [self.contentView addSubview:_headImageView];
        
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+5, 12, 260, 20)];
        _titleLable.font = Font(17);
        [self.contentView addSubview:_titleLable];
        
        
        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+5, _titleLable.bottom+5, 260, 20)];
        _descriptionLable.font = Font(13);
        [self.contentView addSubview:_descriptionLable];
        
        
        
        _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth-100, 15, 90, 20)];
        _dateLable.font = Font(12);
        _dateLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_dateLable];
        
        
    }
    
    return self;
}
-(void)cellForData:(NSDictionary *)dic
{
    _headImageView.image = [UIImage imageNamed:@"commendImage"];
    _titleLable.text = @"晴天小猪";
    _descriptionLable.text = @"今天是个好日子，心想的事情都能成";
    _dateLable.text = @"2016-01-09";
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
