//
//  PurchaseTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "PurchaseTableViewCell.h"

@implementation PurchaseTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        _headImageView.image = [UIImage imageNamed:@""];
        [self.contentView addSubview:_headImageView];
        
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+10, 10, 200, 20)];
//        _titleLable.text = @"美邻说";
        [self.contentView addSubview:_titleLable];
        
        
        
        _desLable = [[UILabel alloc] initWithFrame:CGRectMake(_headImageView.right+10, _titleLable.bottom+5, 260, 20)];
//        _desLable.text = @"新年系统20元红包";
        [self.contentView addSubview:_desLable];
        
        
        
        _dateButton = [PurchaseButton buttonWithType:UIButtonTypeCustom];
        _dateButton.frame = CGRectMake(10, _headImageView.bottom+5, DeviceWidth, 30);
        [_dateButton setImage:[UIImage imageNamed:@""] forState:0];
        [_dateButton setTitleColor:[UIColor grayColor] forState:0];
        _dateButton.titleLabel.font = Font(14);
        [self.contentView addSubview:_dateButton];
    }
    return self;
}
-(void)loadCellData:(NSDictionary *)dic
{
    NSLog(@"dic = %@",dic);
    NSString *imageStr = [AppendingImageUrl stringByAppendingString:[dic valueForKey:@"couponBatchImages"]];
    
    _headImageView.image = [UIImage imageNamed:@""];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@""]];
    
    _titleLable.text = [dic valueForKey:@"batchNm"];
    _desLable.text = [dic valueForKey:@"couponNumPrefix"];
    if ([dic valueForKey:@"endTime"]) {
        [_dateButton setTitle:[NSString stringWithFormat:@"有效期至%@",[dic valueForKey:@"endTime"]] forState:0];
    }else
    {
        [_dateButton setTitle:@"已过期" forState:0];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
