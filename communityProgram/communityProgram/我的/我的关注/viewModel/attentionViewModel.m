//
//  attentionViewModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "attentionViewModel.h"
#import "NetworkEngine.h"

@implementation attentionViewModel

+ (void)getAttentionUsersByUser:(UserObject *)my
                   SuccessBlock:(void (^)(NSArray *usersArr))success
                   FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[my.identifyName]
                             WithPath:GetNoticeUser successBlock:^(id successJsonData)
    {
        success(successJsonData);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code, errorJsonData);
    }];
}
+ (void)getUsersAttentionMy:(UserObject *)my
               SuccessBlock:(void_SuccessBlock_Arrary)success
               FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[my.identifyName]
                             WithPath:GetNoticeMy
                         successBlock:^(id successJsonData)
     {
         success(successJsonData);
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}
+ (void)attentionUser:(UserObject *)user ofMy:(UserObject *)my
         SuccessBlock:(void_SuccessBlock_BOOL)success
         FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[my.identifyName,user.identifyName]
                             WithPath:JoinNoticeMy
                         successBlock:^(id successJsonData)
     {
         success(successJsonData);
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}
+ (void)removeAttentionUser:(UserObject *)user fromMy:(UserObject *)my
               SuccessBlock:(void_SuccessBlock_BOOL)success
               FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[my.identifyName,user.identifyName]
                             WithPath:RemoveNoticeMy successBlock:^(id successJsonData)
     {
         success(successJsonData);
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}
+ (void)isUser:(UserObject *)user attentionMe:(UserObject *)me
  SuccessBlock:(void_SuccessBlock_BOOL)success
  FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[me.identifyName,user.identifyName]
                             WithPath:NoticeByUser
                         successBlock:^(id successJsonData)
     {
         success(successJsonData);
     }
                           errorBlock:^(int code, NSString *errorJsonData)
     {
         failure(code, errorJsonData);
     }];
}

@end
