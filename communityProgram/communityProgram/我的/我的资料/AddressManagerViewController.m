//
//  AddressManagerViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/27.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "AddressManagerViewController.h"
#import "addressViewModel.h"
#import "addressModifyViewController.h"
#import "AddressManagerTableViewCell.h"

@interface AddressManagerViewController ()

@end

@implementation AddressManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"收获地址管理";
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.frame = CGRectMake(0, 0, DeviceWidth, DeviceHeight - kNAVIGATION_HEIGHT - kSTATUSBAR_HEIGHT - 40 - 20);
    
    UIButton *newAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newAddressBtn.frame = CGRectMake((DeviceWidth - 280)/2, DeviceHeight - kNAVIGATION_HEIGHT - kSTATUSBAR_HEIGHT - 40 - 10, 280, 40);
    [newAddressBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [newAddressBtn setBackgroundImage:[UIImage imageNamed:@"最大按钮"] forState:UIControlStateNormal];
    
    [newAddressBtn addTarget:self action:@selector(newAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newAddressBtn];
    
    self.tableView.header = nil;
    self.tableView.footer = nil;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reflushAddress];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *addressManagerIdentifire = @"addressManagerCell";
    addressModel *model = [self.dataSource objectAtIndex:indexPath.row];
    AddressManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addressManagerIdentifire];
    if (!cell)
    {
        cell = [[AddressManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressManagerIdentifire];
    }
    cell.nameLable.text = model.sendName;
    cell.phoneLable.text = model.phone;
    if(model.isDefault)
    {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[默认]%@",model.levelRoom]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, 4)];
        cell.addressLable.attributedText = str;
    }
    else
    {
        cell.addressLable.text = model.levelRoom;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    addressModel *model = [self.dataSource objectAtIndex:indexPath.row];
    addressModifyViewController *vc = [[addressModifyViewController alloc] init];
    vc.addressModel = model;
    vc.newOrModify = NO;
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}



- (void)newAddress:(id)sender
{
    addressModifyViewController *vc = [[addressModifyViewController alloc] init];
    vc.newOrModify = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)reflushAddress
{
    [self showLoading];
    [addressManagerViewModel getUserReceiveAddressesByUserId:self.user.identifyName
                                                SuccessBlock:^(NSArray *address)
    {
        [self dismissShow];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:address];
        [self.tableView reloadData];
     }
                                                FailureBlock:^(int errCode, NSString *errMsg)
    {
        [self dismissShow];
     }];
}

@end
