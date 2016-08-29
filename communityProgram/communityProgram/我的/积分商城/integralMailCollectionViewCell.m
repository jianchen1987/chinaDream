//
//  integralMailCollectionViewCell.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "integralMailCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface integralMailCollectionViewCell()
{
    UIImageView *_previewImgView;
    UIImageView *_coverImgView;
    
    UILabel *_titleLabel;
    myLabel *_exchangeTypeLabel;
    UILabel *_priceLabel;
    UILabel *_peopleCntLabel;
}

@end

@implementation integralMailCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        CGFloat cellWidth  = frame.size.width;
        CGFloat cellHeight = frame.size.height;
        self.contentView.backgroundColor = [UIColor whiteColor];
        _previewImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight - 100)];
        [self.contentView addSubview:_previewImgView];
        
        _coverImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight - 100)];
        _coverImgView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_coverImgView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, _previewImgView.bottom + 5, cellWidth - 10, 40)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_titleLabel];
        
        _exchangeTypeLabel = [[myLabel alloc] initWithText:@"积商品兑换方式" FontSize:_DETAIL_FONT_SIZE_ - 1 MaxWidth:cellWidth - 10];//initWithFrame:CGRectMake(10, self.titleLabel.bottom + 5, cellWidth/2 - 10, 20)];
        _exchangeTypeLabel.frame = CGRectMake(10, _titleLabel.bottom + 5, _exchangeTypeLabel.frame.size.width, 20);
        _exchangeTypeLabel.textAlignment = NSTextAlignmentCenter;
        _exchangeTypeLabel.textColor = [UIColor whiteColor];
        _exchangeTypeLabel.backgroundColor = [UIColor blueColor];
        _exchangeTypeLabel.layer.cornerRadius = 3;
        _exchangeTypeLabel.clipsToBounds = YES;
        [self.contentView addSubview:_exchangeTypeLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _exchangeTypeLabel.bottom + 2, cellWidth/2 - 10, 20)];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        _priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:_priceLabel];
        
        _peopleCntLabel = [[UILabel alloc] initWithFrame:CGRectMake(cellWidth/2 + 5, _exchangeTypeLabel.bottom + 2, cellWidth/2 - 10, 20)];
        _peopleCntLabel.textAlignment = NSTextAlignmentRight;
        _peopleCntLabel.font = [UIFont systemFontOfSize:_DETAIL_FONT_SIZE_];
        _peopleCntLabel.textColor = [UIColor colorWithWhite:0.66 alpha:1];
        [self.contentView addSubview:_peopleCntLabel];
        
    }
    return self;
}

- (void)setPreviewImageUrl:(NSString *)previewImageUrl
{
    [_previewImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",previewImageUrl]] placeholderImage:[UIImage imageNamed:@"myself_collection"]];
}

- (void)setCoverImageUrl:(NSString *)coverImageUrl
{
    [_coverImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",coverImageUrl]] placeholderImage:[UIImage imageNamed:@"myself_collection"]];
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setExchangeType:(NSString *)exchangeType
{
    switch (exchangeType.intValue) {
        case 0:
        {
            _exchangeTypeLabel.text = @"可积分+金额";
            _exchangeTypeLabel.backgroundColor = [UIColor colorWithRed:75/255.0 green:105/255.0 blue:250/255.0 alpha:1];
        }
            break;
        case 1:
        {
            _exchangeTypeLabel.text = @"只限积分兑换";
            _exchangeTypeLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:135/255.0 blue:20/255.0 alpha:1];
        }
            break;
        case 2:
        {
            _exchangeTypeLabel.text = @"只限积分+金额";
            _exchangeTypeLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:75/255.0 blue:50/255.0 alpha:1];
        }
            break;
            
        default:
            break;
    }
}

- (void)setPrice:(NSString *)price
{
    _priceLabel.text = price;
}

- (void)setPeopleCnt:(NSString *)peopleCnt
{
    _peopleCntLabel.text = peopleCnt.intValue > 9999? @"已兑换9999+" : [NSString stringWithFormat:@"已兑换%@",peopleCnt];
}



@end
