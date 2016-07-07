//
//  ShoppingProductModel.h
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModel.h"

@interface ShoppingProductModel : baseModel

@property (nonatomic, copy  ) NSString *productImageUrl;
@property (nonatomic, copy  ) NSString *productTitle;
//@property(nonatomic,copy)NSString *goodsType;
@property (nonatomic, strong  ) NSString *productOriginalPrice;
@property (nonatomic, strong  ) NSString *productDiscountPrice;
@property (nonatomic, assign) BOOL     selected;
@property (nonatomic, assign) int      goodsNum;




@end
