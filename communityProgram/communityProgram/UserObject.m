//
//  UserObject.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/14.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject
+(UserObject*)shareUser{
    static UserObject * user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user=[[UserObject alloc]init];
        user.id=@"";
    });
    return user;
}
@end
