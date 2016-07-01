//
//  MoreTogetherTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MoreTogetherTableViewCell.h"
@implementation MoreTogetherTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
        
        [self.contentView addSubview:_leftImageView];
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, 5, 200, 20)];
        
        [self.contentView addSubview:_titleLable];
        
        
        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _titleLable.bottom+5, 200, 35)];
        _descriptionLable.font=[UIFont systemFontOfSize:15];
        _descriptionLable.numberOfLines=2;
        _descriptionLable.textColor=RGBA(137, 137, 137, 1);
        [self.contentView addSubview:_descriptionLable];
        
        
//        _persentLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _descriptionLable.bottom, 80, 20)];
//        _persentLable.font = Font(13);
//        [self.contentView addSubview:_persentLable];
        
       _progressView=[[ProgressView alloc]initWithFrame:CGRectMake(_leftImageView.right, _descriptionLable.bottom+5, 150, 15)];

        _progressView.progressValue=0.5;
        _progressView.prompt=@"已达到";
        [self addSubview:_progressView];

        
        _persentLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftImageView.right+5, _progressView.bottom, DeviceWidth-_leftImageView.right-20, 20)];
//        _timeLimitLable.text = @"支撑人数";
        _persentLable.font = Font(13);
        _persentLable.textColor = RGBA(200, 200, 200, 1);
        [self.contentView addSubview:_persentLable];
        _endImageView=[[UIImageView alloc]initWithFrame:CGRectMake(DeviceWidth-70, 30, 70, 70)];
        _endImageView.image=[UIImage imageNamed:@"项目成功"];
        _endImageView.hidden=YES;
        [self.contentView addSubview:_endImageView];
        
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
