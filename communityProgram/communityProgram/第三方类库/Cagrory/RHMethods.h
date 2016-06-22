//
//  RHMethods.h
//  ktvdr
//
//  Created by 何涛 Thomas on 12-4-8.
//  Copyright (c) 2012年 重庆奥芬多网络科技有限公司. All rights reserved.
//


#import <Foundation/Foundation.h>
@interface RHMethods : NSObject

+ (UILabel*)labelWithFrame:(CGRect)aframe font:(UIFont*)afont color:(UIColor*)acolor text:(NSString*)atext;
+ (UILabel*)labelWithLableFrame:(CGRect)aframe withFont:(UIFont*)afont withColor:(UIColor*)acolor withtAttributedSting:(NSString*)attribute;


+(UIButton*)buttonWithFrame:(CGRect)_frame title:(NSString*)_title  image:(NSString*)_image bgimage:(NSString*)_bgimage;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image;
+(UIImageView*)imageviewWithFrame:(CGRect)_frame defaultimage:(NSString*)_image stretchW:(NSInteger)_w stretchH:(NSInteger)_h;
@end
