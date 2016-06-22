//
//  CustomPublishImageView.m
//  communityProgram
//
//  Created by xiaogao on 16/2/21.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CustomPublishImageView.h"

@implementation CustomPublishImageView
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(self.width-12.5, -12.5, 25, 25);
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"community_publish_delete"] forState:0];
        _deleteButton.layer.cornerRadius = 9;
        _deleteButton.clipsToBounds = YES;
        [_deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_deleteButton];
        
    }
    return self;
}
-(void)setButtonTag
{
    [_deleteButton setTag:self.tag];
}
-(void)deleteButtonAction:(UIImageView *)sender
{
    if (self.delegate) {
        [self.delegate deleteButtonIndex:self];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
