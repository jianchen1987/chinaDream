//
//  addressModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressModel : NSObject

@property (nonatomic, copy) NSString * _Nullable aid;
@property (nonatomic, copy) NSString * _Nullable phone;
@property (nonatomic, copy) NSString * _Nullable sendName;
@property (nonatomic, copy) NSString * _Nullable levelRoom;
@property (nonatomic, copy) NSString * _Nullable quarterName;
@property (nonatomic, copy) NSString * _Nullable identityName;

@property (nonatomic, assign) BOOL isDefault;

- (nullable instancetype)initWithJsonData:(NSDictionary  * _Nullable )json;

@end
