//
//  FreeEatRecordModel.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FreeEatModel.h"
#import "User.h"
@interface FreeEatRecordModel : NSObject
//quarter
@property(nonatomic,strong)NSString * id;
@property(nonatomic,strong)User * user;
//private static final long serialVersionUID = -6527387533263242902L;
/**
 * 试吃记录与试吃存在一对多的关联
 */
@property(nonatomic,strong)FreeEatModel * freeEat;
/** 手机号码 */
@property(nonatomic,copy)NSString *  phone;
/** ip地址 */
@property(nonatomic,copy)NSString *  userIp;

/** 领取码。以后生成二维码 */
@property(nonatomic,copy)NSString *  freeEatCode;

/** 试吃记录与用户存在一对多关联 */
//private User user;

/** 是否领取  1代表未领取 2代表已领取 */
@property(nonatomic,assign)NSInteger hasTake ;
@property(nonatomic,strong)NSString * createTime;

//private long hasTake;

/** 短信发送记录 */
@property(nonatomic,copy)NSString *  sendRecord;

@end
