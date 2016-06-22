//
//  UpImageButton.m
//  Cartext
//
//  Created by 谢泽锋 on 16/3/17.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import "UpImageButton.h"
#import "UIView+Getlength.h"
@implementation UpImageButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(self.getWidth*1/3, 2.5, self.getWidth*1/3, self.getHeight*3/5);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, self.getHeight*3/5, self.getWidth, self.getHeight*2/5);
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.titleLabel.font=[UIFont systemFontOfSize:9];
    self.titleLabel.numberOfLines=0;
    self.backgroundColor=[UIColor whiteColor];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
