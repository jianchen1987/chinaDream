//
//  NotificationTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "NotificationTableViewCell.h"

@implementation NotificationTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, DeviceWidth-30, 20)];
        
        [self.contentView addSubview:_titleLable];
        
        
        _dateLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 35, DeviceWidth-30, 20)];
        [self.contentView addSubview:_dateLable];
    }
    return self;
}
-(void)cellForData:(NSDictionary *)dic
{
    _titleLable.text = [dic valueForKey:@"content"];
    _dateLable.text = [[dic valueForKey:@"createTime"] substringToIndex:10];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
