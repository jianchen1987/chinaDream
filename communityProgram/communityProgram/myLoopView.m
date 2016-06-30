//
//  myLoopView.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "myLoopView.h"

#define kPageH 20

@interface myLoopView()<UIScrollViewDelegate>
{
    CGFloat advertiseHeight; //广告图的高度
}

@property (nonatomic, strong) NSMutableArray *currentImages;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *placeHodlerView;

@end

@implementation myLoopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, DeviceWidth, frame.size.height)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:[UIImage imageNamed:@"loopViewHolderImage"]];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        advertiseHeight = frame.size.height;
        self.placeHodlerView = imageView;
        self.scrollView.userInteractionEnabled = YES;
        [self addPageControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imageUrls:(NSArray *)imageUrls autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval {
    self = [super initWithFrame:frame];
    if (self) {
        _autoPlay = isAuto;
        _timeInterval = timeInterval;
        _imageUrls = imageUrls;
        _currentPage = 0;
        [self addPageControl];
        [self addScrollView];
        
        if (_autoPlay == YES) {
            [self toPlay];
        }
    }
    return self;
}

- (void)setLoopViewImageUrls:(NSArray *)imageUrls autoPlay:(BOOL)isAuto delay:(NSTimeInterval)timeInterval {
    _autoPlay = isAuto;
    _timeInterval = timeInterval;
    _imageUrls = imageUrls;
    _currentPage = 0;
    
    [self addScrollView];
    [self addPageControl];
    
    if (self.autoPlay == YES) {
        [self toPlay];
    }
}

#pragma mark - Public Methods
/**
 *  添加pageControl
 */
- (void)addPageControl {
    CGFloat height = advertiseHeight;
    CGFloat width = self.frame.size.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, height-kPageH, width, kPageH)];
    //    bgView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5];
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(width/2-width / 6, 0, width / 3, kPageH)];
    pageControl.numberOfPages = self.imageUrls.count;
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = NO;
    [pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    pageControl.pageIndicatorTintColor=[UIColor grayColor];
    self.pageControl = pageControl;
    
    [bgView addSubview:self.pageControl];
    
    [self addSubview:bgView];
}

#pragma mark - Private Methods
- (void)toPlay{
    [self performSelector:@selector(autoPlayToNextPage) withObject:nil afterDelay:_timeInterval];
}

- (void)autoPlayToNextPage {
    //    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoPlayToNextPage) object:nil];
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * 2, 0) animated:YES];
    [self performSelector:@selector(autoPlayToNextPage) withObject:nil afterDelay:_timeInterval];
}

- (NSMutableArray *)currentImages {
    if (_currentImages == nil) {
        _currentImages = [[NSMutableArray alloc] init];
    }
    [_currentImages removeAllObjects];
    // 获取当前图片数量
    NSInteger count = self.imageUrls.count;
    int i = (int)(_currentPage + count - 1) % count;
    [_currentImages addObject:self.imageUrls[i]];
    [_currentImages addObject:self.imageUrls[_currentPage]];
    i = (int)(_currentPage + 1) % count;
    [_currentImages addObject:self.imageUrls[i]];
    return _currentImages;
}
- (void)addScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, advertiseHeight)]; //self.bounds
    NSLog(@"advertiseHeight = %f",advertiseHeight);
    CGFloat width = self.frame.size.width;
    CGFloat height = advertiseHeight;
    for (int i = 1; i < 4; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i-1) * width, 0, width, height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.currentImages[i-1]] placeholderImage:[UIImage imageNamed:@"loopViewHolderImage"]];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
    }
    scrollView.contentSize = CGSizeMake(3 * width, height);
    scrollView.contentOffset = CGPointMake(width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    [scrollView addGestureRecognizer:tap];
    
    
    
    [self addSubview:scrollView];
    _scrollView = scrollView;
}
- (void)refreshImages {
    
    [self.placeHodlerView removeFromSuperview];
    NSMutableArray *imageViewArr = [NSMutableArray array];
    for (UIView *view in self.scrollView.subviews)
    {
        if ([view isKindOfClass:[UIImageView class]]) {
            [imageViewArr addObject:view];
        }
    }
    
    for (int i = 0; i < imageViewArr.count; i++)
    {
        UIImageView *imageView = (UIImageView *)imageViewArr[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.currentImages[i]] placeholderImage:[UIImage imageNamed:@"loopViewholderImage"]];
//        imageView.image = [UIImage imageNamed:@"zhanwei2_1"];
//        imageView.image = self.currentImages[i];
        
    }
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    
}
#pragma mark - delegate
- (void)singleTapped:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(loopViewDidSelectedImage:index:)]) {
        [self.delegate loopViewDidSelectedImage:self index:_currentPage];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    CGFloat width = self.frame.size.width;
    if (x >= 2 * width) {
        _currentPage = (++_currentPage) % self.imageUrls.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
    if (x <= 0) {
        _currentPage = (int)(_currentPage + self.imageUrls.count - 1)%self.imageUrls.count;
        self.pageControl.currentPage = _currentPage;
        [self refreshImages];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
}



@end


