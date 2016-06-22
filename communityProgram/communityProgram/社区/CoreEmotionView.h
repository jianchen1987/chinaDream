//
//  CoreEmotionView.h
//  CoreEmotionView
//
//  Created by 沐汐 on 15-4-11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSAttributedString+Emotion.h"

@class EmotionModel;


@interface CoreEmotionView : UIView<UITextViewDelegate>
/**
 *  textview编辑的字符串
 */
@property(nonatomic,copy)NSMutableString *contentStr;
/**
 *  存放每个表情数据
 */
@property(nonatomic,copy)NSMutableArray *modelArr;
/**
 *  点击删除按钮
 *  contentStr   当前删除的字符串
 */
@property (nonatomic,copy) void (^deleteBtnClickBlock)(NSMutableString *contentStr,NSMutableArray *modelArr);



/*
 *  点击了表情按钮
 */
@property (nonatomic,copy) void (^emotionItemBtnClickBlock)(EmotionModel *emotionModel);




/*
 *  表情键盘的输出控件：textView
 */
@property (nonatomic,weak) UITextView *textView;

/*
 *  表情键盘的输出控件：textField
 */
@property (nonatomic,weak) UITextField *textField;


+(instancetype)emotionView;

@end
