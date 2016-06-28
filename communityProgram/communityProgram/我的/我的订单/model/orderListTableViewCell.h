//
//  orderListTableViewCell.h
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,OrderListTableViewCellUpStyle)
{
    OrderListTableViewCellUpStyleNormal,
    OrderListTableViewCellUpStyleMutable
};

typedef NS_ENUM(NSUInteger,OrderListTableViewCellBottomStyle)
{
    OrderListTableViewCellBottomStyleNormal,
    OrderListTableViewCellBottomStylePrice
};

#define _COMPLETEDPAYCELL_HEIGHT_ 160.0f

@interface orderListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *previewImgView1;
@property (nonatomic, strong) UIImageView *previewImgView2;
@property (nonatomic, strong) UIImageView *previewImgView3;
@property (nonatomic, strong) UILabel *upTitleLabel;
@property (nonatomic, strong) UILabel *upDetailsLabel;
@property (nonatomic, strong) UILabel *costAmtLabel;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;

- (instancetype)initWithUpStyle:(OrderListTableViewCellUpStyle)up
                    BottomStyle:(OrderListTableViewCellBottomStyle)bottom
                reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setCostAmt:(NSNumber *)cost;

@end
