//
//  BaseTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *descriptionLable;
@property(nonatomic,strong)UILabel *dateLable;


-(void)cellForData:(NSDictionary *)dic;

@end
