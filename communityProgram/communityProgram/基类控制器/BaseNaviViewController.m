//
//  BaseNaviViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseNaviViewController.h"

@interface BaseNaviViewController ()

@end

@implementation BaseNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIButton * back =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
//    back.contentEdgeInsets=UIEdgeInsetsMake(7, -45, 0, 0);
//    [back setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
//    UIBarButtonItem * Leftbutton=[[UIBarButtonItem alloc]initWithCustomView:back];
//    NSLog(@"%lu",(unsigned long)self.viewControllers.count);
//    UIViewController * view=[self.viewControllers lastObject];
//    view.navigationItem.leftBarButtonItem=Leftbutton;
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
 

    [super pushViewController:viewController animated:animated];

   
  
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
