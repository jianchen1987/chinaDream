//
//  AllCagroryRquest.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/4.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkEngine.h"
@interface AllCagroryRquest : NSObject
/**
 *  根据商品获得所有推荐
 *
 *  @param successBlock <#successBlock description#>
 *  @param errorBlock   <#errorBlock description#>
 */
+(void)getProductByHotOrTuiJianRquestSuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;
/**
 *  根据code来获取产品信息列表
 */
+(void)getProductByCodeRquestparamsArray:(NSArray*)params SuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;
@end
