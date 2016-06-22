//
//  SuperMarketViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "SupermarketCollectionViewCell.h"
#import "MJRefreshNormalHeader.h"
#import "MJRefreshAutoNormalFooter.h"
#import "TSEXCARLoopView.h"
#import "MoreTogetherViewController.h"
#import "PurchaseViewController.h"
#import "SupermarketHeadCollectionViewCell.h"
#import "SupermaketButtonCollectionViewCell.h"
#import "ProductDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NirKxMenu.h"
#import "WMPageController.h"
#import "AllCagroryViewController.h"

#import "FreeEatActivityViewController.h"
#import "FreeEatHistoryViewController.h"

@interface SuperMarketViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,TSEXCARLoopViewDelegate>
{
    UICollectionView *myCollectionView;
    
    NSMutableArray *dataSource;
    UICollectionViewCell *headView;
    
    SupermarketHeadCollectionViewCell *sectionHeadView;

    
    UICollectionViewCell *footView;
    SupermarketCollectionViewCell *cell;
    SupermaketButtonCollectionViewCell *buttonCell;
    UIView *tempView;
    
}

@property (nonatomic, weak) TSEXCARLoopView *loopView;
@property (nonatomic, strong) NSMutableArray *imgsArr;
@end
