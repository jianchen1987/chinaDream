//
//  orderModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "addressModel.h"

typedef NS_ENUM(NSUInteger,CPOrderStatus)
{
    CPOrderStatusNoPay = 0,
    CPOrderStatusNoSend,
    CPOrderStatusNoConfirm,
    CPOrderStatusCompleted,
    CPOrderStatusHadCancel
};

@interface orderModel : NSObject

@property (nonatomic, copy  ) NSString     *orderCode;
@property (nonatomic, assign) NSUInteger   orderTotalNum;

@property (nonatomic, copy  ) NSString     *orderBarCode;

@property (nonatomic, copy  ) NSDate       *sendDate;

@property (nonatomic, copy  ) NSDate       *isPaySignDate;

@property (nonatomic, copy  ) NSString     *isPay;

@property (nonatomic, copy  ) NSString     *orderStatus;

@property (nonatomic, strong) NSNumber     *amount;

@property (nonatomic, strong) NSNumber     *totalSendMoney;

@property (nonatomic, copy  ) NSString     *message;

@property (nonatomic, copy  ) NSString     *identityName;

@property (nonatomic, strong) NSArray      *orderItems;

@property (nonatomic, strong) addressModel *address;

@property (nonatomic, copy  ) NSString     *coupon;



@end
