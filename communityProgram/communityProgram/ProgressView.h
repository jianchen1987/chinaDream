//
//  ProgressView.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
/**
 *  进度值
 */
@property(nonatomic,assign)float progressValue;

/**
 *  提示文字
 */
@property(nonatomic,strong)NSString * prompt;
/**
 *  进度条
 */
@property(nonatomic,strong)UIView * progressValueView;

@end
