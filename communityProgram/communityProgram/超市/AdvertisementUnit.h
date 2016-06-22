//
//  AdvertisementUnit.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/15.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementUnit : NSObject
/**
 *  广告id
 */
@property(nonatomic,copy)NSString * id;
/**
 *  图片地址
 */
@property(nonatomic,copy)NSString * imageLogo;
/**
 *  创建时间
 */
@property(nonatomic,copy)NSString * createTime;

@end
