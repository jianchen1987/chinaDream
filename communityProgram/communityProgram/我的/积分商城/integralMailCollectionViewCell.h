//
//  integralMailCollectionViewCell.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myLabel.h"

@interface integralMailCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong, setter = setPreviewImageUrl:) NSString *previewImageUrl;
@property (nonatomic, strong, setter = setCoverImageUrl:)   NSString *coverImageUrl;
@property (nonatomic, strong, setter = setTitle:)           NSString *title;
@property (nonatomic, strong, setter = setExchangeType:)    NSString *exchangeType;
@property (nonatomic, strong, setter = setPrice:)           NSString *price;
@property (nonatomic, strong, setter = setPeopleCnt:)       NSString *peopleCnt;



@end
