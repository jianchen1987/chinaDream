//
//  ZFscrollView.h
//  scrollView
//
//  Created by 谢泽锋 on 15/7/22.
//  Copyright (c) 2015年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureCarouselScrollView : UIScrollView<UIScrollViewDelegate>
@property(nonatomic,strong)NSString * imagePlaceName;
@property(nonatomic,strong)UIPageControl * page;


/**
 * frame 插入图片的大小
 * imgeaArray 图片数组
 * changeTime 多长时间跳转
 * view 需要添加到哪个视图中
 */
-(void)Viewframe:(CGRect)frame
              andViewAllimage:(NSArray*)imageArray
                andChangeTime:(NSInteger)changeTime
                       object:(UIView*)view;



-(void)Viewframe:(CGRect)frame
 andViewAllimage:(NSArray*)imageArray
   andChangeTime:(NSInteger)changeTime;

-(void)Viewframe:(CGRect)frame
 andViewAllimageView:(NSArray*)imageArray
   andChangeTime:(NSInteger)changeTime
          object:(UIView*)view;


/**
 * array  所有视图数组
 * border 左右边距
 *center  中间距离
 * bottom  上下间距
 * height 单位视图的高度
 */
-(void)array:(NSArray * )array
      border:(NSInteger)border
      center:(NSInteger)center
       Bount: (float)bottom
  viewHeight:(float)height;
@end
