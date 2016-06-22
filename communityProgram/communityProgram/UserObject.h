//
//  UserObject.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/14.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject
@property(nonatomic,strong)NSString * id;
/**
 *  用户名
 */
@property(nonatomic,copy)NSString * nickName;
/**
 *  密码md5
 */
@property(nonatomic,copy)NSString * passWord;

@property(nonatomic,copy)NSString * phone ;

@property(nonatomic,copy)NSString * createTime;
/**
 *  头像
 */
@property(nonatomic,copy)NSString * quarterIcon;
/**
 * 地址
 */
@property(nonatomic,copy)NSString * quarterAddress;
/**
 *   性别
 */
@property(nonatomic,strong)NSString * gender;

+(UserObject*)shareUser;










@end
