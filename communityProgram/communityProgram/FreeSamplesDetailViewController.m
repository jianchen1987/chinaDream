//
//  FreeSamplesDetailViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/21.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "FreeSamplesDetailViewController.h"
#import "Masonry.h"
#import "PictureCarouselScrollView.h"
@interface FreeSamplesDetailViewController ()
@property(nonatomic,strong)UIScrollView * mainScrollView;

@end

@implementation FreeSamplesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    PictureCarouselScrollView * pic_scroll=[[PictureCarouselScrollView alloc]init];
    [pic_scroll Viewframe:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2) andViewAllimage:@[@""] andChangeTime:2];
    
    
    
    // Do any additional setup after loading the view.
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
