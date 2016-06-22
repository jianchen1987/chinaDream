//
//  titleButton.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/16.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    float imageHeight=25;
    float imageWeith=25;
    CGRect rect =CGRectMake(self.frame.size.width-imageWeith, (self.frame.size.height-imageHeight)/2, imageWeith, imageWeith);
    self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
//    self.titleEdgeInsets=UIEdgeInsetsMake(0, imageWeith, 0, 0);
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont systemFontOfSize:18];
    return rect;
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGRect rect =CGRectMake(0, 0, self.frame.size.width-25, self.frame.size.height);
    self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    return rect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
