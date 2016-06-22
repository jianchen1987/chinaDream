//
//  BaseProductModel.h
//  communityProgram
//
//  Created by xiaogao on 16/1/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseProductModel : NSObject
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *descriptionStr;
@property(nonatomic,copy)NSString *priceStr;
@property(nonatomic,copy)NSString *discountPriceStr;
@property(nonatomic,copy)NSString *buyNumberStr;

@end
