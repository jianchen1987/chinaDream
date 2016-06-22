//
//  RegisterViewController.h
//  policyManager
//
//  Created by tru on 15/7/16.
//  Copyright (c) 2015年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "NSString+expanded.h"
#import "GetCommunityViewController.h"
#import "LCActionSheet.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate,LCActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITextField *textfield_vertificate;//验证码输入
    UITextField *tf_nikiName;
    UITextField *tf_passWord;
    
    UIButton *btn_getVertificate;
    UIImageView *backImageView;
    
    UITextField *nicknameTextField;//昵称
    UIImageView *headImageView;  //设置头像
}
@property(nonatomic,copy)NSString *phoneString;
@property(nonatomic,copy)NSString *isForgetVC;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *password;
@end
