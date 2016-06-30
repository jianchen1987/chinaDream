//
//  User.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuarterModel.h"
@interface User : NSObject
/**
 *  小区
 */
@property(nonatomic,strong)QuarterModel * quarter;

@property(nonatomic,copy)NSString * id;
//private static final long serialVersionUID = -3264406219283785658L;
/** 昵称 */
@property(nonatomic,copy)NSString *nickName;
/**  QQ */
@property(nonatomic,copy)NSString *qqId;
/**  微信 */
@property(nonatomic,copy)NSString *weChatId;

/** 登录名 | 手机号码 */
@property(nonatomic,copy)NSString *phone;
/** 密码 */
@property(nonatomic,copy)NSString *passWord;
/** 性别 */
@property(nonatomic,copy)NSString *gender;
/** 头像 */
@property(nonatomic,copy)NSString *headIcon;
/** 地址（省+ 市） */
@property(nonatomic,copy)NSString *address;
/** 房间号 ：如403 */
@property(nonatomic,copy)NSString *room;

/** 我的剩余积分|（可用积分） */
@property(nonatomic,assign)NSInteger * myExtraIntegral;
/** 等级积分 */
@property(nonatomic,assign)NSInteger * identityIntegral;
/** 出生年月 */
@property(nonatomic,copy)NSString *birth;
/** 兴趣爱好 */
@property(nonatomic,copy)NSString *hobbile;
/** 故乡  */
@property(nonatomic,copy)NSString *homeTown;
/** 0 代表普通用户 1 代表会员  */
@property(nonatomic,assign)NSInteger * master;

/**
 * 当前用户与我关注的用户存在一对多的关联关系
 *  */
@property(nonatomic,strong)NSArray * parent;
//private List<User> parent = new ArrayList<User>();
/**
 * 我关注的用户与当前用户存在多对一的关联关系
 *  */
@property(nonatomic,strong)NSArray *children;
//private List<User> children = new ArrayList<User>();
/** 会员与收藏超市产品存在多对多的关联关系  */
@property(nonatomic,strong)NSArray *products;
//private List<Product> products = new ArrayList<Product>();

/** 会员与收藏积分商城存在多对多的关联关系  */
@property(nonatomic,strong)NSArray *integralProducts;
//private List<IntegralProduct> integralProducts = new ArrayList<IntegralProduct>();

/** 会员与收藏的闲置存在一对多的关联关系  */
@property(nonatomic,strong)NSArray *secondHands;
//private List<SecondHand> secondHands = new ArrayList<SecondHand>();

/** 会员与我的消息存在一对多的关联关系 */
@property(nonatomic,strong)NSArray *notices;
//private List<Notice> notices = new ArrayList<Notice>();

/** 会员与我的积分存在一对多的关联关系 */
@property(nonatomic,assign)NSInteger integral;

//private Integral integral = new Integral();

/** 会员与收藏的邻里问问或说说存在一对多 */
//private List<NearAsk> nearAsks = new ArrayList<NearAsk>();

/** 会员与我的小区存在多对一的关联关系 */
//private Quarter quarter = new Quarter();

/** 会员与订单存在  */
//private List<Order> orders = new ArrayList<Order>();

/** 会员与详细地址存在一对多的关联关系  */

//private List<Address> addresses = new ArrayList<Address>();
@property(nonatomic,strong)NSArray * addresses;
/** 会员与众筹存在多对多的关联关系  */
//private List<AllChip> allChips = new ArrayList<AllChip>();
@property(nonatomic,strong)NSArray *allChips;
/** 会员与免费试吃存在多对多的关联关系  */
@property(nonatomic,strong)NSArray *freeEats;

//private List<FreeEat> freeEats = new ArrayList<FreeEat>();

/** 会员与动态存在一对多的关联关系 */
@property(nonatomic,strong)NSArray *dymaics;
//private List<Dymaic> dymaics = new ArrayList<Dymaic>();

//给后台使用的字段
@property(nonatomic,copy)NSString *identifyName;
@end
