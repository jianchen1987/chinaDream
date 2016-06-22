//
//  SelectBar.m
//  K歌吧
//
//  Created by 谢泽锋 on 15/11/14.
//  Copyright (c) 2015年 xiezefeng. All rights reserved.
//

#import "SelectBar.h"
@interface SelectBar()
{
    NSArray * _titleArray;
    UIColor  * _color;
    UIColor * _selectColor;
    CGRect  _barframe;
}
@end
@implementation SelectBar
-(void)creatTitle:(NSArray*)titleArray color:(UIColor *)color selectColor:(UIColor*)selectColor frame:(CGRect)frame
{
    _titleArray=titleArray;
    _color=color;
    _selectColor=selectColor;
    _barframe=frame;
    
    for (int i=0; i<titleArray.count; i++) {
        float bw=frame.size.width/titleArray.count;
        float bh=frame.size.height;
        UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(i*bw, 0, bw,frame.size.height )];
        [button setTitleColor:color forState:UIControlStateNormal];
        [button setTitleColor:selectColor forState:UIControlStateSelected];
        
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button .tag=i;
        button.titleLabel.font=[UIFont systemFontOfSize:12];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            button.selected=YES;
            NowButton=button;
            barview=[[UIView alloc]initWithFrame:CGRectMake(10, bh-2, bw-20, 2)];
            barview.backgroundColor=selectColor;
            [self addSubview:barview];
        }
        [self addSubview:button];
        
    }
    
}
-(void)click:(UIButton*)sender
{
    float bw=_barframe.size.width/_titleArray.count;
    float bh=_barframe.size.height;
        NowButton.selected=NO;
        NSInteger a=sender.tag;
        [UIView animateWithDuration:0.3 animations:^{
            barview.frame=CGRectMake(bw*a+10, bh-2, bw-20, 2);
        }];
        sender.selected=YES;
        NowButton=sender;
    
    [self.delegte Click:sender.tag];
    self.SelectBarClick(sender.tag);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
