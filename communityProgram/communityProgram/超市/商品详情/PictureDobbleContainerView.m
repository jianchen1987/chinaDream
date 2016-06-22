//
//  PictureDobbleContainerView.m
//  communityProgram
//
//  Created by xiaogao on 16/2/20.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "PictureDobbleContainerView.h"
#import "UIView+SDAutoLayout.h"

#import "SDPhotoBrowser.h"

@interface PictureDobbleContainerView () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation PictureDobbleContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 6; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
//    self.imageView1 = [UIImageView new];
//    self.imageView1.userInteractionEnabled = YES;
//    self.imageView1.tag = 0;
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
//    [self.imageView1 addGestureRecognizer:tap1];
//    [temp addObject:self.imageView1];
//    [self addSubview:self.imageView1];
//    
//    self.imageView2 = [UIImageView new];
//    self.imageView2.userInteractionEnabled = YES;
//    self.imageView2.tag = 1;
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
//    [self.imageView2 addGestureRecognizer:tap2];
//    [temp addObject:self.imageView2];
//    [self addSubview:self.imageView2];
//    
//    self.imageView3 = [UIImageView new];
//    self.imageView3.userInteractionEnabled = YES;
//    self.imageView3.tag = 2;
//    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
//    [self.imageView3 addGestureRecognizer:tap3];
//    [temp addObject:self.imageView3];
//    [self addSubview:self.imageView3];
//    
//    
//    self.imageView4 = [UIImageView new];
//    self.imageView4.userInteractionEnabled = YES;
//    self.imageView4.tag = 3;
//    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
//    [self.imageView4 addGestureRecognizer:tap4];
//    [temp addObject:self.imageView4];
//    [self addSubview:self.imageView4];
//    
//    self.imageView5 = [UIImageView new];
//    self.imageView5.userInteractionEnabled = YES;
//    self.imageView5.tag = 4;
//    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
//    [self.imageView5 addGestureRecognizer:tap5];
//    [temp addObject:self.imageView5];
//    [self addSubview:self.imageView5];
//    
//    
//    self.imageView6 = [UIImageView new];
//    self.imageView6.userInteractionEnabled = YES;
//    self.imageView6.tag = 5;
//    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
//    [self.imageView6 addGestureRecognizer:tap6];
//    [temp addObject:self.imageView6];
//    [self addSubview:self.imageView6];

    self.imageViewsArray = [temp copy];
}


- (void)setPicturesArray:(NSArray *)picturesArray
{
    _picturesArray = picturesArray;
    NSLog(@"picturesArray = %@",picturesArray);
    for (long i = _picturesArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }

    
    if (_picturesArray.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = [self itemWidthForPicPathArray:_picturesArray];
    CGFloat itemH = 0;
    if (_picturesArray.count == 1) {
        UIImage *image = [UIImage imageNamed:_picturesArray.firstObject];
        if (image.size.width) {
            itemH = image.size.height / image.size.width * itemW;
        }
    } else {
        itemH = itemW;
    }
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picturesArray];
    CGFloat margin = 10;
    
   
    
    [_picturesArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        }];
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
    }];
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picturesArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width = w;
    self.height = h;
    
    self.fixedHeight = @(h);
    self.fixedWith = @(w);
}


- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picturesArray.count;
    browser.delegate = self;
    [browser show];
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if (array.count == 1) {
        return 120;
    } else {
        CGFloat w = (DeviceWidth-40)/3;
        return w;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picturesArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}


@end
