//
//  IntegralMallViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "IntegralMallViewController.h"
#import "UIImageView+WebCache.h"
#import "NirKxMenu.h"
#import "myLoopView.h"


@interface IntegralMallViewController ()
{
    myLoopView *_advertiseView;
    NSMutableArray *_advertiseImgViews;
}

@end

@implementation IntegralMallViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"积分商城";
    
    _advertiseView = [[myLoopView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 150)];
    _advertiseImgViews = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < 5; i++)
    {
        NSString *imageUrl = @"http://d02.res.meilishuo.net/pic/_o/e4/d9/d34baa117aa1abb17822337b7bf6_800_800.ch.jpeg";
        [_advertiseImgViews addObject:imageUrl];
    }
    
    [self.collectionView registerClass:[integralMailCollectionViewCell class] forCellWithReuseIdentifier:@"integraMailCollectionCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"advertise"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"category"];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn setImage:[UIImage imageNamed:@"barItemMore"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickOnRightBarItem:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBaritem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBaritem;
    
}

- (void)pullDown:(id)sender
{
    [self.dataSource addObjectsFromArray:@[@"1",@"1",@"1",@"1",@"1"]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.header endRefreshing];
        [self.collectionView reloadData];
        [self.collectionView reloadEmptyDataSet];
    });
}


- (void)clickOnRightBarItem:(UIButton *)sender
{
    
    if(!sender.isSelected)
    {
        sender.selected = YES;
        [self showMenu];
    }
    else
    {
        sender.selected = NO;
        [KxMenu dismissMenu];
    }
}

- (void)showMenu
{
    KxMenuItem *item1 = [KxMenuItem menuItem:@"兑换记录" image:[UIImage imageNamed:@"exchangeLog"] target:self action:@selector(showExchangeLog:)];
    KxMenuItem *item2 = [KxMenuItem menuItem:@"积分规则" image:[UIImage imageNamed:@"integralRule"] target:self action:@selector(showIntegralRule:)];
    OptionalConfiguration optional;
    optional.arrowSize = 9;
    optional.marginXSpacing = 7;
    optional.marginYSpacing = 9;
    optional.intervalSpacing = 25;
    optional.menuCornerRadius = 6.5;
    optional.maskToBackground = YES;
    optional.shadowOfMenu = NO;
    optional.hasSeperatorLine = YES;
    optional.seperatorLineHasInsets = NO;
    optional.textColor = MakeColor(0, 0, 0);
    optional.menuBackgroundColor = MakeColor(1, 1, 1);
    [KxMenu setTitleFont:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_]];
    [KxMenu setTintColor:[UIColor whiteColor]];
    [KxMenu showMenuInView:self.view.window fromRect:CGRectMake(DeviceWidth - 60, 35, 60, 30) menuItems:@[item1,item2] withOptions:optional];
    
}

- (void)showExchangeLog:(id)sender
{
    
}

- (void)showIntegralRule:(id)sender
{
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 2)
    {
        return self.dataSource.count;
    }
    else
    {
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return CGSizeMake(DeviceWidth, 0);
    }
    else if(section == 1)
    {
        return CGSizeMake(DeviceWidth, 10);
    }
    else
    {
        return CGSizeMake(DeviceWidth, 5);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        return CGSizeMake((DeviceWidth - 3)/2, (DeviceWidth - 3)/2 + 120);
    }
    else if(indexPath.section == 0)
    {
        //广告
        return CGSizeMake(DeviceWidth, 150);
    }
    else
    {
        //筛选
        return CGSizeMake(DeviceWidth, 40);
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 3.0f;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        static NSString *advertise = @"advertise";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:advertise forIndexPath:indexPath];
        [_advertiseView setLoopViewImageUrls:_advertiseImgViews autoPlay:YES delay:3];
        [cell.contentView addSubview:_advertiseView];
        return cell;
    }
    else if(indexPath.section == 1)
    {
        static NSString *category = @"category";
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:category forIndexPath:indexPath];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
        view.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:view];
        return cell;
    }
    else
    {
        static NSString *identify = @"integraMailCollectionCell";
        integralMailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        
        [cell.previewImgView sd_setImageWithURL:[NSURL URLWithString:@"http://d02.res.meilishuo.net/pic/_o/e4/d9/d34baa117aa1abb17822337b7bf6_800_800.ch.jpeg"] placeholderImage:[UIImage imageNamed:@"myself_collection"]];
        //[cell.coverImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
        cell.titleLabel.text        = @"LYCRA莱卡宽松纯色长袖卫衣";
        cell.exchangeTypeLabel.text = @"可积分+金额";
        cell.priceLabel.text        = @"5000积分";
        cell.peopleCntLabel.text    = @"已兑换11";
        return cell;
    }
}


@end
