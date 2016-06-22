//
//  WaittingPaymentTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/2/28.
//  Copyright © 2016年 高国峰. All rights reserved.
//
@protocol WaittingPaymentDelegate

-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag;
-(void)selectWithCell:(UITableViewCell *)cell WithButtonAction:(BOOL)select;


@end
#import <UIKit/UIKit.h>
#import "WaittingPaymentModel.h"
#import "AddNumberView.h"
@interface WaittingPaymentTableViewCell : UITableViewCell<AddNumberViewDelegate>

@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UILabel *productLable;
@property(nonatomic,strong)UILabel *productDesLable;
@property(nonatomic,strong)UILabel *productPriceLable;
@property(nonatomic,strong)AddNumberView *addNumberView;

@property (nonatomic,strong) WaittingPaymentModel *model;
@property (nonatomic,assign) id<WaittingPaymentDelegate>delegate;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIButton *paymentButton;
@property(nonatomic,strong)UIButton *cancleOrderButton;

@end
