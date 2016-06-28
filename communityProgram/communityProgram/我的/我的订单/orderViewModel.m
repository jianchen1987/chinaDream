//
//  orderViewModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "orderViewModel.h"
#import "NetworkEngine.h"

@implementation orderViewModel

+ (void)getOrdersByUser:(UserObject *)user SuccessBlock:(void (^)(NSArray *orders))success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[user.identifyName]
                             WithPath:GetOrdersByUserId
                         successBlock:^(id successJsonData)
    {
        success(successJsonData);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code,errorJsonData);
    }];
}

+ (void)deleteOrder:(orderModel *)order ByUser:(UserObject *)user SuccessBlick:(void (^)(BOOL result))success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[user.identifyName,order.orderCode]
                             WithPath:DeleteOrder
                         successBlock:^(id successJsonData)
    {
        success(YES);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code,errorJsonData);
    }];
    
}

+ (void)getOrderItemByOrder:(orderModel *)order SuccessBlock:(void (^)(NSArray *orderItems))success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[order.orderCode]
                             WithPath:GetOrderItemByOrderId
                         successBlock:^(id successJsonData)
    {
        success(successJsonData);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code,errorJsonData);
    }];
}

@end
