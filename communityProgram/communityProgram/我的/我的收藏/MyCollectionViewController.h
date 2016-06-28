//
//  MyCollectionViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "baseTableViewController.h"
#import "MycollectionTableViewCell.h"

#define _BUTTONVIEW_BUTTON_HEIGHT 40.0f

@interface MyCollectionViewController : baseTableViewController

@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic, assign) CGFloat buttonHeght;

- (void)clickOnButton:(UIButton *)button atIndex:(NSUInteger)index;


@end
