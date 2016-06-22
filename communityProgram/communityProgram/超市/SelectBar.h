//
//  SelectBar.h
//  K歌吧
//
//  Created by 谢泽锋 on 15/11/14.
//  Copyright (c) 2015年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^click)(NSInteger number);
@protocol SelectBarDelegte <NSObject>

-(void)Click:(NSInteger)numberButton;

@end
@interface SelectBar : UIView
{
    UIView* barview;
    UIButton * NowButton;
}
@property(nonatomic,copy)click  SelectBarClick;
@property(nonatomic,assign)id<SelectBarDelegte>delegte;
-(void)creatTitle:(NSArray*)titleArray color:(UIColor*)color selectColor:(UIColor*)selectColor frame:(CGRect)frame;
@end
