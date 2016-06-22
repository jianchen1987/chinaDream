//
//  AppDelegate.m
//  communityProgram
//
//  Created by xiaogao on 15/12/5.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "AppDelegate.h"

#import "UserObject.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置导航栏底部颜色和状态栏颜色
    [[UINavigationBar appearance] setTintColor:[UIColor greenColor]];
    [[UINavigationBar appearance] setBarTintColor:RGBA(68, 180, 17, 1)];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:19], NSFontAttributeName, nil]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabBarImage"] forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setSelectedImageTintColor:RGBA(103, 203, 45, 1)];

    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"NavigationBar_separa"]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [Utility saveToDefaults:@"35ba59d6-c5f3-497d-9a81-3e466977ffec" forKey:@"quarterID"];

    
    MainTabViewController *main = [[MainTabViewController alloc] init];
    self.window.rootViewController = main;
    [self loadData];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    
    
    NSInteger iCurYear = [components year];  //当前的年份
    
    
    
    NSInteger iCurMonth = [components month];  //当前的月份
    
    
    
    NSInteger iCurDay = [components day];  // 当前的号数
    
    
    NSCalendar *calendars = [NSCalendar currentCalendar];
    
    
    NSString* string = @"20110826134106";
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
    
    
    
    NSUInteger numberOfDaysInMonth = range.length;
    
    
    
//    [Utility saveToDefaults:[successJsonData valueForKey:@"gender"] forKey:@"gender"];
//    [Utility saveToDefaults:[successJsonData valueForKey:@"nickName"] forKey:@"nickName"];
//    [Utility saveToDefaults:[successJsonData valueForKey:@"id"] forKey:@"userID"];
//    [Utility saveToDefaults:[successJsonData valueForKey:@"phone"] forKey:@"phone"];
//    if ([successJsonData valueForKey:@"quarter"]) {
//        [Utility saveToDefaults:[[successJsonData valueForKey:@"quarter"] valueForKey:@"id"] forKey:@"quarterID"];
//    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    UserObject * user=[UserObject shareUser];
    if ([defaults objectForKey:@"userID"]) {
        user.nickName=[defaults valueForKey:@"nickName"];
        user.nickName=[defaults valueForKey:@"nickName"];
        user.id=[defaults valueForKey:@"userID"];
        user.phone=[defaults valueForKey:@"phone"];
        user.gender=[defaults valueForKey:@"gender"];
    }
   

    
    return YES;
}
-(void)loadData
{
    
    

    
//    NSArray *array = @[];
//    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:GetQuartersPath successBlock:^(id successJsonData) {
//        NSLog(@"successJsonData = %@",successJsonData);
//        
//        for (NSDictionary *dic in successJsonData) {
//            [Utility saveToDefaults:[dic valueForKey:@"id"] forKey:@"id"];
//            [Utility saveToDefaults:[dic valueForKey:@"quarterName"] forKey:@"quarterName"];
//            [Utility saveToDefaults:[NSString stringWithFormat:@"%@%@",appHostPath,[dic valueForKey:@"quarterIcon"]] forKey:@"quarterIcon"];
//            [Utility saveToDefaults:[dic valueForKey:@"quarterAddress"] forKey:@"quarterAddress"];
//            
//        }
//    } errorBlock:^(int code, NSString *errorJsonData) {
//        NSLog(@"errorJsonData = %@",errorJsonData);
//        
//    }];
//    
//    //根据用户id获取用户信息
//    NSArray *params1 = @[];
//    if ([Utility defaultsForKey:@"userID"]) {
//        params1 = @[[Utility defaultsForKey:@"userID"]];
//    }
//    [NetworkEngine postRequestWithUrl:AppService paramsArray:params1 WithPath:GetUserByIdPath successBlock:^(id successJsonData) {
//        
//        NSLog(@"successJsonData = %@",successJsonData);
//        
//        
//    } errorBlock:^(int code, NSString *errorJsonData) {
//        NSLog(@"errorJsonData = %@",errorJsonData);
//    }];
//    
//    
//    //根据手机号码获取用户信息
//    NSArray *params2 = @[];
//    if ([Utility defaultsForKey:@"phone"]) {
//        params2 = @[[Utility defaultsForKey:@"phone"]];
//    }
//    
//    [NetworkEngine postRequestWithUrl:AppService paramsArray:params2 WithPath:GetUserByPhonePath successBlock:^(id successJsonData) {
//        
//        NSLog(@"successJsonData = %@",successJsonData);
//        
//    } errorBlock:^(int code, NSString *errorJsonData) {
//        NSLog(@"errorJsonData = %@",errorJsonData);
//    }];
    
    
    //优惠券接口...领取优惠券
    
//    NSArray *array1 = @[];
//    [NetworkEngine postRequestWithUrl:AppService paramsArray:array1 WithPath:UserHasCouponPath successBlock:^(id successJsonData) {
//        NSLog(@"successJsonData = %@",successJsonData);
//    } errorBlock:^(int code, NSString *errorJsonData) {
//        NSLog(@"errorJsonData = %@",errorJsonData);
//    }];
//
//    
//    NSArray *array2 = @[[Utility defaultsForKey:@"userID"]];
//    [NetworkEngine postRequestWithUrl:AppService paramsArray:array2 WithPath:UserUseCouponPath successBlock:^(id successJsonData) {
//        NSLog(@"successJsonData = %@",successJsonData);
//    } errorBlock:^(int code, NSString *errorJsonData) {
//        NSLog(@"errorJsonData = %@",errorJsonData);
//
//    }];

    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
