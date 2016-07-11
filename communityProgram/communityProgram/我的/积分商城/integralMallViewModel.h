//
//  integralMallViewModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/7/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface integralMallViewModel : NSObject


+ (void)getIntegralProductTypeByCode:(NSString *)code SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure;

+ (void)getIntegralProductsByCode:(NSString *)code pageIndex:(NSNumber *)pageIndex pageSize:(NSNumber *)pageSize level:(NSNumber *)level SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure;

+ (void)getIntegralProductById:(NSString *)integralProductId SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure;

@end
