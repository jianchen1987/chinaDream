//
//  NeiborTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 15/12/20.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomAdotView.h"
#import "NeighborModel.h"
#import "PictureContainerView.h"
#import "UIView+SDAutoLayout.h"
#import "PictureDobbleContainerView.h"
#import "NSMutableAttributedString+Emoji.h"
#import "NSString+Emoji.h"
#import "UILabel+AccordingStrngSetLableSize.h"
@interface NeiborTableViewCell : UITableViewCell
@property(nonatomic,strong)NeighborModel *model;


//-(void)caculateCellHeight:(NSDictionary *)dic;
@end
