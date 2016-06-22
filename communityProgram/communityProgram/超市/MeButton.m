//
//  MeButton.m
//  缤狗
//
//  Created by 谢泽锋 on 15/9/19.
//  Copyright (c) 2015年 xiezefeng. All rights reserved.
//

#import "MeButton.h"

@implementation MeButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    float imageHeight=self.frame.size.height/2;
    float imageWeith=self.frame.size.height/2;
    CGRect rect =CGRectMake(7, (self.frame.size.height-imageHeight)/2, imageWeith, imageHeight);
    self.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    self.titleEdgeInsets=UIEdgeInsetsMake(0, imageWeith, 0, 0);
    self.layer.cornerRadius=4;
    self.backgroundColor=[UIColor whiteColor];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return rect;
}
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//    float x=self.imageView.frame.size.width+self.imageView.frame.origin.x*2;
//    float y=self.imageView.frame.origin.y;
//    float w=self.frame.size.width-x;
//    float h=self.imageView.frame.size.height;
//    CGRect rect =CGRectMake(x, y, w ,h);
//    return rect;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
