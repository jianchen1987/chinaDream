//
//  MycollectionTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MycollectionTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UILabel *productLable;
@property(nonatomic,strong)UILabel *descriptionLable;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UIButton *businessButton;

@end
