//
//  ComfirmOrderViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "ComfirmOrderViewController.h"

@interface ComfirmOrderViewController ()

@end

@implementation ComfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:myTableView];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addressIdentifire = @"addressIdentifire";
    static NSString *orderSectionIdentife = @"orderSectionIdentife";
    
    AddressTableViewCell *addressCell = [tableView dequeueReusableCellWithIdentifier:addressIdentifire];
    OrderSectionTableViewCell *orderCell = [tableView dequeueReusableCellWithIdentifier:orderSectionIdentife];
    if (indexPath.section == 0) {
        
        if (!addressCell) {
            addressCell = [[AddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressIdentifire];
        }
        
        addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return addressCell;

    }else
    {
        if (!orderCell) {
            orderCell = [[OrderSectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderSectionIdentife];
        }
        orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return orderCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }else
    return 220;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
