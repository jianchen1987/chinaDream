//
//  UILabel+AccordingStrngSetLableSize.h
//  Categrory
//
//  Created by 峰馨雪月 on 14-5-3.
//  Copyright (c) 2014年 高国峰. All rights reserved.
//

/*   
 
    根据传进来的字符串长度自动计算lable的长度和高度
 
 */

#import <UIKit/UIKit.h>

@interface UILabel (AccordingStrngSetLableSize)


-(void)setHeightAccordingString:(NSString *)text Rect:(CGRect)rect;
-(void)setWidthAccordingString:(NSString *)text Rect:(CGRect)rect;
-(CGSize)AccordingText:(NSString *)text;
-(void)setheightNumberLine:(NSString *)text Rect:(CGRect)rect;

@end
