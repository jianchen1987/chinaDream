//
//  SystemFunction.h
//  ZFProject
//
//  Created by 谢泽锋 on 16/4/15.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^Location)(CLLocationManager*manager,NSArray*locations);//定位回调block
typedef void(^Placemark)(CLPlacemark *placemark);//地区详情
@interface SystemFunction : NSObject<MFMessageComposeViewControllerDelegate>
//定位属性
@property(nonatomic,copy)Location location;
@property(nonatomic,copy)Placemark placemark;
/**
 *发短信
 */
+(void)SystemSendTextMessages:(NSString*)PhoneNumber;

/**
 *打电话
 */
+(void)SystemDialTelephone:(NSString*)PhoneNumber;
/**
 *指纹识别
 */
+(void)SystemTouchID;
/**
 *定位
 */
-(void)SystemGetTheCurrentLocation;
/**
 *根据当前城市获得地理坐标
 *  
 SystemFunction* syes=[[SystemFunction alloc]init];
 [syes SystemgetCoordinateByAddress:@"广州"];
 syes.placemark=^(CLPlacemark* place){
 
 };
 */
-(void)SystemgetCoordinateByAddress:(NSString * )cityName;
/**
 *根据坐标获得Placemark
 */
-(void)SystemgetAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude;

/**
 *改变屏幕的亮度
 */
+(void)SystemChangeScreenBrightness:(double)Value;
/**
 * 二维码生成
 */
+(UIImage*)SystemCodeimageString:(NSString*)codeDetail;

/**
 *  设置图标显示字数
 */

+(void)seticonNumber:(NSInteger)Count;

/**
 *  打开网页
 */
+(void)openURL:(NSString*)urlString;





/**
 *群发短信
 */
//-(void)SendMassTextMessages:(NSArray *)PhoneNumberArray VControler:(UIViewController*)viewControler;
@end
