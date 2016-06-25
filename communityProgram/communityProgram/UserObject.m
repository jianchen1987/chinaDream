//
//  UserObject.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/14.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "UserObject.h"

static UserObject *USER;

@implementation UserObject

+ (UserObject*)shareUser
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        USER = [[UserObject alloc] init];
        USER.identifyName = @"";
    });
    return USER;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        self = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:[[[UIDevice currentDevice] identifierForVendor] UUIDString]]];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.identifyName forKey:@"identifyName"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.headIcon forKey:@"headIcon"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.room forKey:@"room"];
    [aCoder encodeObject:self.myExtraIntegral forKey:@"myExtraIntegral"];
    [aCoder encodeObject:self.birth forKey:@"birth"];
    [aCoder encodeObject:self.hobbile forKey:@"hobbile"];
    [aCoder encodeObject:self.homeTown forKey:@"homeTown"];
    [aCoder encodeObject:self.identityIntegral forKey:@"identityIntegral"];
    [aCoder encodeObject:self.master forKey:@"master"];
    [aCoder encodeObject:self.integral forKey:@"integral"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.identifyName     = [aDecoder decodeObjectForKey:@"identifyName"];
        self.nickName         = [aDecoder decodeObjectForKey:@"nickName"];
        self.phone            = [aDecoder decodeObjectForKey:@"phone"];
        self.gender           = [aDecoder decodeObjectForKey:@"gender"];
        self.headIcon         = [aDecoder decodeObjectForKey:@"headIcon"];
        self.address          = [aDecoder decodeObjectForKey:@"address"];
        self.room             = [aDecoder decodeObjectForKey:@"room"];
        self.myExtraIntegral  = [aDecoder decodeObjectForKey:@"myExtraIntegral"];
        self.birth            = [aDecoder decodeObjectForKey:@"birth"];
        self.hobbile          = [aDecoder decodeObjectForKey:@"hobbile"];
        self.homeTown         = [aDecoder decodeObjectForKey:@"homeTown"];
        self.identityIntegral = [aDecoder decodeObjectForKey:@"identityIntegral"];
        self.master           = [aDecoder decodeObjectForKey:@"master"];
        self.integral         = [aDecoder decodeObjectForKey:@"integral"];
    }
    
    return self;
}


- (BOOL)isLogin
{
    return (self.identifyName && ![self.identifyName isEqualToString:@""]);
}

- (void)updateInfo:(NSDictionary *)jsonData
{
    self.nickName         = [jsonData objectForKey:@"nickName"]?[jsonData objectForKey:@"nickName"]:@"";
    self.phone            = [jsonData objectForKey:@"phone"]?[jsonData objectForKey:@"phone"]:@"";
    self.gender           = [jsonData objectForKey:@"gender"]?[jsonData objectForKey:@"gender"]:@"";
    self.headIcon         = [jsonData objectForKey:@"headIcon"]?[jsonData objectForKey:@"headIcon"]:@"";
    self.address          = [jsonData objectForKey:@"address"]?[jsonData objectForKey:@"address"]:@"";
    self.room             = [jsonData objectForKey:@"room"]?[jsonData objectForKey:@"room"]:@"";
    self.myExtraIntegral  = [jsonData objectForKey:@"myExtraIntegral"]?[jsonData objectForKey:@"myExtraIntegral"]:@"";
    self.birth            = [jsonData objectForKey:@"birth"]?[jsonData objectForKey:@"birth"]:@"";
    self.hobbile          = [jsonData objectForKey:@"hobbile"]?[jsonData objectForKey:@"hobbile"]:@"";
    self.homeTown         = [jsonData objectForKey:@"homeTown"]?[jsonData objectForKey:@"homeTown"]:@"";
    self.identityIntegral = [jsonData objectForKey:@"identityIntegral"]?[jsonData objectForKey:@"identityIntegral"]:@"";
    self.master           = [jsonData objectForKey:@"master"]?[jsonData objectForKey:@"master"]:@"";
    self.integral         = [jsonData objectForKey:@"integral"]?[jsonData objectForKey:@"integral"]:@"";
    
    [self archiveToUserDefaults];
}

- (void)archiveToUserDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    [defaults synchronize];
}



@end
