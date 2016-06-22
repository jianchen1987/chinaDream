//
//  MD5.h
//  BestpayEERefactor
//
//  Created by 孙睿 on 14-8-8.
//  Copyright (c) 2014年 孙睿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5 : NSObject
//正常
+(NSString *) md5: (NSString *) text;
//字母全小写
+(NSString *) md5LowercaseString: (NSString *) text;
//字母全大写
+(NSString *) md5UppercaseString: (NSString *) text;
//文件MD5
+ (NSString *)getFileMD5WithPath:(NSString *)path;
@end
