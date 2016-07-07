//
//  NetworkEngine.h
//  PulanManager
//
//  Created by tru on 15/11/12.
//  Copyright © 2015年 创必承. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface NetworkEngine : NSObject
/************有正在加载提示****************/
+(void)postRequestWithUrl:(NSString *)urlString paramsArray:(id)params WithPath:(NSString *)path successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;
/************没有加载提示****************/
+(void)postRequestWithUrlNoState:(NSString *)urlString paramsArray:(id)params methodPath:(NSString *)path successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;

//+(void)postImageRequestWithUrl:(NSString *)urlString paramsArray:(id)params WithImage:(NSArray *)imageArray WithPath:(NSString *)path WithImageName:(NSString *)imageName WithFileName:(NSString *)fileName successBlock:(void(^)(id successJsonData,NSString *massege))successBlock errorBlock:(void(^)(int code,id errorJsonData))errorBlock;

+(void)postRequestWithUrlNoState:(NSString *)urlString paramsArray:(id)params methodPath:(NSString *)path WithImageArray:(NSSet *)imageSet successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock;

+(void)showHUDString:(NSString *)string Withshowtime:(int)second WithView:(UIView *)seleview;

+(void)postImageRequestWithUrl:(NSString *)urlString paramsArray:(id)params WithImage:(NSArray *)imageArray WithPath:(NSString *)path  WithFileName:(NSString *)fileName successBlock:(void(^)(id successJsonData,NSString *massege))successBlock errorBlock:(void(^)(int code,id errorJsonData))errorBlock;
@end
