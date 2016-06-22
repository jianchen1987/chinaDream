//
//  MyTryEatTableViewCell.h
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/21.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Delete)();
typedef void(^Commont)();
@interface MyTryEatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Myimage;
@property (weak, nonatomic) IBOutlet UILabel *mytitle;
@property (weak, nonatomic) IBOutlet UILabel *mycount;
@property (weak, nonatomic) IBOutlet UILabel *mytime;
@property(nonatomic,assign)BOOL isComment;

@property (weak, nonatomic) IBOutlet UIButton *history;
@property (weak, nonatomic) IBOutlet UIButton *comment;

@property(nonatomic,copy)Delete delete;
@property(nonatomic,copy)Commont Mcommont;
@end
//@protocol MyTryEatTableDelegte <NSObject>
//
//-(void)MyTrydelete:(NSInteger)row;
//-(void)MyTryGotoComment:(NSInteger)row;
//-(void)MyTryFindComment:(NSInteger)row;
//
//@end