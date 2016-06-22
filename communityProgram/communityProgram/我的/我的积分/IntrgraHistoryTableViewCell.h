//
//  IntrgraHistoryTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntrgraHistoryTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *dateLable;
@property(nonatomic,strong)UILabel *integralLable;

-(void)cellWithData:(NSDictionary *)dic;

@end
