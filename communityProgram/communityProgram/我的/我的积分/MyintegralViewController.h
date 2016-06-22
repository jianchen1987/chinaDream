//
//  MyintegralViewController.h
//  communityProgram
//
//  Created by xiaogao on 15/12/16.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"

@interface MyintegralViewController : BaseViewController<UIScrollViewDelegate>
{
    UISegmentedControl *segment;
}
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
