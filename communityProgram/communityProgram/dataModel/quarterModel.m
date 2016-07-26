//
//  quarterModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "quarterModel.h"

@implementation quarterModel


- (instancetype)initWithJsonData:(NSDictionary *)json
{
    self = [super initWithJsonData:json];
    if(self)
    {
        self.quarterId      = [json objectForKey:@"id"];
        self.quarterName    = [json objectForKey:@"quarterName"];
        self.createTime     = [CommonUtils getDateByString:[json objectForKey:@"createTime"] stringFormat:@"yyyy-MM-dd HH:mm:ss"];
        self.lat            = [json objectForKey:@"lat"];
        self.lng            = [json objectForKey:@"lng"];
        self.quarterAddress = [json objectForKey:@"quarterAddress"];
        self.quarterIcon    = [json objectForKey:@"quarterIcon"];
        self.remark         = [json objectForKey:@"remark"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.quarterId forKey:@"quarterId"];
    [aCoder encodeObject:self.quarterName forKey:@"quarterName"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.lat forKey:@"lat"];
    [aCoder encodeObject:self.lng forKey:@"lng"];
    [aCoder encodeObject:self.quarterAddress forKey:@"quarterAddress"];
    [aCoder encodeObject:self.quarterIcon forKey:@"quarterIcon"];
    [aCoder encodeObject:self.remark forKey:@"remark"];
    
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.quarterId      = [aDecoder decodeObjectForKey:@"quarterId"]?[aDecoder decodeObjectForKey:@"quarterId"]:@"";
        self.quarterName    = [aDecoder decodeObjectForKey:@"quarterName"];
        self.createTime     = [aDecoder decodeObjectForKey:@"createTime"];
        self.lat            = [aDecoder decodeObjectForKey:@"lat"];
        self.lng            = [aDecoder decodeObjectForKey:@"lng"];
        self.quarterAddress = [aDecoder decodeObjectForKey:@"quarterAddress"];
        self.quarterIcon    = [aDecoder decodeObjectForKey:@"quarterIcon"];
        self.remark         = [aDecoder decodeObjectForKey:@"remark"];
    }
    
    return self;
}

@end
