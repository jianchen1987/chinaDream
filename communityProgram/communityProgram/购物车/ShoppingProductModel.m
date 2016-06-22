//
//  ShoppingProductModel.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "ShoppingProductModel.h"

@implementation ShoppingProductModel
-(instancetype)initWithShopDict:(NSDictionary *)dic
{
    self.productImageName = dic[@"image"];
    self.productTitle = dic[@"title"];
    self.productDiscountPrice = dic[@"discountPrice"];
    self.productOriginalPrice = dic[@"originalPrice"];
    self.goodsNum = [dic[@"productNum"] intValue];
    self.selected = [dic[@"selected"] boolValue];
    return self;
}
@end
