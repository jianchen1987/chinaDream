//
//  orderViewModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"
#import "orderModel.h"
#import "orderItemModel.h"



@interface orderViewModel : NSObject

+ (void)getOrdersByUser:(UserObject *)user SuccessBlock:(void (^)(NSArray *orders))success FailureBlock:(void_FailureBlock)failure;

+ (void)deleteOrder:(orderModel *)order ByUser:(UserObject *)user SuccessBlick:(void (^)(BOOL result))success FailureBlock:(void_FailureBlock)failure;

+ (void)getOrderItemByOrder:(orderModel *)order SuccessBlock:(void (^)(NSArray *orderItems))success FailureBlock:(void_FailureBlock)failure;

@end
