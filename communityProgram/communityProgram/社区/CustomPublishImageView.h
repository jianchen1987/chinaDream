//
//  CustomPublishImageView.h
//  communityProgram
//
//  Created by xiaogao on 16/2/21.
//  Copyright © 2016年 高国峰. All rights reserved.
//
@protocol CustomPublishImageDelegate <NSObject>

-(void)deleteButtonIndex:(UIImageView *)button;


@end
#import <UIKit/UIKit.h>

@interface CustomPublishImageView : UIImageView
@property(nonatomic,strong)UIButton *deleteButton;
@property(nonatomic,assign)id <CustomPublishImageDelegate> delegate;
-(void)setButtonTag;

@end
