//
//  ProgressView.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/17.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ProgressView.h"
#import <UIKit/UIKit.h>

@interface ProgressView()
@property(nonatomic,strong)UILabel * detail;
@end

@implementation ProgressView
@synthesize  progressValueView;
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        float height=self.frame.size.height;
        self.backgroundColor=RGBA(212, 212, 212, 1);
        self.layer.borderWidth=0.01;
        self.layer.cornerRadius=10;
        _detail =[[UILabel alloc]initWithFrame:CGRectMake(height/2, 0, self.frame.size.width, height)];
        _detail.textAlignment=NSTextAlignmentCenter;
        progressValueView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, height)];
        progressValueView.backgroundColor=RGBA(247, 54, 10, 1);
        progressValueView.layer.borderWidth=0.01;
        progressValueView.layer.cornerRadius=height/4;
        _detail.textColor=[UIColor whiteColor];
        self.clipsToBounds=YES;
        _detail.font=[UIFont systemFontOfSize:self.height*2/3];
        [self addSubview:progressValueView];
        [self addSubview:_detail];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    

    float height=self.frame.size.height;
    self.backgroundColor=RGBA(212, 212, 212, 1);
    self.layer.borderWidth=0.01;
    self.layer.cornerRadius=10;
   _detail =[[UILabel alloc]initWithFrame:CGRectMake(height/2, 0, self.frame.size.width, height)];
    _detail.textAlignment=NSTextAlignmentCenter;
    progressValueView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, height)];
    progressValueView.backgroundColor=RGBA(247, 54, 10, 1);
    progressValueView.layer.borderWidth=0.01;
    progressValueView.layer.cornerRadius=height/4;
    _detail.textColor=[UIColor whiteColor];
    self.clipsToBounds=YES;
    _detail.font=[UIFont systemFontOfSize:self.height*2/3];
    [self addSubview:progressValueView];
    [self addSubview:_detail];
    return self;
}

-(void)setProgressValue:(float)progressValue
{
    
    _progressValue=progressValue;
    _detail.text=[NSString stringWithFormat:@"%@%0.1f%%",_prompt?_prompt:@"",self.progressValue*100];
    [UIView animateWithDuration:0.3 animations:^{
          progressValueView.frame=CGRectMake(0, 0, self.frame.size.width*progressValue, self.frame.size.height);
    }];
}
-(void)setPrompt:(NSString *)prompt{
    _prompt=prompt;
    _detail.text=[NSString stringWithFormat:@"%@%0.1f%%",_prompt?_prompt:@"",self.progressValue*100];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
