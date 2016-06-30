//
//  AllChipModel.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllChipModel : NSObject
/** 标题 */
@property(nonatomic,strong)NSString* title;
/** 封面 */
@property(nonatomic,strong)NSString* chipsIcon;
/** 期限 */
@property(nonatomic,strong)NSString* expireDate;
/** 目标  */
@property(nonatomic,strong)NSString*  descInfo;

/** 斤｜件｜元 */
@property(nonatomic,strong)NSString* jianOrJin;

/** 支持人数 */
@property(nonatomic,strong)NSString* supportNum;

/** 已筹到 xx 斤｜件｜元 */
@property(nonatomic,assign)NSInteger chipNum;

/** 图文介绍 */
@property(nonatomic,strong)NSString* imageText;

/** 众筹与众筹轮播图存在一对多 */
@property(nonatomic,strong)NSArray * ArrayList;

/** 众筹与用户存在多对多的关联关系 */
//private List<User> users = new ArrayList<User>();

/** 评论数 ( 每次评论后 数量 加一 ) */
@property(nonatomic,assign)NSInteger * commentPeople;

//private Long commentPeople;
/** 点赞人数*/
@property(nonatomic,assign)NSInteger * lovePeople;

/** 点赞人 （不暴露出去） */
@property(nonatomic,strong)NSArray *adoptAllChips;
/** 收藏人数 */
@property(nonatomic,assign)NSArray * collAllChip;

//private Long collAllChip;
/** 收藏人列表 （不暴露出去） */
@property(nonatomic,strong)NSArray * collAllChips;
//private List<CollAllChip> collAllChips = new ArrayList<CollAllChip>();


/** 分享数量*/
@property(nonatomic,strong)NSString *sharePeople;
/**
 * 单价
 */
@property(nonatomic,strong)NSString *price;
/**
 * 产品描述
 */
@property(nonatomic,strong)NSString* simpleIntro;
/** 订单状态   0.未发货 1.已发货,未确认 3.订单完成 ，4 订单取消  */
@property(nonatomic,strong)NSString* allChipStatu;
@end
