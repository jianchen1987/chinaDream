//
//  NearUserViewModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/7/25.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"

@interface NearUserViewModel : NSObject


+ (void)getNearNeighborByUser:(UserObject *)user SuccessBlock:(void_SuccessBlock_Arrary)success FailureBlock:(void_FailureBlock)failure;

@end
