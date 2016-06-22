//
//  LeftImageButton.m
//  Cartext
//
//  Created by 谢泽锋 on 16/3/22.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import "LeftImageButton.h"
//#import "UIView+Getlength.h"
@implementation LeftImageButton
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return  CGRectMake(self.frame.size.width/2+10, self.frame.size.height/2+10, self.frame.size.height/2-10, self.frame.size.height/2-10);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return  CGRectMake(10, 10, self.frame.size.height/2+10, self.frame.size.height/2+10);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
