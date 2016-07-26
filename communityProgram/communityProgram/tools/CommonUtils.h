//
//  CommonUtils.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

+ (NSDate *)getDateByString:(NSString *)dateStr stringFormat:(NSString *)formatStr;
+ (NSString *)getStrByDate:(NSDate *)date stringFormat:(NSString *)formatStr;

@end
