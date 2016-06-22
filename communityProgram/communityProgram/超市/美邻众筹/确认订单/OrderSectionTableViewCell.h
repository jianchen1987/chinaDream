//
//  OrderSectionTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/3/5.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNumberView.h"
@interface OrderSectionTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *descriptionLable;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UILabel *discountLable;
@property(nonatomic,strong)UIView *firstLineView;
@property(nonatomic,strong)UILabel *numberLable;
@property(nonatomic,strong)AddNumberView *addNumView;
@property(nonatomic,strong)UIView *secondLineView;
@property(nonatomic,strong)UILabel *messageLable;
@property(nonatomic,strong)UITextField *messageTextField;


@end
