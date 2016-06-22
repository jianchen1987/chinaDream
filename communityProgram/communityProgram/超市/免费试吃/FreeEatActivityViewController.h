//
//  FreeEatActivityViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/1/31.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
//#import "SupermarketCollectionViewCell.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "FreeEatActivityCollectionViewCell.h"
@interface FreeEatActivityViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *myCollectionView;
    NSMutableArray *dataSource;
    FreeEatActivityCollectionViewCell *cell;

    
}
@end
