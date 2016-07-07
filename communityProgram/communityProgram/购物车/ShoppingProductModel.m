//
//  ShoppingProductModel.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "ShoppingProductModel.h"

@implementation ShoppingProductModel

- (instancetype)initWithJsonData:(NSDictionary *)json
{
    self = [super initWithJsonData:json];
    if(self)
    {
        self.productImageUrl      = [json objectForKey:@"productIcon"];
        self.productTitle         = [json objectForKey:@"productName"];
        self.productDiscountPrice = [[json objectForKey:@"discountPrice"] stringValue];
        self.productOriginalPrice = [[json objectForKey:@"price"] stringValue];
        self.goodsNum             = [[json objectForKey:@"buyNum"] intValue];
        self.selected             = NO;

    }
    
    return self;
}


@end
