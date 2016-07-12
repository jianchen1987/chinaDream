//
//  ShoppingCarManager.h
//  communityProgram
//
//  Created by 陈剑 on 16/7/7.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductModel.h"
#import "UserObject.h"
#import "collectionViewModel.h"

@interface ShoppingCarViewModel : NSObject


+ (void)addProduct:(ProductModel *)product
               Num:(NSUInteger)num
           forUser:(UserObject *)user
      SuccessBlock:(void_SuccessBlock_BOOL)success
      FailureBlock:(void_FailureBlock)failure;

+ (void)getShoppingCarListByUser:(UserObject *)user
                    SuccessBlock:(void_SuccessBlock_Arrary)success
                    FailureBlock:(void_FailureBlock)failure;

+ (void)removeProduct:(ProductModel *)product
              forUser:(UserObject *)user
         SuccessBlock:(void_SuccessBlock_BOOL)success
         FailureBlock:(void_FailureBlock)failure;

+ (void)modifyNum:(NSUInteger)num
        ofProduct:(ProductModel *)product
          forUser:(UserObject *)user
     SuccessBlock:(void_SuccessBlock_BOOL)success
     FailureBlock:(void_FailureBlock)failure;

@end
