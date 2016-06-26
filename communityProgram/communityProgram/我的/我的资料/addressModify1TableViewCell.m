//
//  addressModify1TableViewCell.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "addressModify1TableViewCell.h"

@implementation addressModify1TableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.textField = [[UITextField alloc] init];
        self.textField.frame = CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height);
        self.textField.font  = [UIFont systemFontOfSize:_TITLE_FONT_SIZE_];
        [self.contentView addSubview:self.textField];
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
