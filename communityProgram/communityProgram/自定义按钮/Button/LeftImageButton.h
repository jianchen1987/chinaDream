//
//  LeftImageButton.h
//  Cartext
//
//  Created by 谢泽锋 on 16/3/22.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftImageButton : UIButton
- (CGRect)titleRectForContentRect:(CGRect)contentRect;
- (CGRect)imageRectForContentRect:(CGRect)contentRect;

@end
