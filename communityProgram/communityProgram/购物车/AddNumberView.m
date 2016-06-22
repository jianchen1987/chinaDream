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
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    UIImageView *numberBg = [[UIImageView alloc]initWithFrame:CGRectMake(self.reduceButton.right, self.reduceButton.top, 110,30)];
    numberBg.image = [UIImage imageNamed:@"numbe_bg_icon"];
    numberBg.userInteractionEnabled = YES;
    [self addSubview:numberBg];
    
    self.reduceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.reduceButton.frame = CGRectMake(0, 0, 30, 30);
    [self.reduceButton addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.reduceButton.tag = 11;
    [self.reduceButton setImage:[UIImage imageNamed:@"jian_icon"] forState:UIControlStateNormal];
    [numberBg addSubview:self.reduceButton];
    

    
    
    self.middleNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(self.reduceButton.right, 0, 50, 30)];
    self.middleNumberLable.text = @"1";
    self.middleNumberLable.textAlignment = NSTextAlignmentCenter;
    self.middleNumberLable.textColor = [UIColor darkGrayColor];
    self.middleNumberLable.font = Font(12);
    [numberBg addSubview:self.middleNumberLable];

    
    
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame = CGRectMake(self.middleNumberLable.right,0, 30, 30);
    self.addButton.tag = 12;
    [self.addButton setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [numberBg addSubview:self.addButton];
    
    
}



-(void)setNumberString:(NSString *)numberString{
    
    
    _numberString = numberString;
    
    self.middleNumberLable.text = numberString;
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
