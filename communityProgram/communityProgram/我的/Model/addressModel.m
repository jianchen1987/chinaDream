//
//  addressModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "addressModel.h"

@implementation addressModel

- (nullable instancetype)initWithJsonData:(NSDictionary  * _Nullable )json
{
    self = [super init];
    if(self)
    {
        self.aid         = [json objectForKey:@"id"];
        self.quarterName = [json objectForKey:@"quarterName"];
        self.levelRoom   = [json objectForKey:@"levelRoom"];
        self.phone       = [json objectForKey:@"phone"];
        self.sendName    = [json objectForKey:@"sendName"];
        self.isDefault   = [[json objectForKey:@"defaultValue"] boolValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.aid forKey:@"aid"];
    [aCoder encodeObject:self.quarterName forKey:@"quarterName"];
    [aCoder encodeObject:self.levelRoom forKey:@"levelRoom"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.sendName forKey:@"sendName"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isDefault] forKey:@"isDefault"];

    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.aid         = [aDecoder decodeObjectForKey:@"aid"]?[aDecoder decodeObjectForKey:@"aid"]:@"";
        self.quarterName = [aDecoder decodeObjectForKey:@"quarterName"];
        self.phone       = [aDecoder decodeObjectForKey:@"phone"];
        self.levelRoom   = [aDecoder decodeObjectForKey:@"levelRoom"];
        self.sendName    = [aDecoder decodeObjectForKey:@"sendName"];
        self.isDefault   = [[aDecoder decodeObjectForKey:@"isDefault"] boolValue];
    }
    
    return self;
}

@end
