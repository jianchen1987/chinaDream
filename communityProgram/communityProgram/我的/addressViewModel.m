//
//  addressManagerViewModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "addressViewModel.h"

@implementation addressManagerViewModel

+ (void)getUserReceiveAddressesByUserId:(NSString *)identityName SuccessBlock:(void (^)(NSArray *address))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[identityName]
                             WithPath:GetAddressAll
                         successBlock:^(id successJsonData)
    {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for (NSDictionary *temp in successJsonData)
        {
            addressModel *model = [[addressModel alloc] initWithJsonData:temp];
            [result addObject:model];
        }
        
        success(result);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code, errorJsonData);
    }];
}

+ (void)addUserReceiveAddress:(addressModel *)model SuccessBlock:(void (^)(NSArray *))success FailureBlock:(void (^)(int, NSString *))failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[model.identityName,
                                        model.phone,
                                        model.sendName,
                                        model.levelRoom,
                                        model.quarterName]
                             WithPath:SaveAddress
                         successBlock:^(id successJsonData)
    {
        success(successJsonData);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code, errorJsonData);
    }];
}

+ (void)modifyUserReveiveAddress:(addressModel *)model SuccessBlock:(void (^)(NSArray *address))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[model.identityName,
                                                               model.aid,
                                                               model.phone,
                                                               model.sendName,
                                                               model.levelRoom,
                                                               model.quarterName]
                             WithPath:ModifyAddress
                         successBlock:^(id successJsonData)
    {
        success(successJsonData);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code,errorJsonData);
    }];
}

+ (void)delUserReceiveAddress:(addressModel *)model SuccessBlock:(void (^)(BOOL result))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[model.aid]
                             WithPath:DeleteAddress
                         successBlock:^(id successJsonData)
    {
        success([successJsonData boolValue]);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code,errorJsonData);
    }];
}

+ (void)setUserDefaultAddress:(addressModel *)model SuccessBlock:(void (^)(BOOL result))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[model.identityName,
                                                               model.aid]
                             WithPath:SetDefaultAddress
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
