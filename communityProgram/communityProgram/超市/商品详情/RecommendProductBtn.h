//
//  RecommendProductBtn.h
//  communityProgram
//
//  Created by xiaogao on 16/1/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendProductBtn : UIButton
@property(nonatomic,strong)UIImageView *superHeadImageView;//图片
@property(nonatomic,strong)UILabel *superTitleLable;
@property(nonatomic,strong)UILabel *superPriceLable;
@property(nonatomic,strong)UILabel *superDiscountLable;
@property(nonatomic,strong)UILabel *superDateLable;

-(id)initWithFrame:(CGRect)frame WithDic:(NSDictionary *)dic;

@end
