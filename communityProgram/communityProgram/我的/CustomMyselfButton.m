//
//  CustomMyselfButton.m
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "CustomMyselfButton.h"

@implementation CustomMyselfButton
//-(id)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        _descriptionLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 8, frame.size.width, 20)];
//        _descriptionLable.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_descriptionLable];
//        
//        
//        _desDataLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bottom-28, frame.size.width, 20)];
//        _desDataLable.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_desDataLable];
//    }
//    return self;
//}


-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 40, self.width, 20);
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.width/2-15, 5, 30, 30);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
