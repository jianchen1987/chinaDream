//
//  SecondHandProductModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObject.h"

@class SecondHandLogoModel;
@class AdoptSecondModel;
@class CollSecondModel;
@class CommentModel;

@interface SecondHandProductModel : NSObject

@property (nonatomic, strong) NSString *shid;
/** 二手产品名称 */
@property (nonatomic, strong) NSString *secondHandName;
/** 出售价格 */
@property (nonatomic, strong) NSNumber *price;
/** 原价格 */
@property (nonatomic, strong) NSNumber *sourcePrice;

/** 产品描述 */
@property (nonatomic, strong) NSString *remark;

/** 二手闲置与二手闲置轮播图存在一对多 */
//SecondHandLogoModel
@property (nonatomic, strong) NSArray *secondHandLogos;

/** 喜欢人数 | 点赞人数 */
@property (nonatomic, assign) NSUInteger lovePeople;
/** 点赞人 （不暴露出去） */
//AdopSecondModel
@property (nonatomic, strong) NSArray *adoptSeconds;
/** 收藏人数 */
@property (nonatomic, assign) NSUInteger collPeople;
/** 收藏人列表 （不暴露出去） */
//collSecondModel
@property (nonatomic, strong) NSArray *collSeconds;

/** 分享数量 */
@property (nonatomic, assign) NSUInteger sharePeople;
/** 评论数 ( 每次评论后 数量 加一 ) */
@property (nonatomic, assign) NSUInteger commentPeople;
/*** 小区的名称 */
@property (nonatomic, strong) NSString *quarterName;
/** 小区id */
@property (nonatomic, strong) NSString *quarterId;

/** 二手闲置产品与评论存在一对多的关联关系 */
//CommentModel
@property (nonatomic, strong) NSArray *comments;

/** 二手闲置产品与会员存在多对一的关联关系 */
@property (nonatomic, strong) UserObject *user;

@end
