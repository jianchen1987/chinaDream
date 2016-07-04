//
//  ToRaisePublicViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/7/1.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "myCrowdFundingViewController.h"
#import "MoreTogetherTableViewCell.h"
#import "AllChipModel.h"
#import "MoreTogetherDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "CrowdFundingRequest.h"
#import "myCrowdFundingTableViewCell.h"
static NSString *myCrowdFunding = @"myCrowdFunding";

@interface myCrowdFundingViewController ()
@property(nonatomic,strong)NSMutableArray * sectionArray;
@end

@implementation myCrowdFundingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的众筹";
    [self showLoading];
    _sectionArray=[NSMutableArray array];
    [CrowdFundingRequest getAllChipHistoryRquestSuccessBlock:^(id successJsonData) {
        _sectionArray=successJsonData;
        NSLog(@"successJsonData%@",_sectionArray);
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:_sectionArray];
        [self reloadTableView];
        [self dismissShow];
    } errorBlock:^(int code, NSString *errorJsonData) {
        [self showPrompt:errorJsonData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sectionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myCrowdFundingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCrowdFunding];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"myCrowdFundingTableViewCell" owner:nil options:nil]firstObject];
    }
    
    AllChipModel * model=_sectionArray[indexPath.row];
    //    NSDictionary * unit =dataSource[indexPath.row];
    [cell.iconImageview sd_setImageWithURL:urlImage(model.chipsIcon) placeholderImage:[UIImage imageNamed:@"cell图片"]];
    cell.time_LB.text=[NSString stringWithFormat:@"期限：%@",model.expireDate];
    cell.titleName.text = model.title;
//    cell.detailTextLabel.text = model.simpleIntro;
//    cell.persentLable.text = [NSString stringWithFormat:@"支持人数%ld",(long)model.supportNum];
    
    float all=model.descInfo;
    float now=model.chipNum;
    
    cell.progress.progressValue=now/all*1.0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTogetherDetailViewController *detailVC = [MoreTogetherDetailViewController new];
    detailVC.model=_sectionArray[indexPath.row];
    //    NSDictionary * unit =dataSource[indexPath.row];
    //    detailVC.ID=[unit objectForKey:@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
