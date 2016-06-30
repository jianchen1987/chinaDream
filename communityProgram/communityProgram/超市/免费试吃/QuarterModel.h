//
//  QuarterModel.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuarterModel : NSObject
//private static final long serialVersionUID = -3488129705803105796L;
@property(nonatomic,strong)NSString * id;
/** 小区的名称 */
@property(nonatomic,strong)NSString *  quarterName;
/** 小区地址 */
@property(nonatomic,strong)NSString *  quarterAddress;
/** 小区图标 */
@property(nonatomic,strong)NSString *  quarterIcon;
/** 小区描述 */
@property(nonatomic,strong)NSString *  remark;
/** 小区与用户存在一对多的关联关系 */
@property(nonatomic,strong)NSArray * users;
//private List<User> users = new ArrayList<User>();
/** 精度 */
@property(nonatomic,strong)NSString *  lng;
/** 纬度 */
@property(nonatomic,strong)NSString *  lat;


/**免费试吃与小区存在多对多的关联关系 */
@property(nonatomic,strong)NSArray *freeEats;
//private List<FreeEat> freeEats = new ArrayList<FreeEat>();

/**免费试吃与小区存在多对多的关联关系 */
@property(nonatomic,strong)NSArray *products;
//private List<Product> products = new ArrayList<Product>();

/** 超市产品与小区存在多对一的关联关系 */
//private Zone zone = new Zone();
@end
