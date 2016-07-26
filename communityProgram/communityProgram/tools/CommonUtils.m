//
//  CommonUtils.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CommonUtils.h"

@implementation CommonUtils

+ (NSDate *)getDateByString:(NSString *)dateStr stringFormat:(NSString *)formatStr
{
    if(!dateStr)
    {
        return nil;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:formatStr];
    NSDate *formatDate = [format dateFromString:dateStr];
    return formatDate;
}

+ (NSString *)getStrByDate:(NSDate *)date stringFormat:(NSString *)formatStr
{
    NSDateFormatter *format = [[NSDateFormatter  alloc] init];
    [format setDateFormat:formatStr];
    
    return [format stringFromDate:date];
}

@end
