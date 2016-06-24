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

- (BOOL)isLogin
{
    return (self.identifyName && ![self.identifyName isEqualToString:@""]);
}
@end
