//
//  IntegralMallViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/2/29.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "IntegralMallViewController.h"

@interface IntegralMallViewController ()

@end

@implementation IntegralMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


@end
