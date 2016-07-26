//
//  MyPullDownMenu.m
//  communityProgram
//
//  Created by 陈剑 on 16/7/13.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyPullDownMenu.h"

@interface MyPullDownMenu()

@property (nonatomic) UITableView *tableView;

@end

@implementation MyPullDownMenu

- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray ShowInView:(UIView *)view
{
    self = [super initWithFrame:frame menuTitleArray:titleArray];
    if(self)
    {
        self.showView = view;
//        [self.tableView removeFromSuperview];
//        
//        [self.showView addSubview:self.tableView];
    }
    
    return self;
}



@end
