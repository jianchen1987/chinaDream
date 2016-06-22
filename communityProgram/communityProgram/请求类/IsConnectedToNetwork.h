//
//  IsConnectedToNetwork.h
//  SchoolHelper
//
//  Created by 高国峰 on 14/12/8.
//  Copyright (c) 2014年 EpadSign. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<SystemConfiguration/SCNetworkReachability.h>

@interface IsConnectedToNetwork : NSObject
+ (BOOL)connectedToNetwork;
@end
