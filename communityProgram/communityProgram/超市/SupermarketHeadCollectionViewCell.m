//
//  SupermarketHeadCollectionViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/4.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "SupermarketHeadCollectionViewCell.h"

@implementation SupermarketHeadCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height-20)]) {
    
        self.backgroundColor=[UIColor whiteColor];
        _leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 7, 3, 26)];
        _leftView.backgroundColor = RGBA(81, 189, 18, 1);
        [self.contentView addSubview:_leftView];
        
        
        _recommendLable = [[UILabel alloc] initWithFrame:CGRectMake(_leftView.right+10, 10, 100, 20)];
        
        [self.contentView addSubview:_recommendLable];
        
        
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(DeviceWidth-70, 10, 60, 20);
        [_rightButton setImage:[UIImage imageNamed:@"supermaket_right_errow"] forState:0];
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -55);
        _rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, 0);
        [_rightButton setTitleColor:RGBA(30, 30, 30, 1) forState:0];
        [self.contentView addSubview:_rightButton];
    }
    return self;
}
@end
