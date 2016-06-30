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

@end
