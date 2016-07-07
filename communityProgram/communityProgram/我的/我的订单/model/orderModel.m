//
//  orderModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "orderModel.h"
#import "CommonUtils.h"

@implementation orderModel

- (nullable instancetype)initWithJsonData:(NSDictionary  * _Nonnull)json
{
    self = [super init];
    if(self)
    {
        self.orderId              = [json objectForKey:@"id"];
        self.orderCode            = [json objectForKey:@"orderCode"];
        self.orderTotalNum        = [NSNumber numberWithInt:[json objectForKey:@"orderTotalNum"]?[[json objectForKey:@"orderTotalNum"] intValue]:0];
        self.orderBarCode         = [json objectForKey:@"orderBarCode"];
        self.sendDate             = [CommonUtils getDateByString:[json objectForKey:@"sendDate"] stringFormat:@"yyyy-MM-dd hh24:mm:ss"];
        self.isPaySignDate        = [CommonUtils getDateByString:[json objectForKey:@"isPaySignDate"] stringFormat:@"yyyy-MM-dd hh24:mm:ss"];
        self.isPay                = [json objectForKey:@"isPay"];
        self.orderStatus          = [[json objectForKey:@"orderStatus"] unsignedIntegerValue];
        self.amount               = [NSNumber numberWithDouble:[json objectForKey:@"amount"]?[[json objectForKey:@"amount"] doubleValue]:0.0];
        self.totalSendMoney       = [NSNumber numberWithDouble:[json objectForKey:@"totalSendMoney"]?[[json objectForKey:@"orderStatus"] doubleValue]:0.0];
        self.message              = [json objectForKey:@"message"];
        
        self.user  = [[UserObject alloc] initWithJsonData:[json objectForKey:@"user"]];

        NSArray *orderItemArr     = [json objectForKey:@"items"];
        self.orderItems           = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in orderItemArr)
        {
        orderItemModel *orderItem = [[orderItemModel alloc] initWithJsonData:dic];
            [self.orderItems addObject:orderItem];
        }

        self.address              = [[addressModel alloc] initWithJsonData:[json objectForKey:@"address"]];

        self.coupon               = nil;
        
        self.createTime           = [CommonUtils getDateByString:[json objectForKey:@"createTime"] stringFormat:@"yyyy-MM-dd hh24:mm:ss"];
        
    }
    
    return self;
}

@end
