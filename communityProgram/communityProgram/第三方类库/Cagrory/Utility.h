//
//  Utility.h
//  EpadSign
//
//  Created by LZH on 14-10-14.
//  Copyright (c) 2014年 高国峰. All rights reserved.
//

#define DeviceUUID @"UUID"


#import <Foundation/Foundation.h>



@interface Utility : NSObject
//启用缓存
@property (nonatomic,assign) BOOL offline;

@property (nonatomic,strong) NSString  *userid;
@property (nonatomic,strong) NSString  *username;


+(id)Share;
+(int)uid;
- (NSString*)timeToNow:(NSString*)theDate;
+(NSString*)timeAfterNow:(NSString*)theDate;
+ (BOOL)removeForArrayObj:(id)obj forKey:(NSString*)key;
+ (void)saveToDefaults:(id)obj forKey:(NSString*)key;
+ (void)saveToArrayDefaults:(id)obj forKey:(NSString*)key;
+ (void)saveToArrayDefaults:(id)obj replace:(id)oldobj forKey:(NSString*)key;
+ (id)defaultsForKey:(NSString*)key;
+ (void)removeForKey:(NSString*)key;


+(NSString *)ret16bitString;
+ (BOOL) validateIdentityCard: (NSString *)identityCard; //验证身份证

//邮箱
+ (BOOL) validateEmail:(NSString *)email;


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
+(BOOL)isMobileNumber:(NSString *)mobileNum;

//类似打折控件
+(NSMutableAttributedString *)rebackDiscountPriceAttr:(NSString *)string;

+(UIFont *)adapterFontAccordingDeviceWidth; //根据屏幕适配文字大小
+(CGFloat)marginLeftDistanceAccordingDeviceWidth;




@end
