//
//  UIView+Getlength.m
//  Cartext
//
//  Created by 谢泽锋 on 16/3/17.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import "UIView+Getlength.h"

@implementation UIView (Getlength)
-(float)getX
{
    
    return self.frame.origin.x;
}
-(float)getY
{
    
    return self.frame.origin.y;
}
-(float)getWidth
{
    
    return self.frame.size.width;
}
-(float)getHeight
{
    
    return self.frame.size.height;
}
-(float)getW_X
{
    return self.getWidth+self.getX;
}
-(float)getH_Y{
    return self.getY+self.getHeight;
}

@end
