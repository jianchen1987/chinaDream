//
//  ProductUnit.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/16.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ProductModel.h"
#import <MJExtension/MJExtension.h>

@implementation ProductModel

- (instancetype)initWithJsonData:(NSDictionary *)json
{
    self = [super initWithJsonData:json];
    if(self)
    {
        [self mj_setKeyValues:json];
        self.selected = YES;
    }
    
    return self;
}

@end
