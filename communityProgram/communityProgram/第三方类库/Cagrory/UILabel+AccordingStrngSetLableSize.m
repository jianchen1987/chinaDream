//
//  UILabel+AccordingStrngSetLableSize.m
//  Categrory
//
//  Created by 峰馨雪月 on 14-5-3.
//  Copyright (c) 2014年 高国峰. All rights reserved.
//

#import "UILabel+AccordingStrngSetLableSize.h"

@implementation UILabel (AccordingStrngSetLableSize)

-(void)setHeightAccordingString:(NSString *)text Rect:(CGRect)rect
{
    self.text = text;
    self.numberOfLines = 0;
    CGSize textSize = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(rect.size.width, DeviceHeight) lineBreakMode:NSLineBreakByTruncatingTail];
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width,textSize.height);
}
-(void)setWidthAccordingString:(NSString *)text Rect:(CGRect)rect
{
    self.text = text;
    self.numberOfLines = 1;
    CGSize textSize = [text sizeWithFont:self.font];
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, textSize.width, rect.size.height);
    
}
-(CGSize)AccordingText:(NSString *)text
{
    self.text = text;
    self.numberOfLines = 1;
    NSLog(@"self.font = %@",self.font);
    CGSize textSize = [text sizeWithFont:self.font];
    return textSize;
}
-(void)setheightNumberLine:(NSString *)text Rect:(CGRect)rect
{
    self.text = text;
    self.numberOfLines = 2;
    CGSize textSize = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(rect.size.width, 40) lineBreakMode:NSLineBreakByTruncatingTail];
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width,textSize.height);
}
@end
