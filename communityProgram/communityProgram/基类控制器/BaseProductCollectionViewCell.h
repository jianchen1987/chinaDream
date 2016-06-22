//
//  BaseProductCollectionViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/1/23.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseProductCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *productHeadImageView;//产品图片
@property(nonatomic,strong)UILabel *productNameLable;  //产品名称
@property(nonatomic,strong)UILabel *productPriceLable;  //产品价格
@property(nonatomic,strong)UILabel *productDiscountPriceLable;  //产品折扣价
@property(nonatomic,strong)UILabel *productBuyNumber;  //产品购买数量

-(void)loadCellData:(NSDictionary *)dicData;



@end
