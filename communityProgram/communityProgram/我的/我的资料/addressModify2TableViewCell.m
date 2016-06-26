//
//  addressModify2TableViewCell.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "addressModify2TableViewCell.h"

@implementation addressModify2TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.checkBoxBtn = [[UIButton alloc] init];
        [self.checkBoxBtn setImage:[UIImage imageNamed:@"selectBox"] forState:UIControlStateNormal];
        [self.checkBoxBtn setImage:[UIImage imageNamed:@"selectedBox"] forState:UIControlStateSelected];
        self.checkBoxBtn.frame = CGRectMake(self.frame.size.width - 20 - 15 , (self.frame.size.height - 25)/2, 25, 25);
        
        [self.contentView addSubview:self.checkBoxBtn];
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
