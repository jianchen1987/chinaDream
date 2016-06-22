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
    segment.frame = CGRectMake(DeviceWidth/2-100, 10, 200, 30);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentSelectAction:) forControlEvents:UIControlEventValueChanged];
    [headBackView addSubview:segment];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, headBackView.frame.origin.y+headBackView.frame.size.height, DeviceWidth, DeviceHeight)];
    scrollView.contentSize = CGSizeMake(DeviceWidth * self.viewControllers.count, DeviceHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate      = self;
    scrollView.scrollEnabled = NO;
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
        
        vc.view.frame = CGRectMake(DeviceWidth * i, 0, DeviceWidth, DeviceHeight);
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
// 这个方法是手动托动滚动视图停止后才会调用，在外部通过setContentOffset改变的不会调用
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    NSInteger index = scrollView.contentOffset.x / DeviceWidth;
//    [segmentController setSelectedSegmentIndex:index];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
