//
//  SuperMarketViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//
static NSString *headCellIdentifire = @"headCellIdentifire";
static NSString *footCellIdentifire = @"footCellIdentifire";
static NSString *sectionHeadCellIdentifire = @"sectionHeadCellIdentifire";
static NSString *SectionCellIdentifire = @"sectionCellIdentifire";
static NSString *buttonCellIdentifire = @"buttonCellIdentifire";
#import "ShakeShakeViewController.h"
#import "AdvertisementUnit.h"
#import "SuperMarketViewController.h"
#import "MeButton.h"
#import "FreeSamplesViewController.h"
#import "Masonry.h"
@interface SuperMarketViewController ()
{
    NSMutableArray *tuijianArray;
    UIButton *rightSelectBtn;
    
    
    NSMutableArray *firstArray;
    NSMutableArray *secondArray;
    TSEXCARLoopView *loopView;
}

@property(nonatomic,strong)NSMutableArray * Advertisement;//所有广告

@end

@implementation SuperMarketViewController

-(NSMutableArray *)Advertisement{
    if (!_Advertisement) {
        _Advertisement=[NSMutableArray array];
    }
    return _Advertisement;
}
#pragma mark ------------------获取广告图
-(void)LoadAdvertise
{
    NSArray *paramsArray = @[@"supermarket"];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:paramsArray WithPath:GetAllChipLogoPath successBlock:^(id successJsonData) {
        
        NSLog(@"successJsonData = %@",successJsonData);
        NSMutableArray *imageArray = [NSMutableArray array];
        
        if (successJsonData) {
            for (NSDictionary *dic in successJsonData) {
                [imageArray addObject:[AppendingImageUrl stringByAppendingString:[dic valueForKey:@"imageLogo"]]];
                AdvertisementUnit * unit =[AdvertisementUnit new];
                unit.id=[dic objectForKey:@"id"];
                
            }
            NSLog(@"imageArray = %@",imageArray);
#warning 用sdWebView啊啊啊啊啊啊啊啊啊啊啊啊 傻鸟
            // 异步下载图片
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                self.imgsArr = [NSMutableArray array];
                for (NSString *str in imageArray) {
                    NSURL *imageUrl = [NSURL URLWithString:str];
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
                    
                    if (!image) {
                        UIImage *newsImage = [UIImage imageNamed:@"专题"];
                        [self.imgsArr addObject:newsImage];
                    }else
                    {
                        [self.imgsArr addObject:image];
                    }
                }
                // 当图片下载完成后，在主线程设置tableHeaderView的数据
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.loopView setLoopViewImages:self.imgsArr autoPlay:YES delay:3.0];
                    [myCollectionView.header endRefreshing];
                    
                });
            });
        }
        
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"超市";
    dataSource = [[NSMutableArray alloc] init];
    tuijianArray = [[NSMutableArray alloc] init];
    firstArray = [[NSMutableArray alloc] init];
    secondArray = [[NSMutableArray alloc] init];
    
    MeButton * bar=[[MeButton alloc]initWithFrame:CGRectMake(5, 5, DeviceWidth-10, 35)];
    [bar setTitle:@"请输入商品名称或种类" forState:UIControlStateNormal];
    [bar setImage:[UIImage imageNamed:@"一级搜索图标"] forState:UIControlStateNormal];
    bar.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.titleView=bar;
    [self loadProductType]; // 获取超市推荐和热门

   [self LoadAdvertise];//获得广告
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-49) collectionViewLayout:layout];
    myCollectionView.alwaysBounceVertical = YES;
    myCollectionView.backgroundColor = [UIColor whiteColor];
    myCollectionView.showsVerticalScrollIndicator = NO;
 
    
    [myCollectionView registerClass:[SupermarketCollectionViewCell class] forCellWithReuseIdentifier:SectionCellIdentifire];
    
    [myCollectionView registerClass:[SupermaketButtonCollectionViewCell class] forCellWithReuseIdentifier:buttonCellIdentifire];
    
    [myCollectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headCellIdentifire];
    
    [myCollectionView registerClass:[SupermarketHeadCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionHeadCellIdentifire];
    
    [myCollectionView registerClass:[UICollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footCellIdentifire];
    myCollectionView.backgroundColor=RGBA(231, 231, 231, 1);
    
    myCollectionView.dataSource = self;
    myCollectionView.delegate = self;
    [self.view addSubview:myCollectionView];
    
    
    __weak __typeof(self) weakSelf = self;
   
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    myCollectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf LoadAdvertise];//获取广告图
    }];
    // 马上进入刷新状态
    [myCollectionView.header beginRefreshing];

    
}
#pragma mark --------------------获取热门和推荐产品
-(void)loadProductType
{
    NSArray *parmas3 = @[@"",self.user.identifyName,@1,@4];
    [self showLoading];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:parmas3 WithPath:GetProductByHotOrTuiJian successBlock:^(id successJsonData) {
        if (successJsonData) {
            [self dismissShow];
            if ([successJsonData valueForKey:@"hot"]) {
                
                for (NSDictionary *dic in [successJsonData valueForKey:@"hot"]) {
                    [firstArray addObject:dic];
                }
            }
            
            if ([successJsonData valueForKey:@"tuijian"]) {
                
                for (NSDictionary *dic in [successJsonData valueForKey:@"tuijian"]) {
                    [secondArray addObject:dic];
                }

            }
        }
        
        [myCollectionView reloadData];
    } errorBlock:^(int code, NSString *errorJsonData) {
         [self dismissShow];
    }];
}

#pragma mark ----------collectionDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else if(section == 1)
    {
        return firstArray.count;
    }else
    {
        return secondArray.count;
    }
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionImageArray = @[@"supermarket_raise",@"supermarket_coupon",@"supermaket_free_eat",@"supermarket_red_envelope",@"supermarket_coupon"];
    if (indexPath.section == 0) {
        buttonCell = [collectionView dequeueReusableCellWithReuseIdentifier:buttonCellIdentifire forIndexPath:indexPath];
        NSArray *titleArray = @[@"美邻众筹",@"领优惠券",@"免费试吃",@"摇摇红包",@"所有分类"];
        buttonCell.headImageView.image =  [UIImage imageNamed:sectionImageArray[indexPath.row]];
        buttonCell.titleLable.text = [titleArray objectAtIndex:indexPath.row];
        buttonCell.titleLable.font=[UIFont systemFontOfSize:12];
    
        return buttonCell;
    }else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:SectionCellIdentifire forIndexPath:indexPath];
        
        if (indexPath.section == 1) {
            NSDictionary *dic = firstArray[indexPath.row];
            
            [cell loadCellData:dic];

        }else
        {
            NSDictionary *dic = secondArray[indexPath.row];
            [cell loadCellData:dic];

        }

        cell.contentView.backgroundColor=[UIColor whiteColor];
        return cell;
    }

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake((DeviceWidth-60)/5, 70);
    }else
    {
        if(DeviceHeight > 568)
        {
            return CGSizeMake((DeviceWidth-30)/2, DeviceWidth/2*1.3);
        }else{
            
            return CGSizeMake((DeviceWidth-20)/2, DeviceWidth/2*1.3);
        }
    }

    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(DeviceHeight > 568)
    {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }else{
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }

}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headCellIdentifire forIndexPath:indexPath];
            if (!loopView) {
                loopView = [[TSEXCARLoopView alloc] initWithFrame:CGRectMake(0.0, 0.0, DeviceWidth, DeviceWidth/2)];
                loopView.delegate = self;
                loopView.userInteractionEnabled = YES;
                self.loopView = loopView;
                [headView addSubview:loopView];
            }
            return headView;
        }else
        {
            NSArray *recommendArr = @[@"美邻推荐",@"商品推荐"];
            sectionHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionHeadCellIdentifire forIndexPath:indexPath];
            sectionHeadView.backgroundColor = [UIColor whiteColor];
            sectionHeadView.recommendLable.text = recommendArr[indexPath.section-1];
            
            [sectionHeadView.rightButton setImage:[UIImage imageNamed:@"更多小箭头"] forState:UIControlStateNormal ];
            sectionHeadView.rightButton.tag = indexPath.section;
            [sectionHeadView.rightButton addTarget:self action:@selector(clickMore:) forControlEvents:UIControlEventTouchUpInside];
            return sectionHeadView;
        }
        
    }else if(kind == UICollectionElementKindSectionFooter)
    {
        footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footCellIdentifire forIndexPath:indexPath];
        footView.backgroundColor = RGBA(240, 240, 240, 1);
        return footView;
        return nil;

    }else
    {
        return nil;
    }
}
/*********************** 控制头和尾巴 ***********************/

/**
 *  这个是头的距离（如果想隐藏就改成（0，0））
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(0, DeviceWidth/2);
    }else
    {
        collectionView.backgroundColor=[UIColor whiteColor];
        return CGSizeMake(0, 40);
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(0, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        SupermaketButtonCollectionViewCell *buttonCell1 = (SupermaketButtonCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if ([buttonCell1.titleLable.text isEqualToString:@"美邻众筹"]) {
            NSLog(@"美邻众筹");
            MoreTogetherViewController *moreTogetherVC = [MoreTogetherViewController new];
            moreTogetherVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:moreTogetherVC animated:YES];
        }else if([buttonCell1.titleLable.text isEqualToString:@"领优惠券"])
        {
            NSLog(@"领优惠券");
            PurchaseViewController *purchaseVC = [PurchaseViewController new];
            purchaseVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:purchaseVC animated:YES];
            
        }else if([buttonCell1.titleLable.text isEqualToString:@"免费试吃"])
        {
            NSLog(@"免费试吃");
            
            
//            NSArray *viewControllers = [NSArray arrayWithObjects:[FreeEatActivityViewController class],[FreeEatHistoryViewController class], nil];
//            NSArray *titles = [NSArray arrayWithObjects:@"最新活动",@"试吃历史", nil];
//            WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles WithShowMenu:NO];
//            pageVC.hidesBottomBarWhenPushed = YES;
//            pageVC.pageAnimatable = YES;
//            pageVC.menuItemWidth = DeviceWidth/2;
//            pageVC.menuHeight = 42;
//            pageVC.postNotification = YES;
//            pageVC.bounces = YES;
//            pageVC.title = @"免费试吃";
//            pageVC.menuBGColor = [UIColor whiteColor];//bar背景颜色
//            pageVC.menuViewStyle = WMMenuViewStyleLine;
//            pageVC.titleSizeSelected = 15;
//
            FreeSamplesViewController * vc=[FreeSamplesViewController new];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];

//            [self.navigationController pushViewController:pageVC animated:YES];
            
            
        }else if([buttonCell1.titleLable.text isEqualToString:@"摇摇红包"])
        {
            ShakeShakeViewController * shake=[[ShakeShakeViewController alloc]init];
            shake.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shake animated:YES];
            NSLog(@"摇摇红包");
            
        }else
        {
            //所有分类
            AllCagroryViewController *allCagroryVC = [AllCagroryViewController new];
            allCagroryVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:allCagroryVC animated:YES];
        }
    }else
    {
        if (indexPath.section == 1) {
            ProductModel * unit= firstArray[indexPath.row];
            ProductDetailViewController *productDetailVC = [ProductDetailViewController new];
            productDetailVC.hidesBottomBarWhenPushed = YES;
            productDetailVC.unit = unit;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }else
        {
            ProductModel * unit = secondArray[indexPath.row];
            ProductDetailViewController *productDetailVC = [ProductDetailViewController new];
            productDetailVC.hidesBottomBarWhenPushed = YES;
            productDetailVC.unit = unit;
            [self.navigationController pushViewController:productDetailVC animated:YES];
        }
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)clickMore:(UIButton *)sender
{
    NSLog(@"sender.tag = %ld",(long)sender.tag);
}


@end
