//
//  AddNumberView.h
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/6.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddNumberViewDelegate;


@interface AddNumberView : UIView



@property (strong, nonatomic) UIButton *reduceButton;
@property (strong, nonatomic) UIButton *addButton;
@property (strong, nonatomic) UITextField *middleNumberTextField;

@property (nonatomic,copy) NSString *numberString;

@property (nonatomic,assign) id<AddNumberViewDelegate> delegate;

@end


@protocol AddNumberViewDelegate <NSObject>

@optional


- (void)deleteBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view;

- (void)addBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view;



@end

