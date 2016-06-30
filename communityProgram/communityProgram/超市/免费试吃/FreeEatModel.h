//
//  FreeEatModel.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeEatModel : NSObject

private static final long serialVersionUID = -9061236091959250210L;
/** 产品名称 */
@property(nonatomic,copy)NSString *  productName;
/** 份额 */
@property(nonatomic,copy)NSString *  freeNum;

/** 有效期 */
private Date expireDate;
/** 封面 */
@property(nonatomic,copy)NSString *  freeIcon;
/** 原价 */
@property(nonatomic,copy)NSString *  sourcePrice;
/** 规格 */
@property(nonatomic,copy)NSString *  spec;
/** 申请人数 */
private Long applyNum;

/** 图文介绍 */
@property(nonatomic,copy)NSString *  imageText;

/** 免费试吃与小区存在多对一的关联关系 */
/*    @ManyToOne(fetch = FetchType.LAZY)
 @JoinColumn(name = "QUARTER_ID")
 @ForeignKey(name = "FK_FREEEAT_QUARTER")
 private Quarter quarter = new Quarter();*/

/** 免费试吃与用户存在多对多的关联关系 */
private List<User> users = new ArrayList<User>();

/**小区与免费试吃存在多对多的关联关系 */
private List<Quarter> quarters = new ArrayList<Quarter>();



/** 评论数 ( 每次评论后 数量 加一 ) */
private Long commentPeople;
/** 点赞人数*/
private Long lovePeople;
/** 点赞人 （不暴露出去） */
private List<AdoptFreeEat> adoptFreeEats = new ArrayList<AdoptFreeEat>();

/** 收藏人数 */
private Long collFreeEat;
/** 收藏人列表 （不暴露出去） */
private List<CollFreeEat> collFreeEats = new ArrayList<CollFreeEat>();

/** 分享数量*/
private Long sharePeople;
/** 规则说明 */
private Long ruleMessage;

@end
