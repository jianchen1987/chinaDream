//
//  myCrowdFundingTableViewCell.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/1.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressView.h"
@interface myCrowdFundingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageview;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet ProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UIButton *left_BT;
@property (weak, nonatomic) IBOutlet UIButton *right;
@property (weak, nonatomic) IBOutlet UILabel *time_LB;

@end
