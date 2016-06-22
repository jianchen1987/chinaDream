//
//  RegisterNextViewController.h
//  policyManager
//
//  Created by tru on 15/10/8.
//  Copyright (c) 2015年 创必承. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterViewController.h"
@interface RegisterNextViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *phoneTextField;
    UITextField *vertificationTextField;
    UITextField *passwordTextField;
    
    UIButton *nextButton;
}
@end
