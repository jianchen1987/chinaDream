//
//  myLoopView.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@class myLoopView;

@protocol MyLoopViewDelegate <NSObject>
@optional
- (void)loopViewDidSelectedImage:(myLoopView *)loopView index:(int)index;

@end

@interface myLoopView : UIView

@property (nonatomic, weak) id<MyLoopViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoPlay;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSArray *imageUrls;
//@property (nonatomic, strong) NSArray *titles;
//@property(nonatomic,strong)UIView *cagroryView;

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imagesUrls autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

- (void)setLoopViewImageUrls:(NSArray *)imageUrls autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;


@end
