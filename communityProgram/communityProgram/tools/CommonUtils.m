//
//  CommonUtils.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

+ (BOOL)savaImg:(UIImage *)img useFileName:(NSString *)filePath
{
    NSArray *tmp = [filePath componentsSeparatedByString:@"/"];
    NSString *fileName = [tmp lastObject];
    NSString *localPath = NSTemporaryDirectory();
    
    return [UIImagePNGRepresentation(img) writeToFile:[NSString stringWithFormat:@"%@/%@",localPath,fileName] atomically:YES];
}


+ (UIImage *)getImgByFilePath:(NSString *)filePath
{
    NSArray *tmp = [filePath componentsSeparatedByString:@"/"];
    NSString *fileName = [tmp lastObject];
    NSString *localPath = NSTemporaryDirectory();
    NSFileManager *manage = [NSFileManager defaultManager];
    if([manage fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",localPath,fileName]])
    {
        return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",localPath,fileName]];
    }
    else
    {
        return nil;
    }
    
    }

@end
