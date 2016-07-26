//
//  NearUserViewModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/7/25.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "NearUserViewModel.h"
#import "NetworkEngine.h"

@implementation NearUserViewModel

+ (void)getNearNeighborByUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[user.identifyName,user.quarter.quarterId]
                             WithPath:getNearNeighbour
                         successBlock:^(id successJsonData)
    {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in successJsonData)
        {
            UserObject *neighbour = [[UserObject alloc] initWithJsonData:dic];
            [arr addObject:neighbour];
        }
        
        success(arr);
    }
                           errorBlock:^(int code, NSString *errorJsonData)
    {
        failure(code,errorJsonData);
    }];
}

@end
