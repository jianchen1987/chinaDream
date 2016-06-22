//
//  ZFscrollView.m
//  scrollView
//
//  Created by 谢泽锋 on 15/7/22.
//  Copyright (c) 2015年 xiezefeng. All rights reserved.
//
#define Vwidth   [UIScreen mainScreen].bounds.size.width
#define Vheight  [UIScreen mainScreen].bounds.size.height

#import "PictureCarouselScrollView.h"
#import "UIImageView+WebCache.h"
@interface PictureCarouselScrollView()
@property(nonatomic,assign)int new;
@property(nonatomic,assign)int old;
@property(nonatomic,strong)  NSTimer * timer;
@property(nonatomic,assign)int now;
@property(nonatomic,strong)NSArray * array;
//@property(nonatomic,strong)UIPageControl * page;
@property(nonatomic,assign)CGRect rect;
@property(nonatomic,assign)NSInteger number;
@end
@implementation PictureCarouselScrollView

@synthesize timer,page,rect;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50,Vwidth, 30)];

//        self.showsHorizontalScrollIndicator = NO;
//        self.showsVerticalScrollIndicator = NO;
//        self.pagingEnabled = YES;
    }
    return self;
}

-(void)Viewframe:(CGRect)frame
andViewAllimageView:(NSArray*)imageArray
   andChangeTime:(NSInteger)changeTime
          object:(UIView*)view{
    self.showsHorizontalScrollIndicator=NO;
    self.rect=frame;
    self.showsVerticalScrollIndicator=NO;
    self.scrollsToTop=YES;
    self.array=imageArray;
    self.delegate=self;
    self.contentSize=CGSizeMake(frame.size.width*(imageArray.count+2), frame.size.height);
    self.pagingEnabled=YES;
    self.number=imageArray.count+2;
    
    for (int i=0; i<imageArray.count+2; i++) {
        UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
        if (i==0) {//第一张为最后一张
          
        [imageView sd_setImageWithURL:imageArray[imageArray.count-1] placeholderImage:[UIImage imageNamed:@"图片"]];
            
        }else if(i==imageArray.count+1)//最后一张为第一张
        {
            [imageView sd_setImageWithURL:imageArray[0]];
        }else{
            [imageView sd_setImageWithURL: imageArray[i-1]];
        }
        UILabel * labe=[[UILabel alloc]initWithFrame:CGRectMake(11, 13,333, 33)];
        [imageView addSubview:labe];
        
        [self addSubview:imageView];
    }
    [view addSubview:self];
    self.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    self.contentOffset=CGPointMake(frame.size.width,0);
    self.showsHorizontalScrollIndicator=YES;
    self.bounces = YES;
    
    page.pageIndicatorTintColor=[UIColor grayColor];
    page.numberOfPages=imageArray.count;
    page.currentPage=0;
    //    page.backgroundColor=[UIColor grayColor];
    page.currentPageIndicatorTintColor=[UIColor orangeColor];
//    [view addSubview:page];
    timer =[NSTimer scheduledTimerWithTimeInterval:changeTime target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [timer fire];
    self.now=1;

    
}
-(void)Viewframe:(CGRect)frame
 andViewAllimage:(NSArray*)imageArray
   andChangeTime:(NSInteger)changeTime
{
    self.showsHorizontalScrollIndicator=NO;
    self.rect=frame;
    self.showsVerticalScrollIndicator=NO;
    self.scrollsToTop=YES;
    self.array=imageArray;
    self.delegate=self;
    self.contentSize=CGSizeMake(frame.size.width*(imageArray.count+2), frame.size.height);
    self.pagingEnabled=YES;
    self.number=imageArray.count+2;
    self.imagePlaceName=self.imagePlaceName?self.imagePlaceName:@"";
    for (int i=0; i<imageArray.count+2; i++) {
        UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
        if (imageArray.count==0) {
            imageView.image=[UIImage imageNamed:_imagePlaceName] ;
            return;
        }
        if (i==0) {//第一张为最后一张
         
                    [imageView sd_setImageWithURL:imageArray[imageArray.count-1] placeholderImage:[UIImage imageNamed:self.imagePlaceName]] ;
            
            
        
            
        }else if(i==imageArray.count+1)//最后一张为第一张
        {
            [imageView sd_setImageWithURL:imageArray[0]placeholderImage:[UIImage imageNamed:self.imagePlaceName]];
        }else{
            [imageView sd_setImageWithURL: imageArray[i-1]placeholderImage:[UIImage imageNamed:self.imagePlaceName]];
        }
        UILabel * labe=[[UILabel alloc]initWithFrame:CGRectMake(11, 13,333, 33)];
        [imageView addSubview:labe];
        
        [self addSubview:imageView];
    }
    self.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    self.contentOffset=CGPointMake(frame.size.width,0);
    self.showsHorizontalScrollIndicator=YES;
    self.bounces = YES;
    if (!page) {
        page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50,Vwidth, 30)];

    }
    page.pageIndicatorTintColor=[UIColor grayColor];
    page.numberOfPages=imageArray.count;
    page.currentPage=0;
    //    page.backgroundColor=[UIColor grayColor];
    page.currentPageIndicatorTintColor=[UIColor orangeColor];
//    [self addSubview:page];
    timer =[NSTimer scheduledTimerWithTimeInterval:changeTime target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [timer fire];
    self.now=1;
    
}
-(void)Viewframe:(CGRect)frame
              andViewAllimage:(NSArray*)imageArray
                andChangeTime:(NSInteger)changeTime
                       object:(UIView*)view
{
    self.showsHorizontalScrollIndicator=NO;
    self.rect=frame;
    self.showsVerticalScrollIndicator=NO;
    self.scrollsToTop=YES;
    self.array=imageArray;
    self.delegate=self;
    self.contentSize=CGSizeMake(frame.size.width*(imageArray.count+2), frame.size.height);
    self.pagingEnabled=YES;
    self.number=imageArray.count+2;
    
    for (int i=0; i<imageArray.count+2; i++) {
//        NSLog(@"imageArray.count+1===%d",imageArray.count+1);
        UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
        if (i==0) {//第一张为最后一张
            imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[imageArray.count-1]]];
            
        }else if(i==imageArray.count+1)//最后一张为第一张
        {
            imageView.image=[UIImage imageNamed:imageArray[0]];
        }else{
            imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArray[i-1]]];
        }
        UILabel * labe=[[UILabel alloc]initWithFrame:CGRectMake(11, 13,333, 33)];
        [imageView addSubview:labe];
        
        [self addSubview:imageView];
    }
    [view addSubview:self];
    self.indicatorStyle=UIScrollViewIndicatorStyleWhite;
    self.contentOffset=CGPointMake(frame.size.width,0);
    self.showsHorizontalScrollIndicator=YES;
    self.bounces = YES;
    
    page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.frame.size.height-50,Vwidth, 30)];
    page.pageIndicatorTintColor=[UIColor grayColor];
    page.numberOfPages=imageArray.count;
    page.currentPage=0;
    page.currentPageIndicatorTintColor=[UIColor orangeColor];
    [view addSubview:page];
    timer =[NSTimer scheduledTimerWithTimeInterval:changeTime target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [timer fire];
    self.now=1;
   
}
-(void)timeRun

{
    self.now= (self.contentOffset.x/rect.size.width)+1;
    self.contentOffset=CGPointMake(self.now%(self.number-1)*rect.size.width, 0);
    self.page.currentPage=(self.now-1)%(self.number-1);

}
-(void)array:(NSArray * )array
      border:(NSInteger)border
      center:(NSInteger)center
       Bount: (float)bottom
  viewHeight:(float)height{
    
    float w =self.frame.size.width;
    float CustomViewW=(w-border*2-center)/2;
    float CustomViewH=height;
    float scrollContentHeight = 0.0;
    for (int n=0; n<array.count; n++) {
        UIView * view=[array objectAtIndex:n];
        view.frame= CGRectMake(border+(CustomViewW+center)*(n%2), border*3/2+(CustomViewH+bottom)*(n/2), CustomViewW, CustomViewH);
        [self addSubview:view];
        
    }

    scrollContentHeight=bottom+(CustomViewH+border)*(array.count/2+array.count%2);
    self.contentSize=CGSizeMake(w, scrollContentHeight);
    self.pagingEnabled=NO;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.old=scrollView.contentOffset.x;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.new=scrollView.contentOffset.x;
        if (self.contentOffset.x>rect.size.width*(self.number-1)) {
            self.contentOffset=CGPointMake(rect.size.width, 0);
            
            self.page.currentPage=0;
//            NSLog(@"右边移动");
            return;
        }else if(self.contentOffset.x<rect.size.width)
        {
          
            self.contentOffset=CGPointMake(rect.size.width*(self.number-1), 0);
            self.page.currentPage=self.number-2;
//            NSLog(@"左边移动");
            return;
        }
    if (self.contentOffset.x==rect.size.width*(self.number-1)) {
        self.page.currentPage=0;
    }else{
    self.page.currentPage=scrollView.contentOffset.x/rect.size.width-1;
    }
    
    
    
//    if (scrollView.contentOffset.x < self.frame.size.width) {
//        [self setContentOffset:CGPointMake(self.frame.size.width * (self.array.count + 1), 0) animated:NO];
//    }
//    if (scrollView.contentOffset.x > self.frame.size.width * (self.array.count + 1)) {
//        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
//    }
//    int pageCount = scrollView.contentOffset.x / self.frame.size.width;
//    if (pageCount > self.array.count) {
//        pageCount = 0;
//    }else if (pageCount == 0){
//        pageCount = (int)self.array.count - 1;
//    }else{
//        pageCount --;
//    }
//    self.page.currentPage = pageCount;
}



@end
