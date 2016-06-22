//
//  CustomSupermarketBtn.m
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//
#import "CustomSupermarketBtn.h"
#define BW 30
#define BH 30
@implementation CustomSupermarketBtn
//-(CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(self.width/2-25, 5, 50, 50);
//}
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(0, self.height-25, self.width, 20);
//}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    return CGRectMake((self.width-BW)/2, 15, BW, BH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.height-BW, self.width, 20);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end








