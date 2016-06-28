//
//  addressManagerViewModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "addressModel.h"
#import "NetworkEngine.h"

@interface addressManagerViewModel : NSObject

+ (void)getUserReceiveAddressesByUserId:(NSString *)identityName SuccessBlock:(void (^)(NSArray *address))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure;

+ (void)delUserReceiveAddress:(addressModel *)model SuccessBlock:(void (^)(BOOL result))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure;

+ (void)addUserReceiveAddress:(addressModel *)model SuccessBlock:(void (^)(NSArray *address))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure;

+ (void)modifyUserReveiveAddress:(addressModel *)model SuccessBlock:(void (^)(NSArray *address))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure;

+ (void)setUserDefaultAddress:(addressModel *)model SuccessBlock:(void (^)(BOOL result))success FailureBlock:(void (^)(int errCode, NSString *errMsg))failure;
@end
