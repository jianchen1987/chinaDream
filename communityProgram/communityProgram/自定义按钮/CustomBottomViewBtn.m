//
//  CustomBottomViewBtn.m
//  communityProgram
//
//  Created by xiaogao on 16/2/20.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CustomBottomViewBtn.h"

@implementation CustomBottomViewBtn
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.width/2-12.5, 5, 25, 25);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 30, self.width, 20);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
