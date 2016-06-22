//
//  ExchangeRecordTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeRecordTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *statusLable;
-(void)cellWithData:(NSDictionary *)dic;

@end
