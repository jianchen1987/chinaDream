//
//  CustomAdotView.h
//  communityProgram
//
//  Created by xiaogao on 16/1/19.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAdotView : UIView

-(id)initWithFrame:(CGRect)frame WithData:(NSDictionary *)dicData;

@property(nonatomic,strong)UIImageView *adoptImageView;
@property(nonatomic,strong)UIImageView *adoptHeadImageView;
@property(nonatomic,strong)UILabel *adoptNameLable;
@property(nonatomic,strong)UILabel *adoptContentLable;


-(void)setAdoptViewData:(NSDictionary *)dic;
@end
