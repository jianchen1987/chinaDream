//
//  AllChipLogoModel.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/1.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
//广告图
@interface AllChipLogoModel : NSObject
@property(nonatomic,strong)NSString * id;
//private static final long serialVersionUID = 5208746959792946946L;

/** 邻里问问是否绑定 */
@property(nonatomic,strong)NSString * isBind;

/** 邻里问问绑定的Id */
@property(nonatomic,strong)NSString * relationId;

/** 绑定的类型*/
@property(nonatomic,strong)NSString * relationType; // nearAsk  nearTalk   product allChip ,freeEat, notice

/** 众筹产品图片 */
@property(nonatomic,strong)NSString * imageLogo;



/** 类型(超市广告或者众筹广告) */
@property(nonatomic,strong)NSString * type;


@end
