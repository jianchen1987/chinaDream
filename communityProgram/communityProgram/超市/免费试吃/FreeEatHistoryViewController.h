//
//  FreeEatHistoryViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/1/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "FreeEatHistoryCollectionViewCell.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"


@interface FreeEatHistoryViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *myCollectionView;
    NSMutableArray *dataSource;
    FreeEatHistoryCollectionViewCell *cell;
}
@end
