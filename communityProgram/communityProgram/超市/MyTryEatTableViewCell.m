//
//  MyTryEatTableViewCell.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/21.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "MyTryEatTableViewCell.h"

@implementation MyTryEatTableViewCell
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    _history.layer.borderWidth= _comment.layer.borderWidth=0.01;
    _history.layer.cornerRadius= _comment.layer.cornerRadius=4;
    [_history setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_comment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

   
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}
-(void)setIsComment:(BOOL)isComment{
    if (isComment) {
        [_comment setTitle:@"查看评论" forState:UIControlStateNormal];
        
    }else {
        [_comment setTitle:@"立即评论" forState:UIControlStateNormal];
        [_comment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _comment.backgroundColor=[UIColor redColor];
    }
}
- (IBAction)delete:(id)sender {

    self.delete();
}
- (IBAction)find:(id)sender {
    self.Mcommont();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
