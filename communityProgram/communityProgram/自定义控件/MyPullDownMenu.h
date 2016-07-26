//
//  MyPullDownMenu.h
//  communityProgram
//
//  Created by 陈剑 on 16/7/13.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "JPullDownMenu.h"

@interface MyPullDownMenu : JPullDownMenu

@property (nonatomic,assign) UIView *showView;


- (instancetype)initWithFrame:(CGRect)frame menuTitleArray:(NSArray *)titleArray ShowInView:(UIView *)view;

@end
