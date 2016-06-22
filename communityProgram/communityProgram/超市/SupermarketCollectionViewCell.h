//
//  SupermarketCollectionViewCell.h
//  communityProgram
//
//  Created by xiaogao on 15/12/13.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface SupermarketCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *superHeadImageView;//图片
@property(nonatomic,strong)UILabel *superTitleLable;
@property(nonatomic,strong)UILabel *superPriceLable;
@property(nonatomic,strong)UILabel *superDiscountLable;
@property(nonatomic,strong)UILabel *superDateLable;

-(void)loadCellData:(NSDictionary *)dicData;
@end
