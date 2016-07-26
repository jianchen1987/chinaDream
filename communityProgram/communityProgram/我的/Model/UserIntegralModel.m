//
//  UserIntegralModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/7/25.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "UserIntegralModel.h"

@implementation UserIntegralModel

- (instancetype)initWithJsonData:(NSDictionary *)json
{
    self = [super initWithJsonData:json];
    if(self)
    {
        self.UIID        = [json objectForKey:@"id"];
        self.integralNum = [NSNumber numberWithInteger:[[json objectForKey:@"integralNum"] integerValue]];
        self.createTime  = [CommonUtils getDateByString:[json objectForKey:@"createTime"] stringFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.modifyTime  = [CommonUtils getDateByString:[json objectForKey:@"modifyTime"] stringFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.UIID forKey:@"UIID"];
    [aCoder encodeObject:self.integralNum forKey:@"integraNum"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.modifyTime forKey:@"modifyTime"];

}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.UIID        = [aDecoder decodeObjectForKey:@"UIID"]?[aDecoder decodeObjectForKey:@"UIID"]:@"";
        self.integralNum = [NSNumber numberWithInteger:[[aDecoder decodeObjectForKey:@"integraNum"] integerValue]];
        self.createTime  = [aDecoder decodeObjectForKey:@"createTime"];
        self.modifyTime  = [aDecoder decodeObjectForKey:@"modifyTime"];
    }
    
    return self;
}

@end
