//
//  IntegralMallTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/2/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralMallTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *descriptionLable;
@property(nonatomic,strong)UILabel *integralLable;
@property(nonatomic,strong)UILabel *detailIntegralLable;
@property(nonatomic,strong)UILabel *sealNumberLable;


-(void)setCellData:(NSDictionary *)dic;

@end
