//
//  IntegralRecordModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/7/25.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "IntegralRecordModel.h"

@implementation IntegralRecordModel

- (nullable instancetype)initWithJsonData:(NSDictionary  * _Nonnull)json
{
    self = [super initWithJsonData:json];
    if(self)
    {
        self.irID = [json objectForKey:@"id"];
        self.recordName = [json objectForKey:@"recordName"];
        self.integralNum = [NSNumber numberWithInt:[[json objectForKey:@"integralNum"] intValue]];
        self.integralType = [NSNumber numberWithInt:[[json objectForKey:@"integralType"] intValue]];
        self.createTime = [CommonUtils getDateByString:[json objectForKey:@"createTime"] stringFormat:@"yyyy-MM-dd HH:mm:ss"];
        
    }
    
    return self;
}

@end
