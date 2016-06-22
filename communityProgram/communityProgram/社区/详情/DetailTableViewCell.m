//
//  DetailTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/2/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
{
    UIImageView *userHeadImageView;//用户头像
    UILabel *userNameLable;//用户昵称
    UIImageView *userSexImageView;//用户性别
    UIImageView *userVIP1ImageView;//预留vip
    UIImageView *userVIP2ImageView;//预留vip
    UILabel *dateLable;//时间
    UILabel *fromLable;//来自哪里
    UILabel *contentLable;//内容
    PictureDobbleContainerView *pictureView;//图文显示
    UIView *lineView;//分割线
    
    
 
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
