//
//  TraversePicturesScrollView.m
//  imageviewshow
//
//  Created by 谢泽锋 on 16/4/5.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//



#import "TraversePicturesScrollView.h"

@implementation TraversePicturesScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    _allImageArray=[NSMutableArray array];
    return self;
}
-(void)setAllImageViewArray:(NSMutableArray *)AllImageViewArray{
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
    nowImageCount=AllImageViewArray.count;
    int border=10;
    int number=4;
    int unitW=(self.frame.size.width-(number+1)*border)/4;
    for (int i=0; i<AllImageViewArray.count; i++) {
        UIImageView*imageView=AllImageViewArray[i];
        imageView.frame=CGRectMake(border+(unitW+border)*(i%number), (border+unitW)*(i/number), unitW, unitW);
        imageView.tag=i;
        [self addSubview:imageView];
        imageView.userInteractionEnabled=YES;
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
        [imageView addGestureRecognizer:tap];
        
    }
    _AllImageViewArray=AllImageViewArray;
    self.contentSize=CGSizeMake(self.frame.size.width,unitW+ (border+unitW)*(_allImageArray.count/number));
    

}

-(void)addImage:(UIImage*)imageName{
    [_allImageArray addObject:imageName];
    int number=4;
    int border=10;
    int unitW=(self.frame.size.width-(number+1)*border)/4;
    NSInteger i=_allImageArray.count-1;
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(border+(unitW+border)*(i%number), (border+unitW)*(i/number), unitW, unitW)];
    imageView.tag=i;
     imageView.userInteractionEnabled=YES;
    imageView.image=imageName;
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage:)];
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
     self.contentSize=CGSizeMake(self.frame.size.width,unitW+ (border+unitW)*(_allImageArray.count/number));
}
-(void)selectImage:(UITapGestureRecognizer*)sender
{
    [self.TPdelegte TraversePicturesSelectImage: sender.view.tag];

}

@end
