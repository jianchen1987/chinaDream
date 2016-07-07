//
//  CrowdFundingView.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Action)();
@interface CrowdFundingView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *detaile;
@property (weak, nonatomic) IBOutlet UIButton *action_BT;
@property(nonatomic,copy)Action action;
@end
