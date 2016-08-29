//
//  AddNumberView.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/6.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "AddNumberView.h"
#import "UIViewExt.h"
@implementation AddNumberView


-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews
{
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceButton.frame = CGRectMake(0, 0, 30, 30);
    [self.reduceButton addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.reduceButton.tag = 11;
    [self.reduceButton setImage:[UIImage imageNamed:@"jian_icon"] forState:UIControlStateDisabled];
    [self.reduceButton setImage:[UIImage imageNamed:@"数量减"] forState:UIControlStateNormal];
    [self addSubview:self.reduceButton];
    
//    UIImageView *numberBg = [[UIImageView alloc]initWithFrame:CGRectMake(self.reduceButton.right, self.reduceButton.top, 95,30)];
//    numberBg.image = [UIImage imageNamed:@"数量显示"];
//    numberBg.userInteractionEnabled = YES;
//    [self addSubview:numberBg];
    
    
    

    
    
    self.middleNumberTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.reduceButton.right, 0, 35, 30)];
    self.middleNumberTextField.text = @"1";
    self.middleNumberTextField.textAlignment = NSTextAlignmentCenter;
    self.middleNumberTextField.textColor = [UIColor darkGrayColor];
    self.middleNumberTextField.font = Font(12);
    self.middleNumberTextField.enabled = NO;
    self.middleNumberTextField.borderStyle = UITextBorderStyleNone;
    self.middleNumberTextField.background = [UIImage imageNamed:@"数量显示"];
    [self addSubview:self.middleNumberTextField];

    
    
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame = CGRectMake(self.middleNumberTextField.right,0, 30, 30);
    self.addButton.tag = 12;
    [self.addButton setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateDisabled];
    [self.addButton setImage:[UIImage imageNamed:@"数量加"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addButton];
    
    
}



-(void)setNumberString:(NSString *)numberString{
    
    
    _numberString = numberString;
    
    self.middleNumberTextField.text = numberString;
}
- (void)awakeFromNib {

    
}

- (void)deleteBtnAction:(UIButton *)sender {
    
    NSLog(@"减方法");
    if(self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnAction:addNumberView:)]){
        [self.delegate deleteBtnAction:sender addNumberView:self];
    }
    
    
}

- (void)addBtnAction:(UIButton *)sender {
    
     NSLog(@"加方法");
    if(self.delegate && [self.delegate respondsToSelector:@selector(addBtnAction:addNumberView:)]){
        
        [self.delegate addBtnAction:sender addNumberView:self];
    }
    
}
@end
