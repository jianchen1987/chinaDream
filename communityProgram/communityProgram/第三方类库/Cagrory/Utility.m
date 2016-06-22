//
//  Utility.m
//  EpadSign
//
//  Created by LZH on 14-10-14.
//  Copyright (c) 2014年 高国峰. All rights reserved.
//

#import "Utility.h"
#import "Reachability.h"

@interface Utility ()


@property (nonatomic,strong) Reachability *reachability;
@end



@implementation Utility


static Utility *_utilityinstance=nil;
static dispatch_once_t utility;

+(id)Share
{
    dispatch_once(&utility, ^ {
        _utilityinstance = [[Utility alloc] init];

        
        _utilityinstance.reachability =  [Reachability reachabilityForInternetConnection];
        [Utility reachabilityChanged:nil];
        [_utilityinstance.reachability startNotifier];
    });
	return _utilityinstance;
}
+(int)uid{
    return [[[Utility Share] userid] intValue];
}
- (NSString*)userid
{
    if (!_userid) {
    }
    return _userid;
}


#pragma mark -
#pragma mark Reachability related

+(void) reachabilityChanged:(NSNotification*) notification
{
    if([_utilityinstance.reachability currentReachabilityStatus] == NotReachable)
    {
        _utilityinstance.offline = YES;
    }else{
        if (_utilityinstance.offline) {
        }
        _utilityinstance.offline = NO;
    }
}

/**
 *	保存obj的array到本地，如果已经存在会替换本地。
 *
 *	@param	obj	待保存的obj
 *	@param	key	保存的key
 */
+ (void)saveToArrayDefaults:(id)obj forKey:(NSString*)key
{
    [self saveToArrayDefaults:obj replace:obj forKey:key];
}
+ (void)saveToArrayDefaults:(id)obj replace:(id)oldobj forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults valueForKey:key];
    
    NSMutableArray *marray = [NSMutableArray array];
    if (!oldobj) {
        oldobj = obj;
    }
    if (array) {
        [marray addObjectsFromArray:array];
        if ([marray containsObject:oldobj]) {
            [marray replaceObjectAtIndex:[marray indexOfObject:oldobj] withObject:obj];
        }else{
            [marray addObject:obj];
        }
    }else{
        [marray addObject:obj];
    }
    [defaults setValue:marray forKey:key];
    [defaults synchronize];
}

+ (BOOL)removeForArrayObj:(id)obj forKey:(NSString*)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults valueForKey:key];
    
    NSMutableArray *marray = [NSMutableArray array];
    if (array) {
        [marray addObjectsFromArray:array];
        if ([marray containsObject:obj]) {
            [marray removeObject:obj];
        }
    }
    if (marray.count) {
        [defaults setValue:marray forKey:key];
    }else{
        [defaults removeObjectForKey:key];
    }
    [defaults synchronize];
    return marray.count;
}
/**
 *	保存obj到本地
 *
 *	@param	obj	数据
 *	@param	key	键
 */
+ (void)saveToDefaults:(id)obj forKey:(NSString*)key
{
    if ([obj isKindOfClass:[NSNull class]]) {
     obj=@"";
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:obj forKey:key];
    [defaults synchronize];

}

+ (id)defaultsForKey:(NSString*)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}
+ (void)removeForKey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark TimeTravel
- (NSString*)timeToNow:(NSString*)theDate
{
    if (!theDate) {
        return nil;
    }
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[dateFormatter dateFromString:theDate];
    if (!d) {
        return theDate;
    }
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=(now-late)>0 ? (now-late) : 0;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@ 分前", timeString];
        
    }else if (cha/3600>1 && cha/3600<24) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@ 小时前", timeString];
    }
    else
    {
        timeString = [NSString stringWithFormat:@"%.0f 天前",cha/3600/24];
    }
    
    return timeString;
}

+ (NSString*)timeAfterNow:(NSString*)theDate
{
    if (!theDate) {
        return nil;
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%@",theDate];
        if ([str isEqualToString:@"0"])
        {
            return @"";
        }else
        {
            NSString *timeString=@"";
            if ([theDate isEqualToString:@"长期"]) {
                return theDate;
            }else
            {
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *d=[dateFormatter dateFromString:theDate];
                
                NSTimeInterval late=[d timeIntervalSince1970]*1;
                NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
                NSTimeInterval now=[dat timeIntervalSince1970]*1;
                
                NSTimeInterval cha= late - now;
                if(cha<0){
                    return @"已截止";
                }
                if (cha/3600<1) {
                    timeString = [NSString stringWithFormat:@"%f", cha/60];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@ 分", timeString];
                    
                }else if (cha/3600>1 && cha/3600<24) {
                    timeString = [NSString stringWithFormat:@"%f", cha/3600];
                    timeString = [timeString substringToIndex:timeString.length-7];
                    timeString=[NSString stringWithFormat:@"%@ 小时 %d 分", timeString,(int)cha%3600];
                }
                else
                {
                    timeString = [NSString stringWithFormat:@"%.0f 天 %d 小时",cha/3600/24,(int)(cha/3600)%24];
                }
                return timeString;
            }
            
        }
    }
}
//随机16位字符
+(NSString *)ret16bitString
{
    char data[16];
    for (int x=0;x<16;data[x++] = (char)('A' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:16 encoding:NSUTF8StringEncoding];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动: 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通: 130,131,132,152,155,156,185,186
     * 电信: 133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     * 中国移动:China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     * 中国联通:China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /**
     * 中国电信:China Telecom
     * 133,1349,153,180,189
     */
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate *regextestcm =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate *regextestcu =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate *regextestct =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        ||([regextestcm evaluateWithObject:mobileNum] == YES)
        ||([regextestcu evaluateWithObject:mobileNum] == YES)
        ||([regextestct evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    return NO;
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
+(NSMutableAttributedString *)rebackDiscountPriceAttr:(NSString *)string
{
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:string];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:contentRange];
    return content;
}

+(UIFont *)adapterFontAccordingDeviceWidth
{
    UIFont *font = Font(12);
    if (DeviceWidth == 375) {
        font = Font(14);
    }else if(DeviceWidth == 414)
    {
        font = Font(15);

    }else
        font = Font(12);
    
    return font;
}
+(CGFloat)marginLeftDistanceAccordingDeviceWidth
{
    CGFloat leftFloat = 0;
    if (DeviceWidth == 375) {
        leftFloat = 8;
    }else if(DeviceWidth == 414)
    {
        leftFloat = 10;
    }else
        leftFloat = 5;
    
    return leftFloat;
}



@end
