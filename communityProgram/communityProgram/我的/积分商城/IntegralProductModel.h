//
//  IntegralProductModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,IntegralProductExchangeType)
{
    IntegralProductExchangeTypeIntegral = 0,
    IntegralProductExchangeTypePartIntegralPartCash,
    IntegralProductExchangeTypeAll
};

typedef NS_ENUM(NSInteger,IntegralProductHotCategory)
{
    IntegralProductHotCategoryNormal,
    IntegralProductHotCategoryHot
};

typedef NS_ENUM(NSInteger, IntegralProductRecommendCategory)
{
    IntegralProductRecommendCategoryNormal,
    IntegralProductRecommendCategoryRecommed
};

typedef NS_ENUM(NSInteger, IntegralProductType)
{
    IntegralProductTypeNormal = 0
};

@interface IntegralProductModel : NSObject

@property (nonatomic, strong) NSString *ipid;
/**
 * 产品名称
 */
@property (nonatomic, strong) NSString *productName;
/**
 * 固定积分
 */
@property (nonatomic, strong) NSNumber *price;
/**
 * 部分积分
 */
@property (nonatomic, strong) NSNumber *discountIntegral;
/**
 * 部分现金
 */
@property (nonatomic, strong) NSNumber *discountPrice;
/**
 * 兑换类型  0:全积分  1：部分积分+部分现金   2:全积分 / 部分积分+部分现金
 */
@property (nonatomic, assign) IntegralProductExchangeType *exchangeType;
/**
 * 产品简介
 */
@property (nonatomic, strong) NSString *simpleIntro;
/**
 * 图文介绍
 */
@property (nonatomic, strong) NSString *imageText;

/**
 * 超市产品封面
 */
@property (nonatomic, strong) NSString *productIcon;

/**
 * 超市产品与产品轮播图存在一对多
 */
@property (nonatomic, strong) NSArray *integralProductLogos;

/**
 * 评论数 ( 每次评论后 数量 加一 )
 */
@property (nonatomic, assign) NSUInteger *commentPeople;
/**
 * 0 代表常规的分类，1代表热门
 */
@property (nonatomic, assign) IntegralProductHotCategory hot;
/**
 * 0 代表常规的分类，1代表推荐
 */
@property (nonatomic, assign) IntegralProductRecommendCategory tuijian;
/**
 * 点赞人数
 */
@property (nonatomic, assign) NSUInteger lovePeople;

/** 点赞人 （不暴露出去） */
@property (nonatomic, strong) NSArray *adoptIntegrals;

/** 收藏人数 */
@property (nonatomic, assign) NSUInteger collIntegral;
/** 收藏人列表 （不暴露出去） */
@property (nonatomic, strong) NSArray *collIntegrals;

/**
 * 分享数量
 */
@property (nonatomic, assign) NSUInteger sharePeople;
/**
 * 积分商城与积分商城类型存在多对一的关联关系
 */
@property (nonatomic, assign) IntegralProductType integralProductType;

/**
 * 积分商城与会员存在多对多的关联关系
 */
@property (nonatomic, strong) NSArray *users;

/** 产品与评论存在多对一的关联关系 */
/*
 @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
 @Fetch(FetchMode.SUBSELECT)
 private List<Comment> comments = new ArrayList<Comment>();
 */

/**
 * 购买数量
 */
@property (nonatomic, assign) NSUInteger buyNum;
/**
 * 单品总价 = 单价 * 购买数量
 */
@property (nonatomic, strong) NSNumber *money;
/**
 * 库存
 */
@property (nonatomic, strong) NSString *stock;
/**
 * 换人数
 */
@property (nonatomic, assign) NSUInteger exchangeCount;

@end
