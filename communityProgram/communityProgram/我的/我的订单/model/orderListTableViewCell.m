//
//  orderListTableViewCell.m
//  communityProgram
//
//  Created by 陈剑 on 16/6/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "orderListTableViewCell.h"

@implementation orderListTableViewCell

- (instancetype)initWithUpStyle:(OrderListTableViewCellUpStyle)up
                    BottomStyle:(OrderListTableViewCellBottomStyle)bottom
                reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.frame = CGRectMake(0, 0, DeviceWidth, _COMPLETEDPAYCELL_HEIGHT_);
        
        UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, _COMPLETEDPAYCELL_HEIGHT_ - 50 - 1)];
        upView.backgroundColor = [UIColor whiteColor];
        
        self.previewImgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, upView.frame.size.height - 20, upView.frame.size.height - 20)];
        [upView addSubview:self.previewImgView1];
        
        if(up == OrderListTableViewCellUpStyleNormal)
        {
            self.upTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.previewImgView1.right + 10, 20, DeviceWidth - 10 - self.previewImgView1.size.width - 10 - 10 , 20)];
            self.upTitleLabel.font = [UIFont systemFontOfSize:_TITLE_FONT_SIZE_];
            self.upTitleLabel.textColor = [UIColor blackColor];
            [upView addSubview:self.upTitleLabel];
            
            self.upDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.previewImgView1.right + 10, self.upTitleLabel.bottom + 10, self.upTitleLabel.width, 40)];
            self.upDetailsLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
            self.upDetailsLabel.textColor = [UIColor colorWithWhite:0.66 alpha:1];
            self.upDetailsLabel.numberOfLines = 2;
            [upView addSubview:self.upDetailsLabel];
        }
        else if(up == OrderListTableViewCellUpStyleMutable)
        {
            self.previewImgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.previewImgView1.right + 10, 10, upView.frame.size.height - 20, upView.frame.size.height - 20)];
            [upView addSubview:self.previewImgView2];
            
            self.previewImgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.previewImgView2.right + 10, 10, upView.frame.size.height - 20, upView.frame.size.height - 20)];
            [upView addSubview:self.previewImgView3];
            
            self.upDetailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.previewImgView3.right + 20, (upView.height - 20)/2, 100, 20)];
            self.upDetailsLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
            self.upDetailsLabel.textColor = [UIColor colorWithWhite:0.66 alpha:1];
            [upView addSubview:self.upDetailsLabel];
        }
        [self.contentView addSubview:upView];
        
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.height + 1, DeviceWidth, 50)];
        bottomView.backgroundColor = [UIColor whiteColor];
        
        if(bottom == OrderListTableViewCellBottomStyleNormal)
        {
            self.button1 = [[UIButton alloc] initWithFrame:CGRectMake((DeviceWidth/4)*1 + 5, 10, DeviceWidth/4 - 10, 30)];
            [self.button1 setTitle:@"申请退款" forState:UIControlStateNormal];
            [self.button1 setBackgroundImage:[UIImage imageNamed:@"orderlist_whiteBtn"] forState:UIControlStateNormal];
            self.button1.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
            [self.button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [bottomView addSubview:self.button1];
        }
        else if(bottom == OrderListTableViewCellBottomStylePrice)
        {
            self.costAmtLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (bottomView.height - 20)/2, 100, 20)];
            self.costAmtLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
            self.costAmtLabel.textColor = [UIColor blackColor];
            [bottomView addSubview:self.costAmtLabel];
        }
        
        
        self.button2 = [[UIButton alloc] initWithFrame:CGRectMake((DeviceWidth/4)*2 + 5, 10, DeviceWidth/4 - 10, 30)];
        [self.button2 setTitle:@"私信商家" forState:UIControlStateNormal];
        [self.button2 setBackgroundImage:[UIImage imageNamed:@"orderlist_whiteBtn"] forState:UIControlStateNormal];
        self.button2.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bottomView addSubview:self.button2];
        
        self.button3 = [[UIButton alloc] initWithFrame:CGRectMake((DeviceWidth/4)*3 + 5, 10, DeviceWidth/4 - 10, 30)];
        [self.button3 setTitle:@"确认收货" forState:UIControlStateNormal];
        [self.button3 setBackgroundImage:[UIImage imageNamed:@"orderlist_redBtn"] forState:UIControlStateNormal];
        self.button3.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
        [bottomView addSubview:self.button3];
        
        
        [self.contentView addSubview:bottomView];
        self.contentView.backgroundColor = [UIColor colorWithWhite:0.88 alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCostAmt:(NSNumber *)cost
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付:￥%@",cost]];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_] range:NSMakeRange(0, 3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
    
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_TITLE_FONT_SIZE_] range:NSMakeRange(3, str.length - 3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, str.length - 3)];
    
    self.costAmtLabel.attributedText = str;
    
}

@end
