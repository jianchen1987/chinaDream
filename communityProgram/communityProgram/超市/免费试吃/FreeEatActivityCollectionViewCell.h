//
//  FreeEatActivityCollectionViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/1/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface FreeEatActivityCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UILabel *periodTime;//有效期
@property(nonatomic,strong)UILabel *productTitleLable;
@property(nonatomic,strong)UILabel *shareNumberLable;
@property(nonatomic,strong)UILabel *dateLable;//时间
@property(nonatomic,strong)UIButton *applyButton;
@property(nonatomic,strong)UILabel *applyNumberLable;//申请人数

-(void)loadCellData:(NSDictionary *)dicData;

@end
