//
//  attentionViewModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"

@interface attentionViewModel : NSObject

+ (void)getAttentionUsersByUser:(UserObject *)my SuccessBlock:(void (^)(NSArray *usersArr))success FailureBlock:(void_FailureBlock)failure;
+ (void)getUsersAttentionMy:(UserObject *)my SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure;
+ (void)attentionUser:(UserObject *)user ofMy:(UserObject *)my SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;
+ (void)removeAttentionUser:(UserObject *)user fromMy:(UserObject *)my SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;
+ (void)isUser:(UserObject *)user attentionMe:(UserObject *)me SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;
@end
