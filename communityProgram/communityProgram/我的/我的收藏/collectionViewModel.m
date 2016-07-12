//
//  collectionViewModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "collectionViewModel.h"
#import "NetworkEngine.h"

@implementation collectionViewModel

+ (void)saveProductCollection:(ProductModel *)product forUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[user.identifyName,product.id] WithPath:SaveProductCollection
                         successBlock:^(id successJsonData)
    {
        success([successJsonData boolValue]);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code,errorJsonData);
    }];
}

@end
