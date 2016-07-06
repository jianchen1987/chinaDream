//
//  NetworkEngine.m
//  PulanManager
//
//  Created by tru on 15/11/12.
//  Copyright © 2015年 创必承. All rights reserved.
//

#import "NetworkEngine.h"
#import "MBProgressHUD.h"
#import "AFHTTPSessionManager.h"

@implementation NetworkEngine
/************有正在加载提示****************/
+(void)postRequestWithUrl:(NSString *)urlString paramsArray:(id)params WithPath:(NSString *)path successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer             = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer              = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/javascript"];
    //传入的参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"2.0",@"jsonrpc",@"0",@"id",path,@"method",params,@"params", nil];
//    NSLog(@"请求参数 = %@",dic);
//    NSLog(@"请求URL = %@",[baseUrl stringByAppendingString:urlString]);
    [manager POST:[baseUrl stringByAppendingString:urlString]
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        
//        NSLog(@"response = %@",responseObject);
        
        NSDictionary *resposeDic = responseObject;
        if ([resposeDic valueForKey:@"error"]) {
//            NSLog(@"resposeDic.message = %@",[[resposeDic valueForKey:@"error"] valueForKey:@"message"]);
            errorBlock([[[resposeDic valueForKey:@"error"] valueForKey:@"code"] intValue],[[resposeDic valueForKey:@"error"] valueForKey:@"message"]);
        }else
        {
            successBlock([resposeDic valueForKey:@"result"]);
        }
        
    }
          failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error)
    {
//        NSLog(@"error = %@",error);
      
    }];

    
    
    
}
/************没有加载提示****************/
+(void)postRequestWithUrlNoState:(NSString *)urlString paramsArray:(id)params methodPath:(NSString *)path successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/javascript"];//javascript,
    //传入的参数
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"2.0",@"jsonrpc",@"0",@"id",path,@"method",params,@"params", nil];//@"35ba59d6-c5f3-497d-9a81-3e466977ffec",@"userId",@"测试数据",@"description",
            NSLog(@"____ dic = %@",dic);
    NSLog(@"urlString = %@",urlString);
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"response = %@",responseObject);

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
    
    
}


+(void)postRequestWithUrlNoState:(NSString *)urlString paramsArray:(id)params methodPath:(NSString *)path WithImageArray:(NSSet *)imageSet successBlock:(void(^)(id successJsonData))successBlock errorBlock:(void(^)(int code,NSString *errorJsonData))errorBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        NSInteger imgCount = 0;
        
        for (NSData *imageData in imageSet) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:SSS";
            
            NSString *fileName = [NSString stringWithFormat:@"%@%@.png",[formatter stringFromDate:[NSDate date]],@(imgCount)];
            
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"uploadFile%@",@(imgCount)] fileName:fileName mimeType:@"image/png"];
            
            imgCount++;
            
        }
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"responseObject = %@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
    }];
}
+(void)postImageRequestWithUrl:(NSString *)urlString paramsArray:(id)params WithImage:(NSArray *)imageArray WithPath:(NSString *)path WithImageName:(NSString *)imageName WithFileName:(NSString *)fileName successBlock:(void(^)(id successJsonData,NSString *massege))successBlock errorBlock:(void(^)(int code,id errorJsonData))errorBlock
{
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"2.0",@"jsonrpc",@"0",@"id",path,@"method",params,@"params", nil];
    NSLog(@"dic = %@",dic);
    
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    // 1.创建网络管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 2.利用网络管理者上传数据
    [manager POST:[baseUrl stringByAppendingString:AppService] parameters:params constructingBodyWithBlock:
     ^void(id<AFMultipartFormData> formData) {
         
         for (int i = 0; i < imageArray.count; i++) {
             NSData *imageData = UIImageJPEGRepresentation(imageArray[i], 0.5);
             NSString *baseImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
             NSData *ddd = [baseImageStr dataUsingEncoding:4];
             
             NSString *imageNames = [NSString stringWithFormat:@"%@%d",@"img",i+1];
             NSString *fileNames = [NSString stringWithFormat:@"%@.jpg",@"headImage"];
             [formData appendPartWithFileData:ddd name:imageNames fileName:fileNames mimeType:@"image/png"];
         }
     } success:^void(NSURLSessionDataTask * task, id responseObject) {
         // 请求成功
         NSLog(@"请求成功 %@", responseObject);
         id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
         NSLog(@"result = %@",result);
         
     } failure:^void(NSURLSessionDataTask * task, NSError * error) {
         // 请求失败
         NSLog(@"请求失败 %@", error);
     }];
    
}
+(void)showHUDString:(NSString *)string Withshowtime:(int)second WithView:(UIView *)seleview
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:seleview animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.margin = 10.f;
    int offset = 0;
    if(DeviceHeight == 480){// iphone 4s
        hud.yOffset = DeviceHeight/2-80;
        
    }else if(DeviceHeight == 568){// iphone 5/5s
        offset = DeviceHeight/2-80;
        
    }else if(DeviceHeight == 667){// iphone 6/6s
        offset = DeviceHeight/2-100;
    }else
    {
        offset = DeviceHeight/2-120;
    }
    hud.yOffset = offset;
    hud.labelText = string;
    hud.userInteractionEnabled=NO;
    hud.removeFromSuperViewOnHide = NO;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, second * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        //            [hud3 hide:YES];
        [hud removeFromSuperview];
    });
    [seleview addSubview:hud];
    
}






@end
