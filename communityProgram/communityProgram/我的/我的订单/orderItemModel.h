//
//  orderItemModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModel.h"

@class productModel;
@interface orderItemModel : baseModel

@property (nonatomic, strong) NSString     *orderId;
@property (nonatomic, strong) productModel *productId;
@property (nonatomic, assign) NSNumber     *orderItemNum;
@property (nonatomic, strong) NSNumber     *sendPrice;
@property (nonatomic, strong) NSDate       *createTime;

@end
