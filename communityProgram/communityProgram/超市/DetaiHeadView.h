//
//  DetaiHeadView.h
//  NEW
//
//  Created by 谢泽锋 on 16/6/17.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickDetailAction)();

@interface DetaiHeadView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleName;
/**
 *  详细描述
 */
@property (weak, nonatomic) IBOutlet UILabel *detaiData;
/**
 *  当前价格
 */
@property (weak, nonatomic) IBOutlet UILabel *price;
/**
 *  已经筹集
 */
@property (weak, nonatomic) IBOutlet UILabel *descInfo;
/**
 *  目标
 */
@property (weak, nonatomic) IBOutlet UILabel *chipNum;
/**
 *  支持人数
 */
@property (weak, nonatomic) IBOutlet UILabel *supportNum;
@property(nonatomic,copy)ClickDetailAction  ClickDetail;
@end
