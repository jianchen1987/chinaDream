//
//  integralMailCollectionViewCell.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myLabel.h"

@interface integralMailCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *previewImgView;
@property (nonatomic, strong) UIImageView *coverImgView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) myLabel *exchangeTypeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *peopleCntLabel;

@end
