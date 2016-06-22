//
//  CustomTextView.m
//  communityProgram
//
//  Created by xiaogao on 16/2/22.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setPlaceholder:@"请输入少于300字的内容"];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
//        self.layer.borderColor = kTextBorderColor.CGColor;
        self.placeholderColor = RGBA(153, 153, 153, 1);
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}
-(UILabel *)placeHolderLabel{
    if(_placeHolderLabel==nil){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 20,30)];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.font = self.font;
        label.textColor = self.placeholderColor;
        label.hidden = NO;
        [label sizeToFit];
        _placeHolderLabel = label;
        [self addSubview:_placeHolderLabel];
    }
    [self sendSubviewToBack:_placeHolderLabel];
    _placeHolderLabel.text = self.placeholder;
    return _placeHolderLabel;
}
//- (void)textChanged:(NSNotification *)notification{
//    
//    if ([[self text] length] == 0) {
//        self.placeHolderLabel.hidden = NO;
//    }
//    else{
//        self.placeHolderLabel.hidden = YES;
//    }
//    
//}
-(void)layoutSubviews{
    self.placeHolderLabel.frame = CGRectMake(10, 3, self.bounds.size.width, 30);
}


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
