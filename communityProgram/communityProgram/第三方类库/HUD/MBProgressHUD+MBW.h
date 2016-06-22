//
//  MBProgressHUD+MBW.h
//  PayEasy
//
//  Created by yfzx-gd-mabw on 15/10/2.
//  Copyright (c) 2015年 Bestpay. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD(MBW)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

//+ (UIImageView *)showGIF:(NSString *)message;
+ (UIImageView *)showGIF:(NSString*)name message:(NSString *)msg toView:(UIView *)view;
+ (void)hideGIFfromView:(UIView *)view;
@end
