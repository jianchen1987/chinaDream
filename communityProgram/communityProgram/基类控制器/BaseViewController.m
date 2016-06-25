//
//  BaseViewController.m
//  communityProgram
//
//  Created by ; on 15/12/6.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+MBW.h"
#import "LoginViewController.h"


@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _user = [UserObject shareUser];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor   = RGBA(239, 238, 239, 1);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (self.navigationController.viewControllers.count>1)
    {
        UIButton * back =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        back.contentEdgeInsets=UIEdgeInsetsMake(0, -45, 0, 0);
        [back setImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
        UIBarButtonItem * Leftbutton=[[UIBarButtonItem alloc]initWithCustomView:back];
        [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=Leftbutton;
        self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    }

}
-(void)showLoading
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)showPrompt:(NSString*)detail
{
    [MBProgressHUD showError:detail toView:self.view];
    [MBProgressHUD hideHUD];
}

-(void)dismissShow
{
    [MBProgressHUD hideHUD];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableAttributedString*)AttributedString:(NSString*)allstring rangeString:(NSString*)rangeString color:(UIColor*)color
{
    NSMutableAttributedString* string=[[NSMutableAttributedString alloc]initWithString:allstring];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[allstring rangeOfString:allstring]];

    [string addAttribute:NSForegroundColorAttributeName value:color range:[allstring rangeOfString:rangeString]];
    
    return string;

}


-(NSMutableAttributedString*)AttributedString:(NSString*)allstring  image:(NSString*)imageName
{
    NSMutableAttributedString* string=[[NSMutableAttributedString alloc]init];
    NSTextAttachment* att=[[NSTextAttachment alloc]init];
    
    att.image=[UIImage imageNamed:imageName];
    att.bounds=CGRectMake(0, -8, 25, 25);
    NSAttributedString * attString=[NSAttributedString attributedStringWithAttachment:att];
    NSAttributedString * two=[[NSAttributedString alloc]initWithString:allstring];
  
    [string appendAttributedString:attString];
    [string appendAttributedString:two];
    return string;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)checkIsLogin
{
    UserObject *user = [UserObject shareUser];
    if(![user isLogin])
    {
        LoginViewController *vc = [[LoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}



@end
