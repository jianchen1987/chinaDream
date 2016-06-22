//
//  MoreTogetherDetailTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/3/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddNumberView.h"
#import "AdditionSubtractionControl.h"
@interface MoreTogetherDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *detailLable;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UILabel *discountLable;
@property(nonatomic,strong)UIView *firstLineView;
@property(nonatomic,strong)UIButton *firstButton;
@property(nonatomic,strong)UIButton *targetButton;
@property(nonatomic,strong)AdditionSubtractionControl * AdditionSubtractionView;


@end
