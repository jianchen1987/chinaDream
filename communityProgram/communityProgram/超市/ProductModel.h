//
//  ProductUnit.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/16.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModel.h"

@interface ProductModel : baseModel
//@property(nonatomic,copy)NSString * productName;
// /** 门市价 */
//@property(nonatomic,copy)NSString * price;
///** 出售价 */
//@property(nonatomic,copy)NSString * discountPrice;
///** 购买数量 */
//@property(nonatomic,assign)NSInteger * buyNum;

//private static final long serialVersionUID = 3265211055793200689L;
@property(nonatomic,copy)NSString * id;
/** 产品名称 */
@property(nonatomic,copy)NSString *  productName;
/** 门市价 */
@property(nonatomic,assign)float price;
/** 出售价 */
@property(nonatomic,assign)double discountPrice;
/** 产品描述 */
@property(nonatomic,copy)NSString *  simpleIntro;

/** 图文介绍 */
@property(nonatomic,copy)NSString *  imageText;

/*** 超市产品封面*/
@property(nonatomic,copy)NSString *  productIcon;

/** 超市产品与产品轮播图存在一对多 */
@property(nonatomic,strong)NSArray * productLogos;
//private List<ProductLogo> productLogos = new ArrayList<ProductLogo>();

/** 评论数 ( 每次评论后 数量 加一 ) */
@property(nonatomic,assign)NSInteger commentPeople;

//private Long commentPeople;
/** 0 代表常规的分类，1代表新品 */
@property(nonatomic,assign)NSInteger hot;
/** 0 代表常规的分类，1代表推荐 */
@property(nonatomic,assign)NSInteger tuijian;
/** 点赞人数*/
@property(nonatomic,assign)NSInteger lovePeople;
/** 点赞人 （不暴露出去） */
@property(nonatomic,strong)NSArray * adoptProducts;
//private List<AdoptProduct> adoptProducts = new ArrayList<AdoptProduct>();

/** 收藏人数 */
@property(nonatomic,assign)NSInteger collProduct;
/** 收藏人列表 （不暴露出去） */
@property(nonatomic,strong)NSArray * collProducts;
//private List<CollProduct> collProducts = new ArrayList<CollProduct>();

/** 分享数量*/
@property(nonatomic,assign)NSInteger sharePeople;
/** 产品与产品类型存在多对一的关联关系 */
//private ProductType productType;

/** 超市产品与会员存在多对多的关联关系 */
@property(nonatomic,strong)NSArray * users;
//private List<User> users = new ArrayList<User>();


/** 是否上架 0：未发布 1：已发布 */
@property(nonatomic,copy)NSString *  isPublic;


/**小区与超市存在多对多的关联关系 */
@property(nonatomic,strong) NSArray * quarters;
//private List<Quarter> quarters = new ArrayList<Quarter>();


/** 产品与评论存在多对一的关联关系 */
/* @OneToMany(fetch = FetchType.LAZY, mappedBy = "product")
 @Fetch(FetchMode.SUBSELECT)
 private List<Comment> comments = new ArrayList<Comment>();*/

/** 购买数量 */

@property(nonatomic,assign)NSInteger  buyNum;
/** 单品总价 = 单价 * 购买数量 */
@property(nonatomic,assign) double money;
/** 库存  */
@property(nonatomic,assign)NSInteger stock;
/** 销量 */
@property(nonatomic,assign)NSInteger saleNum;

/** 斤｜件｜个 */
@property(nonatomic,copy)NSString *  jianOrJin;

@property (nonatomic,assign) BOOL selected;

@end
