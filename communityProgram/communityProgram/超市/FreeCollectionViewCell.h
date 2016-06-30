//
//  CustomCollectionViewCell.h
//  UIcollectionView
//
//  Created by 谢泽锋 on 16/6/24.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ApplyAction)();
@interface FreeCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel * time_LB;
@property(nonatomic,strong)UIImageView * FreeImage;
@property(nonatomic,strong)UILabel * numberCount;
@property(nonatomic,strong)UILabel * applyCount;
@property(nonatomic,strong)UILabel * title_LB;
@property(nonatomic,strong)UIImageView *  isEndView;
@property(nonatomic,assign)BOOL  isEnd;
@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong) UILabel * detail;
@property(nonatomic,strong)NSString * expireDate;
@property(nonatomic,copy)ApplyAction applyAction;
@end
