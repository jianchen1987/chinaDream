//
//  AddressTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _addressImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 20, 20)];
        _addressImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_addressImageView];
        
        
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(_addressImageView.right+5, 10, 100, 20)];
        _nameLable.text = @"老高";
        _nameLable.font = Font(15);
        [self.contentView addSubview:_nameLable];
        
        _phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(_nameLable.right+5, 10, 200, 20)];
        _phoneLable.text = @"18924013722";
        _phoneLable.font = Font(15);
        [self.contentView addSubview:_phoneLable];
        
        
        _addressLable = [[UILabel alloc] initWithFrame:CGRectMake(_addressImageView.right+5, _phoneLable.bottom+5, 300, 20)];
        _addressLable.text = @"广州市天河区车陂楼  ";
        [self.contentView addSubview:_addressLable];
        
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
