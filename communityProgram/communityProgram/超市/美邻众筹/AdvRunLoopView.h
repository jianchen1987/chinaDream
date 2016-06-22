//
//  AdvRunLoopView.h
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvRunLoopView;


@protocol TSEXCARLoopViewDelegate <NSObject>
@optional
- (void)loopViewDidSelectedAdvImage:(AdvRunLoopView *)loopView index:(int)index;

@end

@interface AdvRunLoopView : UIView


@property (nonatomic, weak) id<TSEXCARLoopViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoPlay;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSArray *images;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

- (void)setLoopViewImages:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;
@end
