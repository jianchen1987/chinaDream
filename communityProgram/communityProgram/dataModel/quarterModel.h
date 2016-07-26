//
//  quarterModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//
#import "baseModel.h"
#import "UserObject.h"


//@class zoneModel;

@interface quarterModel : baseModel<NSCoding>

@property (nonatomic,strong ) NSString     *quarterId;
/**
 *  小区名字
 */
@property (nonatomic, copy  ) NSString     *quarterName;
/**
 *  小区地址
 */
@property (nonatomic, copy  ) NSString     *quarterAddress;
/**
 *  小区图标
 */
@property (nonatomic, copy  ) NSString     *quarterIcon;
/**
 *  小区描述
 */
@property (nonatomic, copy  ) NSString     *remark;
/**
 *  小区用户
 */
@property (nonatomic, strong) NSArray      *users;
/**
 *  经度
 */
@property (nonatomic, copy  ) NSString     *lng;
/**
 *  纬度
 */
@property (nonatomic, copy  ) NSString     *lat;


@property (nonatomic, strong) NSDate *createTime;


@property (nonatomic, strong) NSArray      *freeEats;

@property (nonatomic, strong) NSArray      *products;

//@property (nonatomic, strong) zoneModel    *zone;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (nullable instancetype)initWithCoder:( NSCoder * _Nonnull )aDecoder;

@end
