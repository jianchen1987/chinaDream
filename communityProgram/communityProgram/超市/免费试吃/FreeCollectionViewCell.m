//
//  CustomCollectionViewCell.m
//  UIcollectionView
//
//  Created by 谢泽锋 on 16/6/24.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import "FreeCollectionViewCell.h"
#import "UIView+Getlength.h"
@interface FreeCollectionViewCell()


@end
@implementation FreeCollectionViewCell
@synthesize time_LB,FreeImage,numberCount,applyCount,title_LB,isEnd,isEndView,detail;
-(void)setExpireDate:(NSString *)expireDate{
    _expireDate=expireDate;
    NSDateFormatter * dataFormatter=[[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * now =[NSDate date];
    NSString*d=expireDate;
    NSDate * old=[dataFormatter dateFromString:d];
    float time= [now timeIntervalSinceDate:old];
    if (time<0) {
        isEndView.hidden=YES;
    }else{
        isEndView.hidden=NO;
       
        
    }
}

-(instancetype)initWithFrame:(CGRect)frame{
   self= [super initWithFrame:frame];
    
    float number=15;
    float apply=20;
    float time=15;
    float detailFont=40;
   
    UIView * Writeback=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.getWidth, (DeviceWidth-1)/2+90)];
//    time_LB.text=@"最新试吃活动时间剩余";
    Writeback.backgroundColor=[UIColor whiteColor];

    [Writeback addSubview:time_LB];
    FreeImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, Writeback.getWidth, Writeback.getWidth)];
    FreeImage.image=[UIImage imageNamed:@"cell图片"];
    [Writeback addSubview:FreeImage];
    title_LB=[[UILabel alloc]initWithFrame:CGRectMake(5,FreeImage.getH_Y, Writeback.getH_Y, time)];
    title_LB.text=@"";
   
    
    detail =[[UILabel alloc]initWithFrame:CGRectMake(5, title_LB.getH_Y, Writeback.getWidth-60, detailFont)];
    detail.numberOfLines=2;
    detail.text=@"";

    
    numberCount =[[UILabel alloc]initWithFrame:CGRectMake(5, detail.getH_Y, 100, number)];
    numberCount.text=@"0份";
    numberCount.textColor=[UIColor redColor];
    
    applyCount=[[UILabel alloc]initWithFrame:CGRectMake(Writeback.getWidth-220, numberCount.getY, 200, apply)];
    applyCount.text=@"已经有0人申请";
    applyCount.textAlignment=NSTextAlignmentRight;
    [Writeback addSubview:applyCount];
//    UIButton * sure=[[UIButton alloc]initWithFrame:CGRectMake(0, numberCount.getH_Y, Writeback.getWidth, 50)];
//    [sure setTitle:@"立即申请" forState:UIControlStateNormal];
//    [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
//    [sure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    applyCount.font=numberCount.font=detail.font=[UIFont systemFontOfSize:12];
    isEndView=[[UIImageView alloc]initWithFrame:CGRectMake(Writeback.getWidth-50, title_LB.getH_Y-10, 40, 40)];
    isEndView.image=[UIImage imageNamed:@"试吃结束"];
    time_LB=[[UILabel alloc]initWithFrame:CGRectMake(5, applyCount.getH_Y, Writeback.getWidth-20, time)];
    
    time_LB.font=[UIFont systemFontOfSize:12];
    
    Writeback.layer.cornerRadius=5;
//    [Writeback addSubview:sure];
    [Writeback addSubview:numberCount];
    [Writeback addSubview:time_LB];
    [Writeback addSubview:title_LB];
    [Writeback addSubview:detail];
    [self.contentView addSubview:Writeback];
    [Writeback addSubview:isEndView];

    self.backgroundColor=[UIColor whiteColor];
    Writeback.frame=CGRectMake(0, 0,self.getWidth-20,  time_LB.getH_Y);
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
    [_timer fire];
    return self;
}
-(void)sure{
    if (isEnd) {
        self.applyAction();

    }
}
-(void)timeStart{
    NSDateFormatter * dataFormatter=[[NSDateFormatter alloc]init];
    [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * now =[NSDate date];
    NSString*d=_expireDate;
    NSDate * old=[dataFormatter dateFromString:d];
//    NSLog(@"%@", [dataFormatter stringFromDate:now]);
    int totalSeconds= [old timeIntervalSinceDate:now];
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds/60)% 60;
    int hours = totalSeconds / 3600;
//    time_LB.font=[UIFont systemFontOfSize:20];
    
    if (totalSeconds>0) {
        isEnd=YES;
        time_LB.text=[NSString stringWithFormat:@"剩余%02d小时%02d分%02d秒",hours, minutes, seconds];
//        time_LB.textColor=[UIColor redColor];
//        time_LB.attributedText=[self AttributedString:[NSString stringWithFormat:@"剩余%02d小时%02d分%02d秒",hours, minutes, seconds]rangeString:@"剩余:" color:[UIColor blackColor]];
    }else{
         isEnd=NO;
        time_LB.text=@"剩余:00:00:00";
//        time_LB.textColor=[UIColor redColor];
//        time_LB.attributedText=[self AttributedString:@"剩余:00小时00分00秒"rangeString:@"剩余:" color:[UIColor blackColor]];
    }
    
}
-(NSMutableAttributedString*)AttributedString:(NSString*)allstring rangeString:(NSString*)rangeString color:(UIColor*)color
{
    NSMutableAttributedString* string=[[NSMutableAttributedString alloc]initWithString:allstring];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[allstring rangeOfString:allstring]];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[allstring rangeOfString:rangeString]];

    [string addAttribute:NSForegroundColorAttributeName value:color range:[allstring rangeOfString:rangeString]];
    
    return string;
    
}
-(void)dealloc{
    [_timer invalidate];
}


@end
