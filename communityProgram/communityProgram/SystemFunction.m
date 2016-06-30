//
//  SystemFunction.m
//  ZFProject
//
//  Created by 谢泽锋 on 16/4/15.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import "SystemFunction.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface SystemFunction ()<CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;

}


@end
@implementation SystemFunction
{
    MFMessageComposeViewController*mesage;
}
#pragma mark 指纹识别
+(void)SystemTouchID{
    //新建LAContext实例
    LAContext  *authenticationContext= [[LAContext alloc]init];
    NSError *error;
    //1:检查Touch ID 是否可用
    if ([authenticationContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"touchId 可用");
        //2:执行认证策略
        [authenticationContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"需要验证您的指纹来确认您的身份信息" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"通过了Touch Id指纹验证");
            }else{
                NSLog(@"error===%@",error);
                NSLog(@"code====%d",error.code);
                NSLog(@"errorStr ======%@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
                if (error.code == -2) {//点击了取消按钮
                    NSLog(@"点击了取消按钮");
                }else if (error.code == -3){//点输入密码按钮
                    NSLog(@"点输入密码按钮");
                }else if (error.code == -1){//连续三次指纹识别错误
                    NSLog(@"连续三次指纹识别错误");
                }else if (error.code == -4){//按下电源键
                    NSLog(@"按下电源键");
                }else if (error.code == -8){//Touch ID功能被锁定，下一次需要输入系统密码
                    NSLog(@"Touch ID功能被锁定，下一次需要输入系统密码");
                }
                NSLog(@"未通过Touch Id指纹验证");
            }
        }];
    }else{
        //todo goto 输入密码页面
        NSLog(@"error====%@",error);
        NSLog(@"抱歉，touchId 不可用");
    }

}
#pragma mark 发短信
-(void)SystemSendTextMessages:(NSString*)PhoneNumber
{
    NSString * phone=[NSString stringWithFormat:@"sms://%@",PhoneNumber];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phone]];
}
-(void)SystemSendMassTextMessages:(NSArray *)PhoneNumberArray VControler:(UIViewController*)viewControler
{
    mesage=[[MFMessageComposeViewController alloc]init];
    mesage.body=@"你好";
    mesage.messageComposeDelegate=self;
    mesage.recipients=PhoneNumberArray;
    [viewControler presentViewController:mesage animated:YES completion:nil];
//    [viewControler presentModalViewController:mesage animated:YES];
}
#pragma mark 拨打电话
+(void)SystemDialTelephone:(NSString*)PhoneNumber
{
    NSString * phone=[NSString stringWithFormat:@"tel://%@",PhoneNumber];

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:phone]];
}
//使用者完成操作时所呼叫的内部函数
- (void)SystemmessageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
    switch (result) {
        case MessageComposeResultSent:
            //讯息传送成功
            break;
            
        case MessageComposeResultFailed:
            //讯息传送失败
            break;
            
        case MessageComposeResultCancelled:
            //讯息被用户取消传送
            break;
            
        default:
            break;
    }
    [mesage dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 定位
-(void)SystemGetTheCurrentLocation
{
    /*
    需要在Info.plist中加入两个缺省没有的字段
    
    NSLocationAlwaysUsageDescription
    
    NSLocationWhenInUseUsageDescription
     */
    //定位管理器
    _locationManager=[[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }

}
#pragma mark - CoreLocation 代理
#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
//可以通过模拟器设置一个虚拟位置，否则在模拟器中无法调用此方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    CLLocation *location=[locations firstObject];//取出第一个位置
//    CLLocationCoordinate2D coordinate=location.coordinate;//位置坐标
//    NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    
     self.location(manager,locations);
//    //如果不需要实时定位，使用完即使关闭定位服务
    [_locationManager stopUpdatingLocation];
//    NSLog(@"%@",location);
   
}

#pragma mark 根据地名确定地理坐标
-(void)SystemgetCoordinateByAddress:(NSString * )cityName;
{
     CLGeocoder *_geocoder= [[CLGeocoder alloc]init];
    //地理编码
    [_geocoder geocodeAddressString:cityName completionHandler:^(NSArray *placemarks, NSError *error) {
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark=[placemarks firstObject];
        
        CLLocation *location=placemark.location;//位置
        CLRegion *region=placemark.region;//区域
        NSDictionary *addressDic= placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
                NSString *name=placemark.name;//地名
        //        NSString *thoroughfare=placemark.thoroughfare;//街道
        //        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
        //        NSString *locality=placemark.locality; // 城市
        //        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
        //        NSString *administrativeArea=placemark.administrativeArea; // 州
        //        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
        //        NSString *postalCode=placemark.postalCode; //邮编
        //        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
        //        NSString *country=placemark.country; //国家
        //        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
        //        NSString *ocean=placemark.ocean; // 海洋
        //        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
        NSLog(@"%@",name);
        NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
        self.placemark(placemark);
    }];
}
#pragma mark 根据坐标取得地名
-(void)SystemgetAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    CLGeocoder *_geocoder= [[CLGeocoder alloc]init];
    
    //反地理编码
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        self.placemark(placemark);
        NSLog(@"详细信息:%@",placemark.addressDictionary);
    }];
}
#pragma mark 改变屏幕的亮度
+(void)SystemChangeScreenBrightness:(double)Value{
//    获取系统屏幕当前的亮度值
//    float value = [UIScreen mainScreen].brightness;
//    设置系统屏幕的亮度值
    [[UIScreen mainScreen] setBrightness:Value];
}

#pragma mark 生成二维码
+(UIImage*)SystemCodeimageString:(NSString*)codeDetail
{
    //二维码滤镜
    
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[codeDetail dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    UIImage * image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:320];
    return image;
}
//-(void)erweima
//
//{
//
//    //二维码滤镜
//
//    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
//
//    //恢复滤镜的默认属性
//
//    [filter setDefaults];
//
//    //将字符串转换成NSData
//
//    NSData *data=[@"我市博文我市博文我市博文我市博文我市博文我市博文" dataUsingEncoding:NSUTF8StringEncoding];
//
//    //通过KVO设置滤镜inputmessage数据
//
//    [filter setValue:data forKey:@"inputMessage"];
//
//    //获得滤镜输出的图像
//
//    CIImage *outputImage=[filter outputImage];
//
//    //将CIImage转换成UIImage,并放大显示
//
//
//    _imgView.image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:320];
//
//
//
//    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
//
//    _imgView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
//
//    _imgView.layer.shadowRadius=1;//设置阴影的半径
//
//    _imgView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
//
//    _imgView.layer.shadowOpacity=0.3;
//
//
//
//}
//改变二维码大小

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
-(UIImage*)creat :(NSString*)str
{
    // 1. 实例化二维码滤镜
    
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2. 恢复滤镜的默认属性
    
    [filter setDefaults];
    
    // 3. 将字符串转换成
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 4. 通过KVO设置滤镜inputMessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    // 5. 获得滤镜输出的图像
    
    CIImage *outputImage = [filter outputImage];
    
    // 6. 将CIImage转换成UIImage，并放大显示
    
    return [UIImage imageWithCIImage:outputImage scale:222 orientation:UIImageOrientationUp];
}



+(void)seticonNumber:(NSInteger)Count{

    UIApplication * app=[UIApplication sharedApplication];
    UIUserNotificationSettings * usr= [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [app registerUserNotificationSettings:usr];
    app.applicationIconBadgeNumber=Count;
}
+(void)openURL:(NSString*)urlString{
    UIApplication *app =[UIApplication sharedApplication];
    [app openURL:[NSURL URLWithString:urlString]];
}









@end
