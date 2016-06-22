//
//  titleButton.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/16.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleButton : UIButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect;
-(CGRect)titleRectForContentRect:(CGRect)contentRect;
@end
