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
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.frame = CGRectMake(0, 0, self.frame.size.width, 80);
        //logo
        _leftLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (self.frame.size.height - 25)/2, 25, 25)];
        _leftLogoImageView.image = [UIImage imageNamed:@"收货信息"];
        [self.contentView addSubview:_leftLogoImageView];
        
        //name
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftLogoImageView.right + 5, 15, 100, 20)];
        _nameLable.font = [UIFont systemFontOfSize:_TITLE_FONT_SIZE_];
        
        [self.contentView addSubview:_nameLable];
        
        
        _phoneLable = [[UILabel alloc] initWithFrame:CGRectMake(_nameLable.right + 10, 15, 150, 20)];
        _phoneLable.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        [self.contentView addSubview:_phoneLable];
        
        
        _addressLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftLogoImageView.right + 5, self.frame.size.height - 15 - 20, 200, 20)];
        _addressLable.font = [UIFont systemFontOfSize:_DETAIL_FONT_SIZE_];
        [self.contentView addSubview:_addressLable];
        
        _rightModifyBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - 25, (self.frame.size.height - 25)/2, 25, 25)];
        [_rightModifyBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [self.contentView addSubview:_rightModifyBtn];
    
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
