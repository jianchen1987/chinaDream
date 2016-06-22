//
//  ProductDetailTableViewCell.h
//  communityProgram
//
//  Created by xiaogao on 16/1/9.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+AccordingStrngSetLableSize.h"
#import "AddNumberView.h"
#import "AdditionSubtractionControl.h"
@interface ProductDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *productTitleLable;
@property(nonatomic,strong)UILabel *productDescriptionLable;
@property(nonatomic,strong)UILabel *productPriceLable;
@property(nonatomic,strong)UILabel *productDiscountLable;
@property(nonatomic,strong)UILabel *productBuyNumberLable;
//@property(nonatomic,strong)AddNumberView *numberView;
@property(nonatomic,strong)UILabel *descriptionLable;
@property(nonatomic,strong)AdditionSubtractionControl * AdditionSubtraction;
-(void)loadCellData:(NSDictionary *)dic;

@end
