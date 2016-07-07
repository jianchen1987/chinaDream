//
//  ProductDetailViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "ProductDetailTableViewCell.h"
#import "BaseTableViewCell.h"
#import "TSEXCARLoopView.h"
#import "ProductCommendTableViewCell.h"
#import "RecommendProductBtn.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "MoreProductTableViewCell.h"
#import "MJRefresh.h"
#import "CustomBottomViewBtn.h"
#import "ProductModel.h"
@interface ProductDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>
{
//    UITableView *myTableView;
    NSMutableArray *dataSource;
    NSMutableArray *commentDataSource;
    
    UIView *bottomView;
    
}
@property (nonatomic, weak) TSEXCARLoopView *loopView;
@property (nonatomic, strong) NSMutableArray *imgsArr;
//@property(nonatomic,copy)NSDictionary *dicData;
@property(nonatomic,strong)ProductModel * unit;


/** 商品详情整体 */
@property(strong,nonatomic)UIScrollView *scrollView;

/** 第一页 */
@property(strong,nonatomic)UITableView *myTableView;

/** 第二页 */
@property (nonatomic, strong) UIView *twoPageView;
/** 网页 */
@property (strong,nonatomic)  UIWebView *webView;

/***评论table***/
@property (strong,nonatomic)  UITableView *commentTableView;

/** 推荐商品视图 */
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *goodsDetailButton;
@property (nonatomic, strong) UIButton *commentButton;
//@property (nonatomic, strong) UIButton *toolButton;
@property (nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UIView *secondTopView;

@end
