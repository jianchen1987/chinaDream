//
//  CrowdFundingRequest.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/1.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CrowdFundingRequest.h"
#import "NetworkEngine.h"
#import "AllChipModel.h"
#import "AllChipLogoModel.h"
#import <MJExtension.h>
#import "UserObject.h"
@implementation CrowdFundingRequest
+(void)getChipByPagerquest:(NSInteger)page successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock
{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[Number(page),@15] WithPath:getChipByPage successBlock:^(NSArray* successJsonData) {
        NSMutableArray * array=[NSMutableArray array];
        for (int i=0; i<successJsonData.count; i++) {
            NSDictionary * dic =successJsonData[i];
            AllChipModel * model= [AllChipModel mj_objectWithKeyValues:dic];
            [array addObject:model];
        }
        successBlock(array);

    } errorBlock:^(int code, NSString *errorJsonData) {
        errorBlock(code,errorJsonData);
    }];
}

+(void)getChipByIdRquest:(AllChipModel*)idModel successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[idModel.id] WithPath:getChipById successBlock:^(NSDictionary* successJsonData) {
        NSLog(@"%@",successJsonData);
        AllChipModel * model=[AllChipModel mj_objectWithKeyValues:successJsonData];
        successBlock(model);
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        errorBlock(code,errorJsonData);
    }];
}

+(void)getAllChipBannerRquestSuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock{
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[@"allchip"] WithPath:@"getAllChipLogo" successBlock:^(NSArray* successJsonData) {
        NSLog(@"%@",successJsonData);
        NSMutableArray * array=[NSMutableArray array];

        for (int i=0; i<successJsonData.count; i++) {
            AllChipLogoModel * model=[AllChipLogoModel mj_objectWithKeyValues:successJsonData[i]];

            [array addObject:model];
        }

        successBlock(array);
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        errorBlock(code,errorJsonData);
    }];
}

+(void)getAllChipHistoryRquestSuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock{
    UserObject * ure=[UserObject shareUser];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[ure.identifyName] WithPath:getAllChipHistory successBlock:^(id successJsonData)
    {
        NSLog(@"%@",successJsonData);
        NSMutableArray * array=[NSMutableArray array];
        NSArray * arr=successJsonData;
        for (int i=0; i<arr.count; i++)
        {
          
            AllChipModel * model=[AllChipModel mj_objectWithKeyValues:successJsonData[i]];
            NSLog(@"%@",model.id);
            [array addObject:model];
        }
        successBlock(array);
    } errorBlock:^(int code, NSString *errorJsonData) {
        errorBlock(code,errorJsonData);
    }];
    
}
+(void)getAllChipRecordRquestSuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock{
    UserObject * ure=[UserObject shareUser];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[ure.identifyName] WithPath:getAllChipRecord successBlock:^(NSMutableArray* successJsonData)
     {
         NSMutableArray * array=[NSMutableArray array];
         for (int i=0; i<successJsonData.count; i++)
         {
             
             AllChipModel * model=[AllChipModel mj_objectWithKeyValues:successJsonData[i]];
             NSLog(@"%@",model.id);
             [array addObject:model];
         }
         successBlock(array);
     } errorBlock:^(int code, NSString *errorJsonData) {
         errorBlock(code,errorJsonData);
     }];
    
    
}
















@end
