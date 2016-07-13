//
//  collectionViewModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"
#import "ProductModel.h"

@class ChipModel;
@class FreeEatModel;
@class IntegralProductModel;
@class SecondHandProductModel;
@class TalkOrAskModel;


@interface collectionViewModel : NSObject

+ (void)saveProductCollection:(ProductModel *)product forUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;

+ (void)saveChipCollection:(ChipModel *)chip forUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;

+ (void)saveFreeEatCollection:(FreeEatModel *)freeEat forUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;

+ (void)saveIntegralProductCollection:(IntegralProductModel *)integralProduct forUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;

+ (void)saveSecondHandCollection:(SecondHandProductModel *)secondHandProduct forUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;

+ (void)saveTalkOrAskCollection:(TalkOrAskModel *)talkOrAsk forUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_BOOL)success FailureBlock:(void_FailureBlock)failure;

@end
