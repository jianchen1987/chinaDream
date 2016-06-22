//
//  WaittingPaymentModel.h
//  communityProgram
//
//  Created by xiaogao on 16/2/28.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaittingPaymentModel : NSObject
@property(nonatomic,copy)NSString *productImageStr;
@property(nonatomic,copy)NSString *productTitle;
@property(nonatomic,copy)NSString *productDescription;
@property(nonatomic,copy)NSString *productPrice;
@property(nonatomic,copy)NSString *productNum;
@property(nonatomic,assign)int goodsNum;

@property(nonatomic,assign)BOOL selected;
-(instancetype)initWithShopDict:(NSDictionary *)dic;

@end
