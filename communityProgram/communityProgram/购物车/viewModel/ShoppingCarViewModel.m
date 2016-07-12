//
//  ShoppingCarManager.m
//  communityProgram
//
//  Created by 陈剑 on 16/7/7.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ShoppingCarViewModel.h"
#import "NetworkEngine.h"
#import "ShoppingProductModel.h"



@implementation ShoppingCarViewModel


+ (void)addProduct:(ProductModel *)product
               Num:(NSUInteger)num
           forUser:(UserObject *)user
      SuccessBlock:(void_SuccessBlock_BOOL)success
      FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[user.identifyName,[NSNumber numberWithUnsignedInteger:num],product.id] WithPath:AddShoppingCar
                         successBlock:^(id successJsonData)
    {
        success([[successJsonData objectForKey:@"result"] boolValue]);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code, errorJsonData);
    }];
}

+ (void)getShoppingCarListByUser:(UserObject *)user
                    SuccessBlock:(void_SuccessBlock_Arrary)success
                    FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[user.identifyName] WithPath:GetShoppingCarList
                         successBlock:^(id successJsonData)
     {
         NSMutableArray *result = [[NSMutableArray alloc] init];
         for(NSDictionary *dic in successJsonData)
         {
             ProductModel *model = [[ProductModel alloc] initWithJsonData:dic];
             [result addObject:model];
         }
         success(result);
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}

+ (void)removeProduct:(ProductModel *)product
              forUser:(UserObject *)user
         SuccessBlock:(void_SuccessBlock_BOOL)success
         FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[user.identifyName,product.id] WithPath:RemoveShoppingCar
                         successBlock:^(id successJsonData)
     {
         success([successJsonData boolValue]);
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}

+ (void)modifyNum:(NSUInteger)num
        ofProduct:(ProductModel *)product
          forUser:(UserObject *)user
     SuccessBlock:(void_SuccessBlock_BOOL)success
     FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[user.identifyName,[NSNumber numberWithUnsignedInteger:num],product.id] WithPath:ModifyShoppingCar
                         successBlock:^(id successJsonData)
     {
         success([successJsonData boolValue]);
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}


@end








