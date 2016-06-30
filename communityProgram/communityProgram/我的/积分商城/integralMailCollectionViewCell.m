//
//  integralMailCollectionViewCell.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "integralMailCollectionViewCell.h"


@implementation integralMailCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        CGFloat cellWidth  = frame.size.width;
        CGFloat cellHeight = frame.size.height;
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.previewImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight - 100)];
        [self.contentView addSubview:self.previewImgView];
        
        self.coverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight - 100)];
        self.coverImgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.coverImgView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.previewImgView.bottom + 5, cellWidth - 10, 40)];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.titleLabel];
        
        self.exchangeTypeLabel = [[myLabel alloc] initWithText:@"只限积分兑换" FontSize:_DETAIL_FONT_SIZE_ MaxWidth:cellWidth/2 - 10];//initWithFrame:CGRectMake(10, self.titleLabel.bottom + 5, cellWidth/2 - 10, 20)];
        self.exchangeTypeLabel.frame = CGRectMake(10, self.titleLabel.bottom + 5, self.exchangeTypeLabel.frame.size.width, 20);
        self.exchangeTypeLabel.textAlignment = NSTextAlignmentCenter;
        self.exchangeTypeLabel.font = [UIFont systemFontOfSize:_DETAIL_FONT_SIZE_];
        self.exchangeTypeLabel.textColor = [UIColor whiteColor];
        self.exchangeTypeLabel.backgroundColor = [UIColor blueColor];
        self.exchangeTypeLabel.layer.cornerRadius = 3;
        self.exchangeTypeLabel.clipsToBounds = YES;
        [self.contentView addSubview:self.exchangeTypeLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.exchangeTypeLabel.bottom + 2, cellWidth/2 - 10, 20)];
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        self.priceLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];
        
        self.peopleCntLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth/2 + 5, self.exchangeTypeLabel.bottom + 2, cellWidth/2 - 10, 20)];
        self.peopleCntLabel.textAlignment = NSTextAlignmentRight;
        self.peopleCntLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        self.peopleCntLabel.textColor = [UIColor colorWithWhite:0.66 alpha:1];
        [self.contentView addSubview:self.peopleCntLabel];
        
    }
    return self;
}

@end
