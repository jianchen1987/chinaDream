//
//  MyNeiborTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyNeiborTableViewCell.h"

@implementation MyNeiborTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        _headImageView.layer.cornerRadius = 30;
        _headImageView.clipsToBounds = YES;
        [self.contentView addSubview:_headImageView];
        
        
        _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+5, 10, 100, 20)];
        _nameLable.text = @"小高";
        _nameLable.font = Font(15);
        
        [self.contentView addSubview:_nameLable];
        
        
        _sexButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sexButton.frame = CGRectZero;
        
        [self.contentView addSubview:_sexButton];
        
        _VIPButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _VIPButton.frame = CGRectZero;
        [self.contentView addSubview:_VIPButton];
        
        _placeLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+5, _nameLable.bottom, 200, 20)];
        _placeLable.text = @"国际大都市";
        _placeLable.font = Font(13);
        [self.contentView addSubview:_placeLable];
        
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
