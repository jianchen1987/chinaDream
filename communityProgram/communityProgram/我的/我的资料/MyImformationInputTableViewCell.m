//
//  MyImformationInputTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyImformationInputTableViewCell.h"

@implementation MyImformationInputTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _inputTextFeild = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, DeviceWidth-110, 44)];
        _inputTextFeild.font = [UIFont systemFontOfSize:_TITLE_FONT_SIZE_];
        [self.contentView addSubview:_inputTextFeild];
        self.textLabel.textColor = RGBA(93, 93, 93, 1);
        self.textLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        
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
