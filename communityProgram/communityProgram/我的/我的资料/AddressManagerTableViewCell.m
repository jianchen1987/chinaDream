//
//  AddressManagerTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "AddressManagerTableViewCell.h"

@implementation AddressManagerTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //logo
        _leftLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, 10, 10)];
        _leftLogoImageView.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:_leftLogoImageView];
        
        //name
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(00, 0, 0, 0)];
        
        [self.contentView addSubview:_nameLable];
        
        
        _phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        
        [self.contentView addSubview:_phoneLable];
        
        
        _addressLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _addressLable.font = Font(14);
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
