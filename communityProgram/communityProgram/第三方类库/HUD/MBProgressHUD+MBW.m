//
//  MBProgressHUD+MBW.m
//  PayEasy
//
//  Created by yfzx-gd-mabw on 15/10/2.
//  Copyright (c) 2015年 Bestpay. All rights reserved.
//

#import "MBProgressHUD+MBW.h"
#import "UIImageView+GIF.h"

@implementation MBProgressHUD(MBW)
#pragma mark - GIF加载动画
+ (UIImageView *)showGIF:(NSString *)message
{
    return [self showGIF:@"" message:message toView:nil];
}

+ (UIImageView *)showGIF:(NSString *)name message:(NSString *)msg toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    UIView *bgview = [[UIView alloc]initWithFrame:view.bounds];
    bgview.alpha = 0.1;
    bgview.backgroundColor = [UIColor whiteColor];
    NSString *fileName = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
    UIImageView *reGif = [UIImageView imageViewWithGIFFile:fileName];
    reGif.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds)-50);
    UILabel *msgLa = [[UILabel alloc]init];
    msgLa.textAlignment = NSTextAlignmentCenter;
    msgLa.textColor = [UIColor lightGrayColor];
    msgLa.frame = CGRectMake(0, CGRectGetMaxY(reGif.frame), [[UIScreen mainScreen] bounds].size.width, 30);
    msgLa.backgroundColor = [UIColor clearColor];
    msgLa.text = msg;
    [bgview addSubview:msgLa];
    [bgview addSubview:reGif];
    [view addSubview:bgview];
    [UIView animateWithDuration:0.2 animations:^{
        bgview.alpha = 1;
    }];
    
    return reGif;
}

+(void)hideGIFfromView:(UIView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
        [view.subviews lastObject].alpha = 0.1;
    } completion:^(BOOL finished) {
        [[view.subviews lastObject] removeFromSuperview];
    }];
}

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候移除
    hud.removeFromSuperViewOnHide = YES;
    // 不能用延迟，当被return时会残留蒙版
    [hud hide:YES afterDelay:1];
}

#pragma mark 显示错误
+ (void)showError:(NSString *)error toView:(UIView *)view{
    if (error.length >=15) {
        error = [NSString stringWithFormat:@"%@\n%@",[error substringToIndex:15],[error substringFromIndex:15]];
    }
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    if (success.length >=15) {
        success = [NSString stringWithFormat:@"%@\n%@",[success substringToIndex:15],[success substringFromIndex:15]];
    }
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示MESSAGE
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:NO];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
