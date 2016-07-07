//
//  orderItemModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModel.h"
#import "ProductModel.h"

@interface orderItemModel : baseModel

@property (nonatomic, strong) NSString     *orderId;
@property (nonatomic, strong) NSString     *orderItemId;
@property (nonatomic, strong) ProductModel *product;
@property (nonatomic, assign) NSNumber     *orderItemNum;
@property (nonatomic, strong) NSNumber     *sendPrice;
@property (nonatomic, strong) NSDate       *createTime;

@end
