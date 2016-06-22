//
//  FreeEatHistoryCollectionViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/3/12.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeEatHistoryCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UILabel *periodTime;//有效期
@property(nonatomic,strong)UILabel *productTitleLable;
@property(nonatomic,strong)UILabel *shareNumberLable;
@property(nonatomic,strong)UILabel *dateLable;//时间
@property(nonatomic,strong)UIButton *applyButton;

-(void)loadCellData:(NSDictionary *)dicData;

@end
