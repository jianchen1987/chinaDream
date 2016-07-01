//
//  CrowdFundingRequest.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/1.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllChipModel.h"
@interface CrowdFundingRequest : NSObject
/**
 *  分页获取所有众筹
 *
 *  @param page     
 */
+(void)getChipByPagerquest:(NSInteger)page successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;
/**
 *  根据众筹id来获取众筹实体
 */
+(void)getChipByIdRquest:(AllChipModel*)idModel successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;
/**
 *  众筹广告图
 */
+(void)getAllChipBannerRquestSuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;
/**
 *  获取众筹历史-是指已经结束的所有众筹
 *
 */
+(void)getAllChipHistoryRquestSuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;
/**
 *  获取我的众筹记录 - 就是我参加过的众筹
 */
+(void)getAllChipRecordRquestSuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;


@end
