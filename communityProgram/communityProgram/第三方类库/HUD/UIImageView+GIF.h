//
//  UIImageView+GIF.h
//  PayEasy
//
//  Created by 马 博文 on 15/12/8.
//  Copyright © 2015年 Bestpay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView(GIF)
// 从指定的路径加载GIF并创建UIImageView
+ (UIImageView *)imageViewWithGIFFile:(NSString *)file;
@end
