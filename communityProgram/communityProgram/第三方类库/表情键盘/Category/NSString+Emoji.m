//
//  NSString+Emoji.m
//  黑马微博
//
//  Created by MJ Lee on 14/7/12.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+Emoji.h"
#import "EmotionModel.h"
#import <UIKit/UIKit.h>
#import "EmotionViewConst.h"
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (Emoji)

+ (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (NSString *)emoji
{
    return [NSString emojiWithStringCode:self];
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    int intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

// 判断是否是 emoji表情
- (BOOL)isEmoji
{
     BOOL returnValue = NO;
         
     const unichar hs = [self characterAtIndex:0];
     // surrogate pair
     if (0xd800 <= hs && hs <= 0xdbff) {
         if (self.length > 1) {
             const unichar ls = [self characterAtIndex:1];
             const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
             if (0x1d000 <= uc && uc <= 0x1f77f) {
                 returnValue = YES;
             }
         }
     } else if (self.length > 1) {
         const unichar ls = [self characterAtIndex:1];
         if (ls == 0x20e3) {
             returnValue = YES;
         }
     } else {
         // non surrogate
         if (0x2100 <= hs && hs <= 0x27ff) {
             returnValue = YES;
         } else if (0x2B05 <= hs && hs <= 0x2b07) {
             returnValue = YES;
         } else if (0x2934 <= hs && hs <= 0x2935) {
             returnValue = YES;
         } else if (0x3297 <= hs && hs <= 0x3299) {
             returnValue = YES;
         } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
             returnValue = YES;
         }
     }
    
    return returnValue;
}



//普通文本转换成富文本
-(NSMutableAttributedString *)TextNormalEmotion:(NSString *)contentStr {
    //创建可变的属性字符串
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:contentStr];

    //通过正则表达式来匹配字符
    NSString *regex = @"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";
    NSError *error = nil;
    NSRegularExpression *re = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    
    if (!re) {
        NSLog(@"%@",[error localizedDescription]);
        return attributeString;
    }
    NSArray *resultArray = [re matchesInString:contentStr options:0 range:NSMakeRange(0, contentStr.length)];
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithCapacity:resultArray.count];
    
    //根据匹配范围来用图片进行相应的替换
    for(NSTextCheckingResult *match in resultArray) {
        
        //获取数组元素中得到range
        NSRange range = [match range];
        
        //获取原字符串中对应的值
        NSString *subStr = [contentStr substringWithRange:range];
        
        //新建文字附件来存放我们的图片,iOS7才新加的对象
        NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
        
        //给附件添加图片
        textAttachment.image= [self textNormalImage:subStr];
        
        //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
//        textAttachment.bounds=CGRectMake(0, -8,textAttachment.image.size.width, textAttachment.image.size.height);
        
        textAttachment.bounds = CGRectMake(0, -3.265031, 20, 20);
        //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
//        NSMutableAttributedString *imageStr = [NSMutableAttributedString attributedStringWithAttachment:textAttachment];
//        [imageStr addAttributes:@{NSFontAttributeName:PublishFont} range:NSMakeRange(0, 1)];
        
        //把图片和图片对应的位置存入字典中
        NSMutableDictionary *imageDic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        [imageDic setObject:imageStr forKey:@"image"];
        
        [imageDic setObject:[NSValue valueWithRange:range] forKey:@"range"];
        //把字典存入数组中
        [imageArray addObject:imageDic];
        
    }
    
    //4、从后往前替换，否则会引起位置问题
    for(int i = (int)imageArray.count-1; i >=0; i--) {
        
        NSRange range;
        [imageArray[i][@"range"] getValue:&range];
        //进行替换
        [attributeString replaceCharactersInRange:range withAttributedString:imageArray[i][@"image"]];

    }
    
    return attributeString;
}

- (UIImage *)textNormalImage:(NSString *)pngStr {
    UIImage *image = [self NormalImage:pngStr];
    if (!image) {
        image = [self xlhImage:pngStr];
    }
    
    return image;
    
}

- (UIImage *)NormalImage:(NSString *)name {
    NSArray *normalArr = [EmotionModel emotions_default];
    for (EmotionModel *model in normalArr) {
        if([model.chs isEqual:name]){
            NSString *folederName = EmotionDefaultFolder;
            
            if([self hasPrefix:EmotionLxhFolder]) folederName = EmotionLxhFolder;
            
            NSString *path = [NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,folederName,model.png];
            return [UIImage imageNamed:path];
        }

    }
    return nil;
}
- (UIImage *)xlhImage:(NSString *)name {
    NSArray *lxhArry = [EmotionModel emotions_lxh];
    
    for (EmotionModel *modle in lxhArry) {
        if([modle.chs isEqual:name]){
            NSString *folederName = EmotionDefaultFolder;
            
            if([modle.png hasPrefix:EmotionLxhFolder]) folederName = EmotionLxhFolder;
            
            NSString *path = [NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,folederName,modle.png];
            return [UIImage imageNamed:path];
        }
    }

    return nil;
}



@end
