//
//  NeiborTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 15/12/20.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "NeiborTableViewCell.h"

@implementation NeiborTableViewCell
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
    
    UIView *adopBackView;//采纳视图

    UILabel *lineView;//分割线
    UIImageView *adoptUserImageView;//采纳人头像
    UILabel *adoptOpinionNameLable;  //采纳人昵称
    UILabel *adoptOpinionContentLable;
    UIImageView *adoptImageView;//被采纳的图片
    
    UIButton *supportButton;//点赞按钮
    UIButton *shareButton;//分享按钮
    UIButton *commentButton;//评论数
    

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
    //用户名称
    userHeadImageView = [UIImageView new];
    userHeadImageView.backgroundColor = [UIColor grayColor];
    
    
    //用户姓名
    userNameLable = [UILabel new];
    userNameLable.font = Font(14);
    
    //性别
    userSexImageView = [UIImageView new];
    
    //时间
    dateLable = [UILabel new];
    dateLable.font = Font(13);
    
    //来自哪里
    fromLable = [UILabel new];
    fromLable.font = Font(13);
   
    //问问内容
    contentLable = [UILabel new];
    contentLable.font = Font(16);
    contentLable.textAlignment = NSTextAlignmentLeft;
    //图片
    pictureView = [PictureDobbleContainerView new];
    
    //采纳视图
    adopBackView = [UIView new];
    adopBackView.backgroundColor = [UIColor orangeColor];
    //分割线
    lineView = [UILabel new];
    
    
    //采纳人头像
    adoptUserImageView = [UIImageView new];
    
    adoptOpinionNameLable = [UILabel new];
    
    
    //采纳理由
    adoptOpinionContentLable = [UILabel new];
    
    //采纳固定图片
    adoptImageView = [UIImageView new];

    
    //点赞
    supportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [supportButton setTitleColor:[UIColor grayColor] forState:0];

    //分享
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitleColor:[UIColor grayColor] forState:0];

    
    //评论
    commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setTitleColor:[UIColor grayColor] forState:0];

    NSArray *views = @[userHeadImageView, userNameLable, userSexImageView, dateLable,fromLable, contentLable,pictureView,adopBackView,supportButton,shareButton,commentButton];
    
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    
    NSArray *adoptViews = @[lineView,adoptUserImageView,adoptImageView,adoptOpinionNameLable,adoptOpinionContentLable];
    
    [adoptViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [adopBackView addSubview:obj];
    }];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    
    //头像
    userHeadImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    userHeadImageView.layer.cornerRadius = userHeadImageView.width/2;
    userHeadImageView.clipsToBounds = YES;

    
    
    //姓名
    userNameLable.sd_layout
    .leftSpaceToView(userHeadImageView, margin)
    .topEqualToView(userHeadImageView)
    .heightIs(18);
    [userNameLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-60];
    
    
    //时间
    dateLable.sd_layout
    .leftEqualToView(userNameLable)
    .topSpaceToView(userNameLable,0);
    [dateLable setSingleLineAutoResizeWithMaxWidth:160];
    
    
    //来自哪里
    fromLable.sd_layout
    .leftSpaceToView(dateLable,10)
    .topSpaceToView(userNameLable,0);
    [fromLable setSingleLineAutoResizeWithMaxWidth:120];
    
    //内容
    contentLable.sd_layout
    .leftEqualToView(userHeadImageView)
    .topSpaceToView(userHeadImageView, margin)
//    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    [contentLable setIsAttributedContent:YES];
    [contentLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-20];

    
    pictureView.sd_layout
    .leftEqualToView(userHeadImageView);
    
    //采纳视图
    adopBackView.sd_layout
    .leftEqualToView(contentView)
    .topSpaceToView(pictureView,10);
    adopBackView.backgroundColor = [UIColor orangeColor];
    
    //分割线
    lineView.sd_layout
    .leftSpaceToView(contentView,0)
    .topSpaceToView(adopBackView,-1)
    .heightIs(10)
    .widthIs(DeviceWidth);
    
    //采纳人头像
    adoptUserImageView.sd_layout
    .leftSpaceToView(adopBackView, margin)
    .topSpaceToView(lineView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    
    //采纳人姓名
    adoptOpinionNameLable.sd_layout
    .leftSpaceToView(adoptUserImageView, margin)
    .topSpaceToView(lineView, margin + 15)
    .heightIs(18);
    [adoptOpinionNameLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-60];
    
    //采纳图片
    adoptImageView.sd_layout
    .leftSpaceToView(adopBackView, DeviceWidth-60)
    .topSpaceToView(lineView, margin + 5)
    .widthIs(30)
    .heightIs(40);
    
    
    
    adoptOpinionContentLable.sd_layout
    .leftSpaceToView(adopBackView, margin)
    .topSpaceToView(adoptUserImageView,10)
    .heightIs(15);
    [adoptOpinionContentLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-20];
 
    
    supportButton.sd_layout
    .leftSpaceToView(adopBackView,0)
    .topSpaceToView(adopBackView,0)
    .widthIs(DeviceWidth/3)
    .heightIs(30);
    
    shareButton.sd_layout
    .leftSpaceToView(supportButton,0)
    .topSpaceToView(adopBackView,0)
    .widthIs(DeviceWidth/3)
    .heightIs(30);
    
    
    commentButton.sd_layout
    .leftSpaceToView(shareButton,0)
    .topSpaceToView(adopBackView,0)
    .widthIs(DeviceWidth/3)
    .heightIs(30);
    
    
    [self setupAutoHeightWithBottomView:commentButton bottomMargin:5];

}

- (void)setModel:(NeighborModel *)model
{
    userHeadImageView.image = [UIImage imageNamed:model.userImageUrl];
    userNameLable.text = model.userName;
    dateLable.text = model.createTime;
    fromLable.text = model.quarterName;
    
    NSString *str = @"";
    NSMutableAttributedString *attribute = [str TextNormalEmotion:model.remark];
    contentLable.attributedText = attribute;
//    contentLable.text = model.remark;
    
    
    pictureView.picturesArray = model.images;

    CGFloat picContainerTopMargin = 0;
    if (model.images.count)
    {
        picContainerTopMargin = 10;
    }
    pictureView.sd_layout.topSpaceToView(contentLable, picContainerTopMargin);

    if (model.other)
    {
        adoptUserImageView.image = [UIImage imageNamed:model.userImageStr];
        adoptOpinionNameLable.text = model.userNameStr;
        adoptOpinionContentLable.text = model.userCommentStr;
        adoptImageView.image = [UIImage imageNamed:@"community_adopt"];
        adopBackView.sd_layout.heightIs(100);
        adopBackView.hidden = NO;
    }else
    {
        adopBackView.sd_layout.heightIs(0);
        adopBackView.hidden = YES;
    }
    
    adopBackView.sd_layout.topSpaceToView(pictureView, 5);
    [supportButton setTitle:@"3" forState:0];
    [supportButton setImage:[UIImage imageNamed:@"community_love_non"] forState:0];
    [shareButton setTitle:@"分享" forState:0];
    [shareButton setImage:[UIImage imageNamed:@"community_share"] forState:0];
    [commentButton setTitle:@"评论" forState:0];
    [commentButton setImage:[UIImage imageNamed:@"community_commend"] forState:0];
    

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
