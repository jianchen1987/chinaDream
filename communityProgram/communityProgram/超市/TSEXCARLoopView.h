//
//  TSELatestNewsLoopView.h
//  XCAR
//
//  Created by Morris on 9/23/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSupermarketBtn.h"
@class TSEXCARLoopView;

@protocol TSEXCARLoopViewDelegate <NSObject>
@optional
- (void)loopViewDidSelectedImage:(TSEXCARLoopView *)loopView index:(int)index;
-(void)selectIndexButton:(CustomSupermarketBtn *)sender;

@end

@interface TSEXCARLoopView : UIView

@property (nonatomic, weak) id<TSEXCARLoopViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoPlay;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSArray *images;
//@property (nonatomic, strong) NSArray *titles;
//@property(nonatomic,strong)UIView *cagroryView;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

- (void)setLoopViewImages:(NSArray *)images autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval;

@end