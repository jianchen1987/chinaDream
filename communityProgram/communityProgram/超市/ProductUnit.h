//
//  ProductUnit.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/16.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductUnit : NSObject
@property(nonatomic,copy)NSString * productName;
 /** 门市价 */
@property(nonatomic,copy)NSString * price;
/** 出售价 */
@property(nonatomic,copy)NSString * discountPrice;
/** 购买数量 */
@property(nonatomic,assign)NSInteger * buyNum;



@end
