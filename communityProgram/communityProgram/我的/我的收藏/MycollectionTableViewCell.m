//
//  MycollectionTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MycollectionTableViewCell.h"

@implementation MycollectionTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.frame = CGRectMake(0, 0, DeviceWidth, _COLLECTION_TABLEVIEW_CELL_HEIGHT_);
        
        self.productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, _COLLECTION_TABLEVIEW_CELL_HEIGHT_ - 10, _COLLECTION_TABLEVIEW_CELL_HEIGHT_ - 10)];
        [self.contentView addSubview:self.productImageView];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.productImageView.right+5, 30, self.frame.size.width - self.productImageView.frame.size.width - 10 - 10, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:_TITLE_FONT_SIZE_];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        
        
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.productImageView.right+5, self.titleLabel.bottom+5, self.titleLabel.frame.size.width, 40)];
        self.detailLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        self.detailLabel.textColor = [UIColor colorWithWhite:0.66 alpha:1];
        self.detailLabel.numberOfLines = 2;
        [self.contentView addSubview:self.detailLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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
