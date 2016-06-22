//
//  MenuBarView.h
//  navigation
//
//  Created by 谢泽锋 on 16/6/10.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Click)(NSInteger);
@interface MenuBarView : UIView
@property(nonatomic,strong)NSArray* MenuArray;
@property(nonatomic,copy)Click click;
@property(nonatomic,assign)NSInteger MenuTextFont;

@end
