//
//  collectionViewModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "collectionViewModel.h"
#import "NetworkEngine.h"
#import "ProductModel.h"

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




+ (void)getCollectionProductsByUser:(UserObject *)user TypeId:(NSUInteger)type pageIndex:(NSUInteger)page pageSize:(NSUInteger)size SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure
{
    NSString *apiName = nil;
    switch (type) {
        case 0:
            apiName = getCollProduct;
            break;
        case 1:
            apiName = getCollFreeEat;
            break;
        case 2:
            apiName = getCollAllChip;
            break;
        default:
            apiName = getCollProduct;
            break;
    }
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[user.identifyName,[NSNumber numberWithUnsignedInteger:page],[NSNumber numberWithUnsignedInteger:size]]
                             WithPath:apiName
                         successBlock:^(id successJsonData)
    {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for(NSDictionary *tmp in successJsonData)
        {
            ProductModel *model = [[ProductModel alloc] initWithJsonData:tmp];
            [result addObject:model];
        }
        success(result);
    } errorBlock:^(int code, NSString *errorJsonData) {
        failure(code,errorJsonData);
    }];
}

+ (void)removeCollectionProduct:(ProductModel *)product productType:(NSUInteger)type byUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure
{
    NSString *apiName = nil;
    switch (type) {
        case 0:
            apiName = removeCollProduct;
            break;
        case 1:
            apiName = removeCollFreeEat;
            break;
        case 2:
            apiName = removeCollAllChip;
            break;
        default:
            apiName = removeCollProduct;
            break;
    }
    
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[user.identifyName,product.id]
                             WithPath:apiName
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
