//
//  orderItemModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "orderItemModel.h"


@implementation orderItemModel

- (instancetype)initWithJsonData:(NSDictionary *)json
{
    self = [super initWithJsonData:json];
    if(self)
    {
        self.orderId        = nil;
        self.orderItemId  = [json objectForKey:@"id"];
        self.product      = [[ProductModel alloc] initWithJsonData:[json objectForKey:@"product"]];
        self.orderItemNum = [NSNumber numberWithInt:[[json objectForKey:@"orderItemNum"] intValue]];
        self.sendPrice    = [NSNumber numberWithDouble:[[json objectForKey:@"sendPrice"] doubleValue]];
        self.createTime   = [CommonUtils getDateByString:[json objectForKey:@"createTime"] stringFormat:@"yyyy-MM-dd hh24:mm:ss"];
    }
    
    return self;
}

@end
