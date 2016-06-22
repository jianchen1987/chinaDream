//
//  MoreTogetherDetailTableViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/3/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MoreTogetherDetailTableViewCell.h"
#import "AdditionSubtractionControl.h"
@implementation MoreTogetherDetailTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, DeviceWidth-20, 20)];
        _titleLable.text = @"测试测试测试测试";
        [self.contentView addSubview:_titleLable];
        
        
        
        _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(10, _titleLable.bottom, DeviceWidth-20, 40)];
        _detailLable.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
        [self.contentView addSubview:_detailLable];
        
        
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(10, _detailLable.bottom+5, 100, 20)];
        _priceLable.font = Font(17);
        _priceLable.text = @"2.00/斤";
        [self.contentView addSubview:_priceLable];
        
        
        _discountLable = [[UILabel alloc] initWithFrame:CGRectMake(_priceLable.right+5, _detailLable.bottom+5, 200, 20)];
        _discountLable.text = @"￥3.00/斤";
        [self.contentView addSubview:_discountLable];
        
        
        UIView *firstLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _discountLable.bottom+5, DeviceWidth, 1)];
        firstLineView.backgroundColor = RGBA(240, 240, 240, 1);
        [self.contentView addSubview:firstLineView];
        
        
        _firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _firstButton.frame = CGRectMake(10, firstLineView.bottom+5, 200, 30);
        [_firstButton setImage:[UIImage imageNamed:@""] forState:0];
        [_firstButton setTitle:@"已筹到:488斤" forState:0];
        _firstButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_firstButton setTitleColor:[UIColor redColor] forState:0];
        [self.contentView addSubview:_firstButton];
        
        
        _targetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _targetButton.frame = CGRectMake(10, _firstButton.bottom+5, 200, 30);
        [_targetButton setImage:[UIImage imageNamed:@""] forState:0];
        [_targetButton setTitle:@"目标:600斤" forState:0];
        [_targetButton setTitleColor:[UIColor redColor] forState:0];
        _targetButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.contentView addSubview:_targetButton];
        
        
        UIView *secondLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _targetButton.bottom+5, DeviceWidth, 1)];
        secondLineView.backgroundColor = RGBA(240, 240, 240, 1);
        [self.contentView addSubview:secondLineView];
        
        UILabel *buyNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(10, secondLineView.bottom+5, 100, 20)];
        buyNumberLable.text = @"购买数量";
        buyNumberLable.textColor = RGBA(153, 153, 153, 1);
        [self.contentView addSubview:buyNumberLable];
        
//        AddNumberView *addView = [[AddNumberView alloc] initWithFrame:CGRectMake(DeviceWidth-120, buyNumberLable.top, 100, 30)];
//        addView.delegate=self;
//        [self.contentView addSubview:addView];
        AdditionSubtractionControl * add=[[AdditionSubtractionControl alloc]initWithFrame:CGRectMake(DeviceWidth-120, buyNumberLable.top, 100, 28)];
        _AdditionSubtractionView=add;
        [self.contentView addSubview:_AdditionSubtractionView];
        
        
        
        
        
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
