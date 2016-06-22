//
//  ProductCommendTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ProductCommendTableViewCell.h"

@implementation ProductCommendTableViewCell
{
    UIImageView *headImageView;
    UILabel *nameLable;
    UILabel *timeLable;
    UILabel *commentContentLable;
    UIView *backView;
    UILabel *_addCommentLable;
    UILabel *_addCommentNameLable;
    UILabel *_addCommentTimeLable;
    UILabel *_addCommentContentLable;
    PictureContainerView *_picContainerView;
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
    //评论者头像
    headImageView = [UIImageView new];
    headImageView.layer.cornerRadius = headImageView.frame.size.width/2;
    
    
    //评论者昵称
    nameLable = [UILabel new];
    nameLable.font = [UIFont systemFontOfSize:14];
    
    //时间
    timeLable = [UILabel new];
    
    //评论
    commentContentLable = [UILabel new];
    commentContentLable.font = Font(15);
    _picContainerView = [PictureContainerView new];
    
    
    //追加评论view
    backView = [UIView new];
    backView.backgroundColor = RGBA(240, 240, 240, 1);
    
    _addCommentLable = [UILabel new];
    _addCommentLable.font = [UIFont systemFontOfSize:13];
    
    //评论者名称
    _addCommentNameLable = [UILabel new];
    
    //时间
    _addCommentTimeLable = [UILabel new];
    _addCommentTimeLable.font = [UIFont systemFontOfSize:12];
    
    
    //内容
    _addCommentContentLable = [UILabel new];
    _addCommentContentLable.numberOfLines = 2;
    _addCommentContentLable.font = Font(14);
    
    NSArray *views = @[headImageView, nameLable, timeLable, commentContentLable,_picContainerView, backView];
    
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    NSArray *secondViews = @[_addCommentLable,_addCommentNameLable,_addCommentTimeLable,_addCommentContentLable];
    
    [secondViews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [backView addSubview:obj];
    }];
    
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    
    //头像
    headImageView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin + 5)
    .widthIs(40)
    .heightIs(40);
    
    
    //姓名
    nameLable.sd_layout
    .leftSpaceToView(headImageView, margin)
    .topEqualToView(headImageView)
    .heightIs(18);
    [nameLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-60];
    
    timeLable.sd_layout
    .leftEqualToView(nameLable)
    .topSpaceToView(nameLable,0);
    [timeLable setSingleLineAutoResizeWithMaxWidth:200];
    
    
    commentContentLable.sd_layout
    .leftEqualToView(headImageView)
    .topSpaceToView(headImageView, margin)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    [commentContentLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-20];
    
    
    _picContainerView.sd_layout
    .leftEqualToView(headImageView);
    
    backView.sd_layout
    .leftEqualToView(headImageView)
    .topSpaceToView(_picContainerView,10)
    .rightSpaceToView(contentView,10);
    
    
    //追加评论
    _addCommentLable.sd_layout
    .leftSpaceToView(backView, 10)
    .topSpaceToView(backView, 5)
    .heightIs(16);
    [_addCommentLable setSingleLineAutoResizeWithMaxWidth:80];
    
    
    _addCommentNameLable.sd_layout
    .leftSpaceToView(_addCommentLable, margin)
    .topSpaceToView(backView, 5)
    .heightIs(16);
    [_addCommentNameLable setSingleLineAutoResizeWithMaxWidth:100];
    
    
    _addCommentTimeLable.sd_layout
    .leftSpaceToView(_addCommentNameLable, margin)
    .topSpaceToView(backView,5)
    .heightIs(16);
    [_addCommentTimeLable setSingleLineAutoResizeWithMaxWidth:200];
    
    
    
    _addCommentContentLable.sd_layout
    .leftSpaceToView(backView, 5)
    .topSpaceToView(_addCommentLable,10)
    .heightIs(15);
    //    .autoHeightRatio(0);
    [_addCommentContentLable setSingleLineAutoResizeWithMaxWidth:DeviceWidth-20];
    
    [self setupAutoHeightWithBottomView:backView bottomMargin:10];
    
}
- (void)setModel:(CommentModle *)model
{
    nameLable.text = model.commentName;
    headImageView.backgroundColor = [UIColor grayColor];
    headImageView.layer.cornerRadius = headImageView.frame.size.width/2;
    headImageView.clipsToBounds = YES;
    timeLable.text = model.commentTime;
    commentContentLable.text = model.commentContent;
    _picContainerView.picPathStringsArray = model.picNamesArray;
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(commentContentLable, picContainerTopMargin);
    
    CGFloat addCommentMargin = 0;
    
    if (model.addDic)
    {
        _addCommentLable.text = @"追加评论";
        _addCommentNameLable.text = [model.addDic valueForKey:@"name"];
        _addCommentTimeLable.text = [model.addDic valueForKey:@"time"];
        _addCommentContentLable.text = [model.addDic valueForKey:@"comment"];
        _addCommentContentLable.numberOfLines = 2;
        backView.sd_layout.heightIs(_addCommentContentLable.height+40);
        backView.hidden = NO;
    }else
    {
        backView.sd_layout.heightIs(0);
        backView.hidden = YES;
    }
    backView.sd_layout.topSpaceToView(_picContainerView, addCommentMargin+5);

}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
