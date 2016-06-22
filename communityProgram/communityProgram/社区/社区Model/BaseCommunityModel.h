//
//  BaseCommunityModel.h
//  communityProgram
//
//  Created by xiaogao on 16/2/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCommunityModel : NSObject
@property(nonatomic,copy)NSString *userImageUrl;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *userSex;
@property(nonatomic,copy)NSString *userVIP1;
@property(nonatomic,copy)NSString *userVIP2;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *place;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *praiseNum;
@property(nonatomic,copy)NSString *commentNum;
@end
