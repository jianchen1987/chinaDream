//
//  AdditionSubtractionControl.m
//  NEW
//
//  Created by 谢泽锋 on 16/6/18.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//
#import "AdditionSubtractionControl.h"

@interface AdditionSubtractionControl ()
@property(nonatomic,strong)UILabel * Number_LB;
@property(nonatomic,assign)NSInteger  number;

@end

@implementation AdditionSubtractionControl
@synthesize Number_LB;
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self =[super initWithCoder:aDecoder];
    self.layer.borderWidth=1;
    self.clipsToBounds=YES;
    self.layer.cornerRadius=4;
    self.layer.borderColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1 ].CGColor;
    self.backgroundColor= [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1 ];
    float unit_W=(self.frame.size.width-2)/3;
    float unit_H=self.frame.size.height;
    
    
    _number=1;
    _NowNumber=@"1";
    UIButton * reduce_BT =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, unit_W, unit_H)];
    [reduce_BT setTitle:@"-" forState:UIControlStateNormal];
    
    [self addSubview:reduce_BT];
    
    
    
    Number_LB =[[UILabel alloc]initWithFrame:CGRectMake(reduce_BT.frame.size.width+1, 0, unit_W, unit_H)];
    [self addSubview:Number_LB];
    
    
    Number_LB.textAlignment=NSTextAlignmentCenter;
    UIButton * add_BT =[[UIButton alloc]initWithFrame:CGRectMake(Number_LB.frame.origin.x+0.5+Number_LB.frame.size.width,0, unit_W, unit_H)];
    [add_BT setTitle:@"+" forState:UIControlStateNormal];
    [self addSubview:add_BT];
    [add_BT addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    add_BT.tag=200;
    reduce_BT.tag=100;
    [reduce_BT addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [add_BT setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [reduce_BT setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
    Number_LB.backgroundColor=  add_BT.backgroundColor= reduce_BT.backgroundColor=[UIColor whiteColor];
    _minimum=1;
    
    Number_LB.text=_NowNumber=[NSString stringWithFormat:@"%ld",(long)_number];
    add_BT.titleLabel.font=reduce_BT.titleLabel.font=[UIFont systemFontOfSize:20];
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    self.layer.borderWidth=1;
    self.clipsToBounds=YES;
    self.layer.cornerRadius=4;
    self.layer.borderColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1 ].CGColor;
    self.backgroundColor= [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1 ];
    float unit_W=(self.frame.size.width-2)/3;
    float unit_H=self.frame.size.height;
    
    
    _number=1;
    _NowNumber=@"1";
    UIButton * reduce_BT =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, unit_W, unit_H)];
    [reduce_BT setTitle:@"-" forState:UIControlStateNormal];
    
    [self addSubview:reduce_BT];
    
    
    
    Number_LB =[[UILabel alloc]initWithFrame:CGRectMake(reduce_BT.frame.size.width+1, 0, unit_W, unit_H)];
    [self addSubview:Number_LB];
    
    
    Number_LB.textAlignment=NSTextAlignmentCenter;
    UIButton * add_BT =[[UIButton alloc]initWithFrame:CGRectMake(Number_LB.frame.origin.x+0.5+Number_LB.frame.size.width,0, unit_W, unit_H)];
    [add_BT setTitle:@"+" forState:UIControlStateNormal];
    [self addSubview:add_BT];
    [add_BT addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    add_BT.tag=200;
    reduce_BT.tag=100;
    [reduce_BT addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [add_BT setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [reduce_BT setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    
    Number_LB.backgroundColor=  add_BT.backgroundColor= reduce_BT.backgroundColor=[UIColor whiteColor];
    _minimum=1;
    
    Number_LB.text=_NowNumber=[NSString stringWithFormat:@"%ld",(long)_number];
    add_BT.titleLabel.font=reduce_BT.titleLabel.font=[UIFont systemFontOfSize:25];
    return self;
}
-(void)click:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:
            if (_number>_minimum)
            {
                _number--;
                Number_LB.text=_NowNumber=[NSString stringWithFormat:@"%ld",(long)_number];
            }
            break;
        case 200:
            _number++;
            Number_LB.text=_NowNumber=[NSString stringWithFormat:@"%ld",(long)_number];
            break;
            
        default:
            break;
    }
    [self.delgete NowNumberChange:_number];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
