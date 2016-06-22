//
//  SasuallyTalkTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/2/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "SasuallyTalkTableViewCell.h"

@implementation SasuallyTalkTableViewCell
{
    UIImageView *userHeadImageView;//用户头像
    UILabel *userNameLable;//用户昵称
    UIImageView *userSexImageView;//用户性别
    UIImageView *userVIP1ImageView;//预留vip
    UIImageView *userVIP2ImageView;//预留vip
    UILabel *dateLable;//时间
    UILabel *placeLable;//来自哪里
    UILabel *contentLable;//内容
    PictureContainerView *pictureView;//图文显示
    UIButton *collectionButton;
    UIButton *shareButton;
    UIButton *commentButton;
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    //头像
    userHeadImageView = [UIImageView new];
    userHeadImageView.layer.cornerRadius = userHeadImageView.width/2;
    userHeadImageView.clipsToBounds = YES;
    
    //昵称
    userNameLable = [UILabel new];
    userNameLable.font = Font(14);
    
    userSexImageView = [UIImageView new];
    userSexImageView.layer.cornerRadius = userSexImageView.width/2;
    
    
    userVIP1ImageView = [UIImageView new];
    userVIP1ImageView.layer.cornerRadius = userVIP1ImageView.width/2;

    userVIP2ImageView = [UIImageView new];
    userVIP2ImageView.layer.cornerRadius = userVIP2ImageView.width/2;

    dateLable = [UILabel new];
    dateLable.font = Font(12);
    
    
    placeLable = [UILabel new];
    placeLable.font = Font(12);
    
    contentLable = [UILabel new];
    
    
    pictureView = [PictureContainerView new];
    
    //收藏按钮
    collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //分享按钮
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //评论按钮
    commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    NSArray *views = @[userHeadImageView, userNameLable, userSexImageView, userVIP1ImageView,userVIP2ImageView, dateLable,placeLable,contentLable,pictureView,collectionButton,shareButton,commentButton];
    
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    
    //头像
    userHeadImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    //姓名
    userNameLable.sd_layout
    .leftSpaceToView(userHeadImageView, margin)
    .topEqualToView(userHeadImageView)
    .heightIs(18);
    [userNameLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-60];
    
    userSexImageView.sd_layout
    .topEqualToView(userNameLable)
    .rightSpaceToView(userNameLable,10)
    .widthIs(10)
    .heightIs(10);
    
    userVIP1ImageView.sd_layout
    .topEqualToView(userNameLable)
    .rightSpaceToView(userSexImageView,5)
    .widthIs(10)
    .heightIs(10);
    
    userVIP2ImageView.sd_layout
    .topEqualToView(userNameLable)
    .rightSpaceToView(userVIP1ImageView,5)
    .widthIs(10)
    .heightIs(10);
    
    
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
