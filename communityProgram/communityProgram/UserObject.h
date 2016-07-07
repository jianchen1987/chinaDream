//
//  UserObject.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/14.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModel.h"
#import "quarterModel.h"



@interface UserObject : baseModel<NSCoding>

/**
 *  后台唯一字段
 */
@property (nonatomic, strong) NSString *identifyName;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickName;
/**
 *  qq
 */
@property (nonatomic, copy) NSString *qqId;
/**
 *  微信
 */
@property (nonatomic, copy) NSString *weChatId;
/**
 *  登录名|手机号
 */
@property (nonatomic, copy) NSString *phone;

/**
 *  密码md5
 */
@property (nonatomic, copy) NSString *passWord;

/**
 *   性别
 */
@property (nonatomic, copy) NSString *gender;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *headIcon;
/**
 * 地址 省市
 */
@property (nonatomic, copy) NSString *address;
/**
 *  房间号
 */
@property (nonatomic, copy) NSString *room;
/**
 *  剩余积分（可用积分）
 */
@property (nonatomic, copy) NSString *myExtraIntegral;
/**
 *  等级积分
 */
@property (nonatomic, copy) NSString *identityIntegral;
/**
 *  生日
 */
@property (nonatomic, copy) NSString *birth;
/**
 *  兴趣爱好
 */
@property (nonatomic, copy) NSString *hobbile;
/**
 *  故乡
 */
@property (nonatomic, copy) NSString *homeTown;
/**
 *  0普通用户  1 会员
 */
@property (nonatomic, copy) NSString *master;
/**
 *  关注我的用户
 */
@property (nonatomic, strong) NSArray *parents;
/**
 *  我关注的用户
 */
@property (nonatomic, strong) NSArray *childens;
/**
 *  收藏的超市产品
 */
@property (nonatomic, strong) NSArray *products;
/**
 *  收藏的积分商城商品
 */
@property (nonatomic, strong) NSArray *integralProducts;
/**
 *  收藏的闲置用品
 */
@property (nonatomic, strong) NSArray *secondHands;
/**
 *  消息
 */
@property (nonatomic, strong) NSArray *notices;
/**
 *  积分
 */
@property (nonatomic, copy) NSString *integral;
/**
 *  小区
 */
@property (nonatomic, strong) quarterModel *quarter;
/**
 *  我的订单
 */
@property (nonatomic, strong) NSArray *orders;
/**
 *  我的众筹
 */
@property (nonatomic, strong) NSArray *allChips;
/**
 *  免费试吃
 */
@property (nonatomic, strong) NSArray *freeEats;
/**
 *  动态
 */
@property (nonatomic, strong) NSArray *dymaics;


+(UserObject*)shareUser;


- (BOOL)isLogin;
- (void)loginOut;

- (void)updateInfo:(NSDictionary *)jsonData;


- (void)encodeWithCoder:(NSCoder *)aCoder;
- (nullable instancetype)initWithCoder:( NSCoder * _Nonnull )aDecoder;



@end
