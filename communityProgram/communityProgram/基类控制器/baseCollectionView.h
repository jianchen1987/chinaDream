//
//  baseCollectionView.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"

@interface baseCollectionView : BaseViewController<UICollectionViewDelegate, UICollectionViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong, nullable) UICollectionView *collectionView;
@property (nonatomic, strong, nullable) NSMutableArray *dataSource;

//- (nullable instancetype)init;
//
//- (nullable instancetype)initWithStyle:(UITableViewStyle)style;

@end
