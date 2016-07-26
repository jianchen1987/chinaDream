//
//  MyintegralViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/16.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "MyintegralViewController.h"

@interface MyintegralViewController ()

@end

@implementation MyintegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupScrollView];
    [self setupViewControllers];

}
/** 设置scrollView */
- (void)setupScrollView
{
    if (self.navigationController != nil && ![self.navigationController isNavigationBarHidden]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UIView *headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
    headBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headBackView];
    
    
    segment = [[UISegmentedControl alloc] initWithItems:@[@"积分历史",@"兑换记录"]];
    segment.frame = CGRectMake(20, 10, DeviceWidth - 40, 30);
    [segment setTintColor:RGBA(68, 180, 17, 1)];
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_]} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_]} forState:UIControlStateSelected];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentSelectAction:) forControlEvents:UIControlEventValueChanged];
    [headBackView addSubview:segment];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, headBackView.frame.origin.y+headBackView.frame.size.height, DeviceWidth, DeviceHeight - kSTATUSBAR_NAVIGATION_HEIGHT - kTABBAR_HEIGHT - 50)];
    scrollView.contentSize = CGSizeMake(DeviceWidth * self.viewControllers.count, DeviceHeight - kSTATUSBAR_NAVIGATION_HEIGHT - kTABBAR_HEIGHT - 50);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate      = self;
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
 
}

/** 设置子视图控制器，这个方法必须在viewDidLoad方法里执行，否则子视图控制器各项属性为空 */
- (void)setupViewControllers
{
    int cnt = (int)self.viewControllers.count;
    for (int i = 0; i < cnt; i++) {
        UIViewController *vc = self.viewControllers[i];
        [self addChildViewController:vc];
        
        vc.view.frame = CGRectMake(DeviceWidth * i, 0, DeviceWidth, DeviceHeight - kSTATUSBAR_NAVIGATION_HEIGHT - 50 - kTABBAR_HEIGHT);
        [self.scrollView addSubview:vc.view];
    }
}


#pragma mark ------------------segmentSelect
-(void)segmentSelectAction:(UISegmentedControl *)segmentControll
{
    CGPoint offset = CGPointMake(DeviceWidth * segmentControll.selectedSegmentIndex, 0);
//    [self.scrollView setContentOffset:offset animated:YES];
    [self.scrollView setContentOffset:offset];
    
    
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / DeviceWidth;
    [segment setSelectedSegmentIndex:index];
}


@end
