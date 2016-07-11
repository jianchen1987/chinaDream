//
//  integralMallViewModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/7/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "integralMallViewModel.h"
#import "NetworkEngine.h"

@implementation integralMallViewModel

+ (void)getIntegralProductTypeByCode:(NSString *)code SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[code]
                             WithPath:GetIntegralProductType
                         successBlock:^(id successJsonData)
    {
        NSLog(@"123");
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code, errorJsonData);
    }];
}

+ (void)getIntegralProductsByCode:(NSString *)code pageIndex:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize level:(NSNumber *)level SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[code,pageIndex,pageSize,level]
                             WithPath:GetIntegralProducts
                         successBlock:^(id successJsonData)
     {
         NSLog(@"123");
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}

+ (void)getIntegralProductById:(NSString *)integralProductId SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[integralProductId]
                             WithPath:GetIntegralProductById
                         successBlock:^(id successJsonData)
     {
         NSLog(@"123");
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}

@end
