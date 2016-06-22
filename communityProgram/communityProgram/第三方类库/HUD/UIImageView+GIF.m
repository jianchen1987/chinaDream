//
//  UIImageView+GIF.m
//  PayEasy
//
//  Created by 马 博文 on 15/12/8.
//  Copyright © 2015年 Bestpay. All rights reserved.
//

#import "UIImageView+GIF.h"
#import <ImageIO/ImageIO.h>
@implementation UIImageView(GIF)

+ (UIImageView *)imageViewWithGIFFile:(NSString *)file
{
    UIImageView *imageView = [[UIImageView alloc]init];
    
    // 加载gif文件数据
    NSData *gifData = [NSData dataWithContentsOfFile:file];
    
    // GIF动画图片数组
    NSMutableArray *frames = nil;

    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    // 时长
    CGFloat animationTime = 0.f;
    
    if (src) {
        // 帧数
        size_t count = CGImageSourceGetCount(src);
        // 图片数组
        frames = [NSMutableArray arrayWithCapacity:count];
        NSDictionary *properties;
        CGFloat gifWidth = 0.f;
        CGFloat gifHeight = 0.f;
        for (size_t i = 0; i < count; i++) {
            // 指定帧图像
            CGImageRef image = CGImageSourceCreateImageAtIndex(src, i, NULL);
            // GIF动画时长
            properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(src, i, NULL);
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFDelayTime];
            // 宽高
            NSNumber *width = [properties objectForKey:(NSString*)kCGImagePropertyPixelWidth];
            gifWidth = [width floatValue];
            NSNumber *height = [properties objectForKey:(NSString*)kCGImagePropertyPixelHeight];
            gifHeight = [height floatValue];
            animationTime += [delayTime floatValue];
            
            if (image) {
                [frames addObject:[UIImage imageWithCGImage:image]];
                CGImageRelease(image);
            }
        }
        imageView.bounds = CGRectMake(0, 0, gifWidth, gifHeight);
        CFRelease(src);
    }
    
    [imageView setImage:[frames objectAtIndex:0]];
    [imageView setAnimationImages:frames];
    [imageView setAnimationDuration:animationTime];
    [imageView startAnimating];
    
    return imageView;
}

@end
