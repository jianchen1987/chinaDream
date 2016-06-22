//
//  CustomAdotView.m
//  communityProgram
//
//  Created by xiaogao on 16/1/19.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CustomAdotView.h"

@implementation CustomAdotView

-(id)initWithFrame:(CGRect)frame WithData:(NSDictionary *)dicData
{
    if (self = [super initWithFrame:frame])
    {
        _adoptImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 10, 20)];
        _adoptImageView.image = [UIImage imageNamed:[dicData valueForKey:@"image"]];
        [self addSubview:_adoptImageView];
        
        
        _adoptHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_adoptImageView.right+15, 15, 25, 25)];
        _adoptHeadImageView.image = [UIImage imageNamed:[dicData valueForKey:@"headImage"]];
        
        [self addSubview:_adoptHeadImageView];
        
        
        
        _adoptNameLable = [[UILabel alloc] initWithFrame:CGRectMake(_adoptHeadImageView.left, _adoptHeadImageView.top, 200, 20)];
        [self addSubview:_adoptNameLable];
        
        
        _adoptContentLable = [[UILabel alloc] initWithFrame:CGRectMake(_adoptImageView.right+15, _adoptHeadImageView.bottom+10, DeviceWidth, 20)];
        [self addSubview:_adoptContentLable];
    }
    return self;
}

-(void)setAdoptViewData:(NSDictionary *)dic
{
    self.frame = CGRectMake(0, 0, DeviceWidth, 100);
}

@end
