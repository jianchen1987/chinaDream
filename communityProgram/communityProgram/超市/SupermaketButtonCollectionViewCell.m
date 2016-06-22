//
//  SupermaketButtonCollectionViewCell.m
//  communityProgram
//
//  Created by xiaogao on 16/1/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//



#import "SupermaketButtonCollectionViewCell.h"

@implementation SupermaketButtonCollectionViewCell
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-20, 5, 40, 40)];
        [self.contentView addSubview:_headImageView];
        
        
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _headImageView.bottom+5, frame.size.width, 20)];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        if (DeviceWidth == 320) {
            _titleLable.font = Font(13);
        }else
        {
            _titleLable.font = Font(16);
        }
        [self.contentView addSubview:_titleLable];
        
        
    }
    return self;
}
@end
