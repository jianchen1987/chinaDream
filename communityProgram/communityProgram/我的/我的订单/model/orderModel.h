//
//  orderModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "baseModel.h"
#import "addressModel.h"
#import "UserObject.h"
#import "orderItemModel.h"

typedef NS_ENUM(NSUInteger,CPOrderStatus)
{
    CPOrderStatusNoPay = 0,
    CPOrderStatusNoSend,
    CPOrderStatusNoConfirm,
    CPOrderStatusCompleted,
    CPOrderStatusHadCancel
};


@class couponModel;

@interface orderModel : baseModel

@property (nonatomic, strong) NSString       *orderId;
//订单号
@property (nonatomic, strong) NSString       *orderCode;
//订单总数量
@property (nonatomic, strong) NSNumber       *orderTotalNum;
//订单条形码
@property (nonatomic, strong) NSString       *orderBarCode;
//发货时间
@property (nonatomic, strong) NSDate         *sendDate;
//前台确认收货时间
@property (nonatomic, strong) NSDate         *isPaySignDate;
//支付状态  0未支付  1已支付
@property (nonatomic, strong) NSString       *isPay;
//订单状态  0未支付 1.未发货  2 前台未确认  3 订单完成  4 已取消
@property (nonatomic, assign) CPOrderStatus  orderStatus;
//订单总金额
@property (nonatomic, strong) NSNumber       *amount;
//总配送费
@property (nonatomic, strong) NSNumber       *totalSendMoney;
//订单留言
@property (nonatomic, strong) NSString       *message;
//用户
@property (nonatomic, strong) UserObject     *user;
//订单明细
//orderItemModel
@property (nonatomic, strong) NSMutableArray *orderItems;
//订单地址
@property (nonatomic, strong) addressModel   *address;
//优惠券id
@property (nonatomic, strong) couponModel    *coupon;

@property (nonatomic, strong) NSDate         *createTime;


@end
