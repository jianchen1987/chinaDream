//
//  UserIntegralModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/7/25.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "baseModel.h"

@interface UserIntegralModel : baseModel<NSCoding>

@property (nonatomic, strong) NSString *UIID;
@property (nonatomic, strong) NSNumber *integralNum;
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *modifyTime;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (nullable instancetype)initWithCoder:( NSCoder * _Nonnull )aDecoder;
@end
