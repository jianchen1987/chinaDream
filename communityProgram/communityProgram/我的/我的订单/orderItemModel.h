//
//  orderItemModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "orderModel.h"

@class Product;

@interface orderItemModel : NSObject

@property (nonatomic, strong) orderModel *order;
@property (nonatomic, strong) Product *product;
@property (nonatomic, assign) NSUInteger orderItemNum;
@property (nonatomic, strong) NSNumber *sendPrice;

@end
