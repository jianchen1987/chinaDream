//
//  ShoppingProductModel.h
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingProductModel : NSObject
@property(nonatomic,copy)NSString *productImageName;
@property(nonatomic,copy)NSString *productTitle;
//@property(nonatomic,copy)NSString *goodsType;
@property(nonatomic,copy)NSString *productOriginalPrice;
@property(nonatomic,copy)NSString *productDiscountPrice;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,assign)int goodsNum;


-(instancetype)initWithShopDict:(NSDictionary *)dic;

@end
