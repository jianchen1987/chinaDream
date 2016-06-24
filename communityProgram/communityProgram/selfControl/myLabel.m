//
//  myLabel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "myLabel.h"

@implementation myLabel

- (nullable instancetype)initWithText:(nonnull NSString *)text FontSize:(CGFloat)size MaxWidth:(CGFloat)maxWidth
{
    self = [super init];
    if(self)
    {
        UIFont *font = [UIFont systemFontOfSize:size];
        CGSize labelSize = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        self.frame = CGRectMake(0, 0, labelSize.width > maxWidth?maxWidth:labelSize.width, labelSize.height);
        self.text = text;
        self.font = font;
    }
    return self;
}

@end
