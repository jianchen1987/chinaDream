//
//  AdditionSubtractionControl.h
//  NEW
//
//  Created by 谢泽锋 on 16/6/18.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
@protocol AdditionSubtractionControlDelgete <NSObject>

-(void)NowNumberChange:(NSInteger)Number;
@end
@interface AdditionSubtractionControl : UIView
/**
 *  当前数值
 */
@property(nonatomic,copy)NSString * NowNumber;
/**
 *  限制最少数值
 */
@property(nonatomic,assign)NSInteger  minimum;
@property(nonatomic,assign)id<AdditionSubtractionControlDelgete> delgete;


@end

