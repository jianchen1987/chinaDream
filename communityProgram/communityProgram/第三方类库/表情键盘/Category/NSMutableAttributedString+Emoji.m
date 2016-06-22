//
//  NSMutableAttributedString+Emoji.m
//  communityProgram
//
//  Created by xiaogao on 16/3/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "NSMutableAttributedString+Emoji.h"

@implementation NSMutableAttributedString (Emoji)
//普通文本转换成富文本
+(NSMutableAttributedString *)TextNormalEmotion:(NSString *)contentStr {
    NSLog(@"contentStr = %@",contentStr);
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
        textAttachment.bounds=CGRectMake(0, -8,textAttachment.image.size.width, textAttachment.image.size.height);
        
        //把附件转换成可变字符串，用于替换掉源字符串中的表情文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
        
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

+ (UIImage *)textNormalImage:(NSString *)pngStr {
    UIImage *image = [self NormalImage:pngStr];
    if (!image) {
        image = [self xlhImage:pngStr];
    }
    
    return image;
    
}

+ (UIImage *)NormalImage:(NSString *)name {
    NSArray *normalArr = [EmotionModel emotions_default];
    
    for (EmotionModel *model in normalArr) {
        if([model.chs isEqual:name]){
            NSString *folederName = EmotionDefaultFolder;
                        
            NSString *path = [NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,folederName,model.png];
            return [UIImage imageNamed:path];
        }
        
    }
    return nil;
}
+ (UIImage *)xlhImage:(NSString *)name {
    NSArray *lxhArry = [EmotionModel emotions_lxh];
    
    for (EmotionModel *modle in lxhArry) {
        if([modle.chs isEqual:name]){
            NSString *folederName = EmotionDefaultFolder;
            
            if([modle.png hasPrefix:EmotionLxhFolder]) folederName = EmotionLxhFolder;
            
            NSString *path = [NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,folederName,modle.png];
            return [UIImage imageNamed:path];
        }
    }
    
    
    //    for (int i=0; i<lxhArry.count; i++) {
    //        NSDictionary *dict = lxhArry[i];
    //        if([dict[@"chs"] isEqual:name]){
    //            NSString *folederName = EmotionDefaultFolder;
    //
    //            if([dict[@"png"] hasPrefix:EmotionLxhFolder]) folederName = EmotionLxhFolder;
    //
    //            NSString *path = [NSString stringWithFormat:@"%@/%@/%@",EmotionBundelName,folederName,dict[@"png"]];
    //            return [UIImage imageNamed:path];
    //        }
    //    }
    return nil;
}


@end
