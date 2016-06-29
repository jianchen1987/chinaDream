//
//  AllCagroryViewController.h
//  communityProgram
//
//  Created by xiaogao on 16/2/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "BaseViewController.h"
#import "TSEXCARLoopView.h"
#import "CustomSupermarketBtn.h"
#import "CagroryListDetailViewController.h"
@interface AllCagroryViewController : BaseViewController
{
    NSMutableArray *dataSource;
    
}
@property(nonatomic,strong)NSMutableArray *imgsArr;
@property(nonatomic,strong)TSEXCARLoopView *loopView;
@end
