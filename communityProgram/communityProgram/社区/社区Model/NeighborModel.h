//
//  NeighborModel.h
//  communityProgram
//
//  Created by xiaogao on 16/2/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtherCommentModel.h"
@interface NeighborModel : NSObject
@property(nonatomic,copy)NSString *userImageUrl;//用户头像
@property(nonatomic,copy)NSString *userName;//用户名称
@property(nonatomic,copy)NSString *userSex;//用户性别
@property(nonatomic,copy)NSString *userVIP1;//预留
@property(nonatomic,copy)NSString *userVIP2;//预留
@property(nonatomic,copy)NSString *createTime; //创建时间
@property(nonatomic,copy)NSString *place; //地点
@property(nonatomic,copy)NSString *quarterName; //小区名称
@property(nonatomic,copy)NSString *remark; //备注
@property(nonatomic,strong)NSArray *images;//图片数组

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *other;

@property(nonatomic,copy)NSString *praiseNum;
@property(nonatomic,copy)NSString *commentNum;

@property(nonatomic,copy)NSString *userImageStr;
@property(nonatomic,copy)NSString *userNameStr;
@property(nonatomic,copy)NSString *userCommentStr;

@end
