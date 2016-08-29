//
//  integralViewModel.m
//  communityProgram
//
//  Created by 陈剑 on 16/7/25.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "integralViewModel.h"
#import "NetworkEngine.h"
#import "IntegralRecordModel.h"

@implementation integralViewModel


+ (void)getIntegralRecordHisByUser:(UserObject *)user pageIndex:(NSUInteger)index pageSize:(NSUInteger)size SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure
{
    [NetworkEngine postRequestWithUrl:AppService
                          paramsArray:@[user.identifyName,[NSNumber numberWithUnsignedInteger:index],[NSNumber numberWithUnsignedInteger:size]]
                             WithPath:getIntegralRecordHis
                         successBlock:^(id successJsonData)
    {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in successJsonData)
        {
            IntegralRecordModel *model = [[IntegralRecordModel alloc] initWithJsonData:dic];
            [arr addObject:model];
        }
        success(arr);
    } errorBlock:^(int code, NSString *errorJsonData) {
        failure(code,errorJsonData);
    }];
}

@end
