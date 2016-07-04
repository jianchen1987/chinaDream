//
//  MoreTogetherTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/3/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDProgressView.h"
#import "ProgressView.h"

@interface MoreTogetherTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UILabel *descriptionLable;
@property(nonatomic,strong)UILabel *persentLable;
@property(nonatomic,strong)UILabel *timeLimitLable;
@property(nonatomic,strong)UIImageView * endImageView;
@property(nonatomic,strong)ProgressView *progressView;
-(void)setCellData;

@end
