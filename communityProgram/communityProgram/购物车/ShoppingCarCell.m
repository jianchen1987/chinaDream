//
//  ShoppingCarCell.m
//  ShoppingCarDemo
//
//  Created by huanglianglei on 15/11/5.
//  Copyright © 2015年 huanglianglei. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "UIImageView+WebCache.h"

@implementation ShoppingCarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews
{

    
    
    self.selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectedButton.frame = CGRectMake(0, 0, 30, _ShoppingCarListCellHeight_);
    [self.selectedButton setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
    [self.selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectedButton];
    
    
    //产品图片
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.selectedButton.right, 5, _ShoppingCarListCellHeight_ - 10, _ShoppingCarListCellHeight_ - 10)];
    [self.contentView addSubview:self.shopImageView];
    
    //标题
    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right + 5, 5, DeviceWidth - self.shopImageView.width - 30 - 10, 40)];
    self.shopNameLab.numberOfLines = 2;
    self.shopNameLab.font = Font(16);
    [self.contentView addSubview:self.shopNameLab];
    
    
    //原价
    self.oldPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right + 5, _ShoppingCarListCellHeight_ - 5 - 20, 100, 20)];
    self.oldPriceLab.textColor = [UIColor grayColor];
    self.oldPriceLab.backgroundColor = [UIColor clearColor];
    self.oldPriceLab.font = Font(13);
    [self.contentView addSubview:self.oldPriceLab];
    
    
    //优惠价
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right + 5, _ShoppingCarListCellHeight_ - 5 - 20 - 20, 100, 20)];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.font = Font(16);
    [self.contentView addSubview:self.priceLab];
  
    self.addNumberView = [[AddNumberView alloc]initWithFrame:CGRectMake(DeviceWidth - 105, _ShoppingCarListCellHeight_ - 10 - 30, 95, 30)];
    self.addNumberView.delegate = self;
    self.addNumberView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.addNumberView];

}
#pragma mark --------------选择产品
-(void)selectedButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.delegate)
    {
        [self.delegate selectWithCell:self WithButtonAction:sender.selected];
    }
}

/**
 * 点击减按钮数量的减少
 *
 * @param sender 减按钮
 */
- (void)deleteBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    if (self.delegate)
    {
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }

    
}
/**
 * 点击加按钮数量的增加
 *
 * @param sender 加按钮
 */
- (void)addBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    if (self.delegate) {
        [self.delegate btnClick:self andFlag:(int)sender.tag];

    }
}




- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
