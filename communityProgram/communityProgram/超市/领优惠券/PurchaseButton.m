//
//  PurchaseButton.m
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "PurchaseButton.h"

@implementation PurchaseButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 5, 20, 20);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(35, 5, 200, 20);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
