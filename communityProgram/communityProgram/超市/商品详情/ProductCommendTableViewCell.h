//
//  ProductCommendTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModle.h"
#import "UILabel+AccordingStrngSetLableSize.h"
#import "PictureContainerView.h"
#import "UIView+SDAutoLayout.h"

@interface ProductCommendTableViewCell : UITableViewCell
@property(nonatomic,strong)CommentModle *model;

@end
