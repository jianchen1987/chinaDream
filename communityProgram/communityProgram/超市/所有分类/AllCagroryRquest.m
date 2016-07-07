//
//  AllCagroryRquest.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/4.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "AllCagroryRquest.h"
#import "UserObject.h"
#import "ProductModel.h"
#import <MJExtension.h>
@interface AllCagroryRquest()
@end
@implementation AllCagroryRquest
+(void)getProductByHotOrTuiJianRquestSuccessBlock:(void (^)(id))successBlock errorBlock:(void (^)(int, NSString *))errorBlock{
    UserObject* user=[UserObject shareUser];
    
    NSArray * arr=@[@"",user.quarter.id?user.quarter.id:@"",@1,@10];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:arr WithPath:getProductByHotOrTuiJian successBlock:^(NSDictionary* successJsonData) {
        NSMutableArray * array =[NSMutableArray array];
        NSArray * hot=[successJsonData objectForKey:@"hot"];
        for (int i=0; i<hot.count; i++) {
            ProductModel * unit =[ProductModel mj_objectWithKeyValues:hot[i]];
            [array addObject:unit];
        }
        NSArray * tuijian=[successJsonData objectForKey:@"tuijian"];
        for (int i=0; i<tuijian.count; i++) {
            ProductModel * unit =[ProductModel mj_objectWithKeyValues:tuijian[i]];
            [array addObject:unit];
        }
        successBlock(array);
    } errorBlock:^(int code, NSString *errorJsonData) {
        errorBlock(code,errorJsonData);
    }];

}
+(void)getProductByCodeRquestparamsArray:(NSArray*)params SuccessBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock{
    
    [NetworkEngine postRequestWithUrl:AppService paramsArray:params
                             WithPath:@"getProductByCode" successBlock:^(NSArray* successJsonData) {
                                 NSMutableArray * array =[NSMutableArray array];

                                 for (int i=0; i<successJsonData.count; i++)
                                 {
                                     ProductModel * unit =[ProductModel mj_objectWithKeyValues:successJsonData[i]];
                                     
                                     [array addObject:unit];
                                 }
                                 successBlock(array);
                                 
                             } errorBlock:^(int code, NSString *errorJsonData) {
                                 errorBlock(code, errorJsonData);
                             }];

    
}

@end
