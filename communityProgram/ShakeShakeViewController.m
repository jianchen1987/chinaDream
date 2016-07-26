//
//  ShakeShakeViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ShakeShakeViewController.h"
#import "MyintegralViewController.h"

@interface ShakeShakeViewController ()

@end

@implementation ShakeShakeViewController
- (IBAction)action:(id)sender
{
    [self.navigationController pushViewController:[MyintegralViewController new] animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBarHidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
-(void)shake{
    
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.user.identifyName] WithPath:@"shakeRed" successBlock:^(id successJsonData) {
        [_phone.layer removeAllAnimations];
        NSLog(@"successJsonData////////////%@",successJsonData);
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData////////////%@",errorJsonData);
        [_phone.layer removeAllAnimations];

    } ];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    self.view.backgroundColor= RGBA(60, 0, 93, 1);

    [self becomeFirstResponder];
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    NSLog(@"检测到摇动");
    //检测到摇动
    [self shake];
}



- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    NSLog(@"摇动取消");
    //摇动取消
    
}






- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        CABasicAnimation *momAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        momAnimation.fromValue = [NSNumber numberWithFloat:-0.3];
        
        momAnimation.toValue = [NSNumber numberWithFloat:0.3];
        
        momAnimation.duration = 0.05;
        
        momAnimation.repeatCount = CGFLOAT_MAX;
        
        momAnimation.autoreverses = YES;
        
        momAnimation.delegate = self;
        
        [_phone.layer addAnimation:momAnimation forKey:@"animateLayer"];
        

        //something happens
        
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self pauseLayer:_phone.layer];
//    [_phone.layer removeAllAnimations];
}
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
    
}

//重新开始动画
-(void)resumeLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
    
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
