//
//  PurchaseTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseButton.h"
#import "UIImageView+WebCache.h"
@interface PurchaseTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *desLable;
@property(nonatomic,strong)PurchaseButton *dateButton;
-(void)loadCellData:(NSDictionary *)dic;

@end
