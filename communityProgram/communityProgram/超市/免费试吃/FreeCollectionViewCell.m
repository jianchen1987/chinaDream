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
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeStart) userInfo:nil repeats:YES];
    [_timer fire];
    UIView * Writeback=[[UIView alloc]initWithFrame:CGRectMake(20, 20, self.getWidth-40, 160)];
    time_LB=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, Writeback.getWidth-20, 40)];
//    time_LB.text=@"最新试吃活动时间剩余";
    Writeback.backgroundColor=[UIColor whiteColor];

    [Writeback addSubview:time_LB];
    FreeImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5+time_LB.getH_Y, Writeback.getWidth-20, Writeback.getWidth-60)];
    FreeImage.image=[UIImage imageNamed:@"cell图片"];
    [Writeback addSubview:FreeImage];
    title_LB=[[UILabel alloc]initWithFrame:CGRectMake(20,FreeImage.getH_Y, Writeback.getH_Y, 20)];
    title_LB.text=@"";
    detail =[[UILabel alloc]initWithFrame:CGRectMake(10, title_LB.getH_Y, Writeback.getWidth-60, 60)];
    detail.numberOfLines=2;
    detail.text=@"";

    numberCount =[[UILabel alloc]initWithFrame:CGRectMake(10, detail.getH_Y, 100, 40)];
    numberCount.text=@"0份";
    numberCount.textColor=[UIColor redColor];
    
    applyCount=[[UILabel alloc]initWithFrame:CGRectMake(Writeback.getWidth-220, numberCount.getY, 200, 40)];
    applyCount.text=@"已经有0人申请";
    applyCount.textAlignment=NSTextAlignmentRight;
    [Writeback addSubview:applyCount];
    
    
    
    UIView * line=[[UIView alloc]initWithFrame:CGRectMake(20, numberCount.getH_Y, Writeback.getWidth-40, 1)];
    
    line.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    [Writeback addSubview:line];
    UIButton * sure=[[UIButton alloc]initWithFrame:CGRectMake(0, numberCount.getH_Y, Writeback.getWidth, 50)];
    [sure setTitle:@"立即申请" forState:UIControlStateNormal];
    [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [sure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    isEndView=[[UIImageView alloc]initWithFrame:CGRectMake(Writeback.getWidth-90, title_LB.getH_Y-10, 80, 80)];
    isEndView.image=[UIImage imageNamed:@"试吃结束"];
    
    
    Writeback.layer.cornerRadius=5;
    [Writeback addSubview:sure];
    [Writeback addSubview:numberCount];
    [Writeback addSubview:time_LB];
    [Writeback addSubview:title_LB];
    [Writeback addSubview:detail];
    [self.contentView addSubview:Writeback];
    [Writeback addSubview:isEndView];

    Writeback.frame=CGRectMake(10, 20,self.getWidth-20,  sure.getH_Y);
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
    time_LB.font=[UIFont systemFontOfSize:20];
    if (totalSeconds>0) {
        isEnd=YES;
        time_LB.text=[NSString stringWithFormat:@"最新试吃活动时间剩余:%02d:%02d:%02d",hours, minutes, seconds];
        time_LB.textColor=[UIColor redColor];
        time_LB.attributedText=[self AttributedString:[NSString stringWithFormat:@"最新试吃活动时间剩余:%02d:%02d:%02d",hours, minutes, seconds]rangeString:@"最新试吃活动时间剩余:" color:[UIColor blackColor]];
    }else{
         isEnd=NO;
        time_LB.text=@"最新试吃活动时间剩余:00:00:00";
        time_LB.textColor=[UIColor redColor];
        time_LB.attributedText=[self AttributedString:@"最新试吃活动时间剩余:00:00:00"rangeString:@"最新试吃活动时间剩余:" color:[UIColor blackColor]];
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
