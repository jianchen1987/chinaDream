//
//  MessageViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/19.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
{
    UISegmentedControl *segmentController;
    
}
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupScrollView];
    [self setupViewControllers];
    [self setupSegmentControl];
}
/** 设置scrollView */
- (void)setupScrollView
{
    if (self.navigationController != nil && ![self.navigationController isNavigationBarHidden]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0, DeviceWidth, DeviceHeight)];
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
/** 设置segment */
- (void)setupSegmentControl
{
    segmentController = [[UISegmentedControl alloc] initWithItems:@[@"动态",@"私信",@"通知"]];
    segmentController.frame = CGRectMake(0, 0, 200, 30);
    segmentController.selectedSegmentIndex = 0;
    [segmentController addTarget:self action:@selector(segmentSelectAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentController;
    
}
#pragma mark ------------------segmentSelect
-(void)segmentSelectAction:(UISegmentedControl *)segment
{
    CGPoint offset = CGPointMake(DeviceWidth * segment.selectedSegmentIndex, 0);
    [self.scrollView setContentOffset:offset];
    
}
#pragma mark UIScrollViewDelegate

// 这个方法是手动托动滚动视图停止后才会调用，在外部通过setContentOffset改变的不会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger index = scrollView.contentOffset.x / DeviceWidth;
    [segmentController setSelectedSegmentIndex:index];
}

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
