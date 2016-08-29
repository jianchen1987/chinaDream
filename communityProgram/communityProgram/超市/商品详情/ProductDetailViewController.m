//
//  ProductDetailViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//
#import "SelectBar.h"
#import "MBProgressHUD.h"
#import "UIView+Getlength.h"
#import "DetermineOrderViewController.h"
static NSString *testIdentifire = @"testIdentifire";
static NSString *moreRecommentIdentifire = @"moreRecommentIdentifire";
static NSString *collectionViewReuseIdentifier = @"UICollectionViewCell";


static NSString *productDetailIdntifire = @"productDetailIdntifire";
static NSString *productCommentIdentifire = @"productCommentIdentifire";
static NSString *recommendIdentifire = @"recommendIdentifire";
#import "UpImageButton.h"
#define commentCell @"commentCell"

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()
{
    NSArray *commentArray;
    NSInteger selectNumber;
    UpImageButton * Collection;
    UpImageButton * share_BT;
    UIButton * shopCar;
    ProductDetailTableViewCell *detailCell;
    NSInteger count;
    
}
@property(nonatomic,strong)NSDictionary *dataDictionary;

@end

@implementation ProductDetailViewController

#pragma mark - Lazy Methods
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - kSTATUSBAR_NAVIGATION_HEIGHT - 45)];
        _scrollView.contentSize = CGSizeMake(DeviceWidth, (DeviceHeight - kSTATUSBAR_NAVIGATION_HEIGHT) * 2);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}
-(UIView *)bottomView
{
    if (!_bottomView)
    {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), DeviceWidth, 45)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        
        Collection=[[UpImageButton alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth/5, 45)];
        Collection.tag=1000;
        [Collection setTitle:@"收藏" forState:UIControlStateNormal];
        [Collection setImage:[UIImage imageNamed:@"商品详情收藏"] forState:UIControlStateNormal];
        [_bottomView addSubview:Collection];
        share_BT.tag=1001;
        share_BT=[[UpImageButton alloc]initWithFrame:CGRectMake( Collection.getW_X+1,0, DeviceWidth/5, 45)];
        [share_BT setTitle:@"分享" forState:UIControlStateNormal];
        [share_BT setImage:[UIImage imageNamed:@"分享-社区首页"] forState:UIControlStateNormal];
        [_bottomView addSubview:share_BT];
        
        shopCar = [UIButton buttonWithType:UIButtonTypeCustom];
        [shopCar setFrame:CGRectMake( share_BT.getW_X+1,0, DeviceWidth*1.5/5, 45)];
        [shopCar setTitle:@"加入购物车" forState:0];
        [shopCar setTitleColor:[UIColor whiteColor] forState:0];
        [_bottomView addSubview:shopCar];
        shopCar.tag=1002;
        shopCar.backgroundColor=RGBA(247, 54, 10, 1);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake( shopCar.getW_X+1,0, DeviceWidth*1.5/5, 45)];
        [btn setTitle:@"立即购买" forState:0];
        btn.backgroundColor=RGBA(247, 84, 33, 1);
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [_bottomView addSubview:btn];
        btn.tag=1003;
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [shopCar addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [share_BT addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [Collection addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _bottomView.backgroundColor=self.view.backgroundColor;
        
        
    }
    return _bottomView;
}
-(void)clickAction:(UIButton*)sender{
    //    self.loopView.
    switch (sender.tag) {
        case 1000://收藏
        {
            [self showLoading];
            [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.identifyName, self.unit.id] WithPath:@"saveProductCollection" successBlock:^(id successJsonData)
             {
                 [self showSuccess:@"已收藏"];
                 NSLog(@"收藏 %@",successJsonData);
             } errorBlock:^(int code, NSString *errorJsonData) {
                 [self showPrompt:errorJsonData];
             }];
        }
            break;
        case 1001://分享
            
            break;
        case 1002://加入购物车
        {
            
            [self showLoading];
            [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.identifyName, @(count),self.unit.id] WithPath:@"addShopCar" successBlock:^(id successJsonData)
             {
                 
                 [self showSuccess:@"购物车"];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"ShoppingcarUpdate" object:@{@"oper":@"1",@"parm":[NSNumber numberWithInteger:1]}];
                 NSLog(@"加入购物车 %@",successJsonData);
             } errorBlock:^(int code, NSString *errorJsonData) {
                 [self showPrompt:errorJsonData];
             }];
        }
            break;
        case 1003://立即购买
        {
            DetermineOrderViewController * deter=[[DetermineOrderViewController alloc]initWithNibName:@"DetermineOrderViewController" bundle:nil];;
            deter.information_Dic=_dataDictionary;
            [self.navigationController pushViewController:deter animated:YES];
        }
            
            //            [self showLoading];
            //
            //            [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.identifyName, @(count),[self.dicData objectForKey:@"id"]] WithPath:@"modifyShopCar" successBlock:^(id successJsonData) {
            //                [self showSuccess:@"购物车"];
            //                NSLog(@"加入购物车 %@",successJsonData);
            //            } errorBlock:^(int code, NSString *errorJsonData) {
            //                [self showPrompt:errorJsonData];
            //
            //            }];
            break;
            
            
            
    }
}
- (UITableView *)tableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:self.scrollView.bounds style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}
#pragma mark - 第二页
- (UIView *)twoPageView {
    if (!_twoPageView) {
        _twoPageView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.tableView.width, self.tableView.height)];
    }
    return _twoPageView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.secondTopView.frame), self.tableView.width, self.tableView.height - self.goodsDetailButton.height)];
    }
    return _webView;
}
-(UIView *)secondTopView
{
    if (!_secondTopView) {
        
        _secondTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
        _secondTopView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, DeviceWidth, 1)];
        lineView.backgroundColor = RGBA(240, 240, 240, 1);
        [_secondTopView addSubview:lineView];
        
        NSArray *titleArr = @[@"图文详情",@"评价晒单",@"美邻推荐"];
        for (int i = 0; i < 3; i++) {
            UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
            secondButton.frame = CGRectMake(DeviceWidth/3*i, 0, DeviceWidth/3, 50);
            [secondButton setTitle:titleArr[i] forState:0];
            [secondButton setTitleColor:[UIColor blackColor] forState:0];
            [secondButton addTarget:self action:@selector(secondButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_secondTopView addSubview:secondButton];
            
        }
    }
    
    
    return _secondTopView;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(DeviceWidth/2 - 5, DeviceWidth/2 - 5);
        layout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.webView.frame collectionViewLayout:layout];
        _collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.secondTopView.frame), self.tableView.width, self.tableView.height - self.secondTopView.height);
        _collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewReuseIdentifier];
    }
    return _collectionView;
}
-(UITableView *)commentTableView
{
    if (!_commentTableView) {
        
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.secondTopView.frame), self.tableView.width, self.tableView.height - self.secondTopView.height) style:UITableViewStyleGrouped];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
    }
    return _commentTableView;
}
#pragma mark 获得详细信息
-(void)loadData
{
    NSArray *array = @[self.unit.id];
    
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:getProductById successBlock:^(id successJsonData) {
        
        self.dataDictionary = successJsonData;
        
        [self.myTableView reloadData];
    } errorBlock:^(int code, NSString *errorJsonData) {
        
    }];
}
-(void)GetComment
{
    /**
     *  用户id
     *  类型的唯一id
     *  pageIndex 当前页码数
     *   pageSize 显示数量
     *
     */
    NSArray * array=@[self.user.identifyName,self.unit.id,@"supermarket",@1,@4];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array  WithPath:getComment successBlock:^(id successJsonData)
     {
         
         NSLog(@"%@",successJsonData);
         for (NSDictionary *dic in successJsonData) {
             CommentModle *modle = [CommentModle new];
             NSDictionary * user=[dic objectForKey:@"user"];
             
             modle.commentHeadImageUrl = [dic valueForKey:@"headIcon"];
             modle.commentName = [user valueForKey:@"nickName"];//名字
             modle.commentTime = [dic valueForKey:@"createTime"];//评论时间
             modle.commentContent = [dic valueForKey:@"commentInfo"];//评论信息
             
             if ([dic valueForKey:@"appendComment"]) {
                 modle.addDic=[NSDictionary dictionaryWithObjectsAndKeys:
                               [user valueForKey:@"nickName"],@"nickName",
                               //                              @"2016-1-13",@"time",
                               [dic valueForKey:@"appendComment"],@"comment", nil];
                 NSLog(@"%@",[dic valueForKey:@"appendComment"]);
             }
             
             //            modle.addDic = [dic valueForKey:@"other"];
             //            modle.picNamesArray =@[@"/resource/admin/quarterLogo/83b6678f-b6cd-479d-94f9-b7a585c5808c.jpg",@"/resource/admin/quarterLogo/83b6678f-b6cd-479d-94f9-b7a585c5808c.jpg"];
             [dic valueForKey:@"commentLogos"];//图片数组
             [commentDataSource addObject:modle];
         }
         [self.myTableView reloadData];
         
     } errorBlock:^(int code, NSString *errorJsonData) {
     }];
}
-(void)TypeRecommendation{
    [self showLoading];
    NSArray * arr=@[self.user.quarter.quarterId?self.user.quarter.quarterId:@"",self.unit.id,@1,@10];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:arr WithPath:getProductByHotOrTuiJian successBlock:^(id successJsonData) {
        NSLog(@"%@",successJsonData);
        [self dismissShow];
    } errorBlock:^(int code, NSString *errorJsonData) {
        [self showPrompt:errorJsonData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    
    count=1;
    [self TypeRecommendation];//
    [self GetComment];//获得所有评论
    [self LoadProductAdv];//获取超市产品广告图
    [self loadData];//获得商品详情
    selectNumber = 0;
    _dataDictionary = [[NSDictionary alloc] init];
    commentDataSource = [[NSMutableArray alloc] init];
    
    // 添加子控件
    [self addSubView];
    
    // 配置上拉和下拉操作
    [self configureRefresh];
    TSEXCARLoopView *loopView = [[TSEXCARLoopView alloc] initWithFrame:CGRectMake(0.0, 0.0, DeviceWidth, DeviceWidth/2)];
    loopView.userInteractionEnabled = YES;
    self.myTableView.tableHeaderView = loopView;
    self.loopView = loopView;
    
    
    ////    虚拟数据
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    NSArray *image1Arr = @[@"img"];
    //    NSArray *image2Arr = @[@"img",@"img"];
    //    NSArray *image3Arr = @[@"img",@"img",@"img",@"img",@"img"];
    //    NSArray *image4Arr = @[];
    //    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
    //                         @"",@"image",
    //                         image4Arr,@"imageArr",
    //                         @"小明",@"name",
    //                         @"2016-1-13",@"time",
    //                         @"不负家人众望，实至名归，",@"comment", nil];
    //    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"image",image1Arr,@"imageArr",@"小明",@"name",@"2016-1-13",@"time",@"不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手",@"comment", nil];
    //
    //    NSDictionary *secondDic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"image",
    //                               image2Arr,@"imageArr",
    //                               @"小明",@"name",
    //                               @"2016-1-13",@"time",
    //                               @"不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家望，实至名归，苹果香，脆，甜，喜欢的赶紧下手",@"comment",
    //                               [NSDictionary dictionaryWithObjectsAndKeys:
    //                                @"",@"image",
    //                                @"小明",@"name",
    //                                @"2016-1-13",@"time",
    //                                @"不负脆，甜，喜欢的赶紧下手",@"comment", nil],@"other", nil];
    //
    //    [muArray addObject:dic];
    //    [muArray addObject:dic1];
    //    [muArray addObject:secondDic];
    //
    //
    //
    //    for (NSDictionary *dic in muArray) {
    //        CommentModle *modle = [CommentModle new];
    //        modle.commentHeadImageUrl = [dic valueForKey:@"image"];
    //        modle.commentName = [dic valueForKey:@"name"];
    //        modle.commentTime = [dic valueForKey:@"time"];
    //        modle.commentContent = [dic valueForKey:@"comment"];
    //        modle.addDic = [dic valueForKey:@"other"];
    //        modle.picNamesArray = [dic valueForKey:@"imageArr"];
    //        [commentDataSource addObject:modle];
    //    }
}

#pragma mark - View lifeCycle
- (void)addSubView {
    [self.view    addSubview:self.scrollView];
    [self.view    addSubview:self.bottomView];
    [self.scrollView  addSubview:self.tableView];
    [self.scrollView  addSubview:self.twoPageView];
    [self.twoPageView addSubview:self.webView];
    [self.twoPageView addSubview:self.secondTopView];
}

- (void)configureRefresh {
    // 动画时间
    CGFloat duration = 0.3f;
    
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.height);
        } completion:^(BOOL finished) {
            [self.tableView.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor = self.tableView.backgroundColor;
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStateRefreshing];
    self.tableView.footer = footer;
    
    
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            //结束加载
            [self.webView.scrollView.header endRefreshing];
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor redColor];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    self.webView.scrollView.header = header;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    
    // 3.设置 UICollectionView 下拉显示商品详情
    MJRefreshGifHeader *cHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self.collectionView.header endRefreshing];
        }];
    }];
    cHeader.lastUpdatedTimeLabel.hidden = YES;
    [cHeader setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [cHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [cHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    header.stateLabel.textColor = [UIColor redColor];
    self.collectionView.header = cHeader;
    
    // 3.设置 UICollectionView 下拉显示商品详情
    MJRefreshGifHeader *dHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self.commentTableView.header endRefreshing];
        }];
    }];
    cHeader.lastUpdatedTimeLabel.hidden = YES;
    [cHeader setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [cHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [cHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    header.stateLabel.textColor = [UIColor redColor];
    self.commentTableView.header = dHeader;
    
    __weak __typeof(self) weakSelf = self;
    
    self.commentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadMoreData];
        
    }];
}
#pragma mark ------------------加载更多评论
-(void)loadMoreData
{
    [self.commentTableView.footer endRefreshing];
}
#pragma mark ------------------获取超市产品广告图
-(void)LoadProductAdv
{
    NSArray *paramArray = @[self.unit.id];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:paramArray WithPath:GetLogoByProductIdPath successBlock:^(id successJsonData) {
        
        NSLog(@"successJsonData = %@",successJsonData);
        NSMutableArray *imageArray = [NSMutableArray array];
        
        if (successJsonData) {
            for (NSDictionary *dic in successJsonData) {
                [imageArray addObject:[AppendingImageUrl stringByAppendingString:[dic valueForKey:@"imageLogo"]]];
            }
            // 异步下载图片
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                self.imgsArr = [NSMutableArray array];
                for (NSString *str in imageArray) {
                    NSURL *imageUrl = [NSURL URLWithString:str];
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
                    
                    if (!image) {
                        UIImage *newsImage = [UIImage imageNamed:@"banner"];
                        [self.imgsArr addObject:newsImage];
                    }else
                    {
                        [self.imgsArr addObject:image];
                    }
                }
                // 当图片下载完成后，在主线程设置tableHeaderView的数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loopView setLoopViewImages:self.imgsArr autoPlay:YES delay:3.0];
                });
            });
        }
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.myTableView) {
        return 3;
    }else
    {
        return 1;
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.myTableView) {
        if (section == 0) {
            return 1;
        }else if(section == 1)
            return commentDataSource.count;
        else if(section == 2)
            return 4;
        else
            return 1;
    }else
    {
        return commentDataSource.count;
    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.myTableView) {
        //第一部分
        detailCell = [tableView dequeueReusableCellWithIdentifier:productDetailIdntifire];
        //评论部分
        if (indexPath.section == 0) {
            if (!detailCell) {
                detailCell = [[ProductDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productDetailIdntifire];
            }
            [detailCell loadCellData:self.dataDictionary];
            detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
            detailCell.numberChange=^(NSInteger number){
                NSLog(@"number===%ld",(long)number);
                count=number;
            };
            return detailCell;
        }else if(indexPath.section == 1)
        {
            ProductCommendTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:testIdentifire];
            if (!secondCell) {
                secondCell = [[ProductCommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testIdentifire];
            }
            secondCell.model = commentDataSource[indexPath.row];
            secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return secondCell;
            
        }else if(indexPath.section == 2)
        {
            MoreProductTableViewCell *moreProductCell = [tableView dequeueReusableCellWithIdentifier:moreRecommentIdentifire];
            if (!moreProductCell) {
                moreProductCell = [[MoreProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreRecommentIdentifire];
            }
            moreProductCell.model = nil;
            moreProductCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return moreProductCell;
        }else
        {
            return nil;
        }
    }else
    {
        ProductCommendTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:testIdentifire];
        if (!secondCell) {
            secondCell = [[ProductCommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:testIdentifire];
        }
        secondCell.model = commentDataSource[indexPath.row];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.myTableView) {
        NSArray *titleArray = @[@"查看全部评论",@"查看更多产品推荐"];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
        backView.backgroundColor = [UIColor whiteColor];
        if (section == 1 || section == 2){
            
            UILabel *leftTitleLable = [RHMethods labelWithFrame:CGRectMake(10, 0, DeviceWidth-100, 40) font:Font(16) color:RGBA(153, 153, 153, 1) text:titleArray[section-1]];
            [backView addSubview:leftTitleLable];
            
            
            UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(DeviceWidth-60, 0, 40, 30)];
            rightImageView.image = [UIImage imageNamed:@""];
            
            [backView addSubview:rightImageView];
        }
        
        return backView;
    }else
    {
        return nil;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }else
        
        return 40;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.myTableView) {
        return 10;
        
    }else
    {
        return 0.01;
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myTableView) {
        if (indexPath.section == 0)
        {
            ProductDetailTableViewCell *cell = (ProductDetailTableViewCell *)[self tableView:self.myTableView cellForRowAtIndexPath:indexPath];
            return cell.height;
        }else if(indexPath.section == 1)
        {
            id model = commentDataSource[indexPath.row];
            return [self.myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProductCommendTableViewCell class] contentViewWidth:DeviceWidth-40];
        }else
        {
            id model = nil;
            return [self.myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[MoreProductTableViewCell class] contentViewWidth:DeviceWidth-40];
        }
        
    }else
    {
        id model = commentDataSource[indexPath.row];
        return [self.myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProductCommendTableViewCell class] contentViewWidth:DeviceWidth-40];
    }
}


#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewReuseIdentifier forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img"]];
    return cell;
}

#pragma mark - Action methods
- (void)goodsDetailButtonClick {
    self.webView.hidden = NO;
    self.collectionView.hidden = YES;
    [self.twoPageView addSubview:self.webView];
}

- (void)commentButtonClick {
    self.webView.hidden = YES;
    self.collectionView.hidden = NO;
    [self.twoPageView addSubview:self.collectionView];
}
#pragma mark -----------secondButtonAction
-(void)secondButtonAction:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"图文详情"]) {
        self.webView.hidden = NO;
        self.collectionView.hidden = YES;
        self.commentTableView.hidden = YES;
        [self.twoPageView addSubview:self.webView];
    }else if ([sender.titleLabel.text isEqualToString:@"评价晒单"])
    {
        self.webView.hidden = YES;
        self.collectionView.hidden = YES;
        self.commentTableView.hidden = NO;
        [self.twoPageView addSubview:self.commentTableView];
    }else
    {
        
        self.webView.hidden = YES;
        self.commentTableView.hidden = YES;
        self.collectionView.hidden = NO;
        [self.twoPageView addSubview:self.collectionView];
        
    }
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}



@end
