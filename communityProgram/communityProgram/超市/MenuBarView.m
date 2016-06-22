//
//  MenuBarView.m
//  navigation
//
//  Created by 谢泽锋 on 16/6/10.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//
#import "MenuBarView.h"
#define Unit_W (Self_W-3)/4
#define Self_W self.frame.size.width
@interface MenuBarView()
{
    UIButton * explain;
    UIView * backView;
}
@property(nonatomic,strong)UIScrollView * srollView;
@property(nonatomic,strong)UIButton * More_BT;
@end
@implementation MenuBarView
-(instancetype)init{
    self=[super init];
    self.MenuTextFont=15;
    [self initView];
    return self;
}
-(void)tap{
    self.click(-1);
    [self removeFromSuperview];
}
-(void)clickAction:(UIButton*)sender{
    self.click(sender.tag);
    [self removeFromSuperview];

}
-(void)initView{
    
    self.frame=[UIScreen mainScreen].bounds;
    backView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor=[UIColor blackColor];
    backView.alpha=0.3;
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addSubview:backView];
    [backView addGestureRecognizer:tap];
    explain =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, Self_W, 50)];
    explain.backgroundColor=[UIColor whiteColor];
    [explain setTitle:@"切换栏目" forState:UIControlStateNormal];
    [explain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    explain.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
    explain.contentEdgeInsets=UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:explain];
    _srollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-50, 50)];
    _srollView.showsVerticalScrollIndicator=NO;
    _srollView.showsHorizontalScrollIndicator=NO;
    _srollView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    _More_BT =[[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-50, 0, 50, 50)];
    [_More_BT addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
    [_More_BT setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
    [_More_BT setImage:[UIImage imageNamed:@"上拉和收起"] forState:UIControlStateSelected];

    _More_BT.backgroundColor=[UIColor whiteColor];
    [self addSubview:_srollView];
    [self addSubview:_More_BT];

}

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    [self initView];
    return self;
}
-(void)setMenuArray:(NSArray*)MenuArray{
    _MenuArray=MenuArray;

    for (int i=0; i<MenuArray.count; i++)
    {
        UIButton * unit  =[[UIButton alloc]initWithFrame:CGRectMake(i*Unit_W, 0, Unit_W, 50)];
        [unit setTitle:MenuArray[i] forState:UIControlStateNormal];
        unit.backgroundColor=[UIColor whiteColor];
        [unit setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        unit.titleLabel.font=[UIFont systemFontOfSize:self.MenuTextFont];
        [unit setTitleColor:[UIColor colorWithRed:168/255.0 green:168/255.0 blue:168/255.0 alpha:1] forState:UIControlStateNormal];
        [_srollView addSubview:unit];
        unit.tag=i;
        [unit addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIView * view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    [_srollView addSubview:view];
    _srollView.contentSize=CGSizeMake(MenuArray.count*Unit_W, 50);
    
}
-(void)clickMore
{
   NSInteger subviews=  _MenuArray.count;
    _srollView.alpha=0;
    float height=40;
    [UIView animateWithDuration:0.3 animations:^{
        if (!_More_BT.selected) {
            _srollView.frame=CGRectMake(0, height, Self_W,  height*(subviews%4+subviews/4));
            for (int i=0; i<_srollView.subviews.count; i++) {
                if ([_srollView.subviews[i] isKindOfClass:[UIButton class]]) {
                    UIButton * unit=_srollView.subviews[i];
                    unit.frame= CGRectMake(i%4*(Unit_W+1), (height+1)*(i/4), Unit_W, height);
                    [unit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }else{
                    UIView * view=_srollView.subviews[i];
                    view.frame=CGRectMake(i%4*(Unit_W+1), (height+1)*(i/4), Self_W-(height+1)*(i/4), height);
                    
                }
            }
            _srollView.contentSize=CGSizeMake(Self_W, (height+1)+(subviews/4+subviews%4));
        }else{
            _srollView.frame=CGRectMake(0, 0, Self_W,  50);
            for (int i=0; i<_srollView.subviews.count; i++) {
                if ([_srollView.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton * unit  =_srollView.subviews[i];
                unit.frame= CGRectMake(i*Unit_W, 0, Unit_W, 50);
                [unit setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:UIControlStateNormal];
                }

            }
            _srollView.contentSize=CGSizeMake(subviews*Unit_W+50, 50);
        }
            _srollView.alpha=0.7;
        }completion:^(BOOL finished) {
            _srollView.alpha=1;
        }];
    _More_BT.selected=!_More_BT.selected;
}


@end
