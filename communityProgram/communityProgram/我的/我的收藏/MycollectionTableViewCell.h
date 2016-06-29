//
//  MycollectionTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

#define _COLLECTION_TABLEVIEW_CELL_HEIGHT_ 120

@interface MycollectionTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *productImageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;


@end
