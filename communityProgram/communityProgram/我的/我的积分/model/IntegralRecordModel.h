//
//  IntegralRecordModel.h
//  communityProgram
//
//  Created by 陈剑 on 16/7/25.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "baseModel.h"

@interface IntegralRecordModel : baseModel

@property (nonatomic, copy  ) NSString *irID;
@property (nonatomic, copy  ) NSString *recordName;
@property (nonatomic, strong) NSNumber *integralNum;
@property (nonatomic, strong) NSNumber *integralType;
@property (nonatomic, strong) NSDate   *createTime;


@end
