//
//  RightImageButton.m
//  Cartext
//
//  Created by 谢泽锋 on 16/3/17.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import "RightImageButton.h"

@implementation RightImageButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return  CGRectMake(self.titleLabel.frame.size.width+self.titleLabel.frame.origin.x+8, self.frame.size.height/2-3, 6, 6);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
