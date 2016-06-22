//
//  GetCommunityViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/10.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "GetCommunityViewController.h"

@interface GetCommunityViewController ()
{
    NSString *quarterID;
}
@end

@implementation GetCommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"小区选择";
    dataSource = [[NSMutableArray alloc] init];
    searchDataSouce = [[NSMutableArray alloc] init];
    
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.showsVerticalScrollIndicator = NO;
    myTableView.tableHeaderView = mySearchBar;
    [self.view addSubview:myTableView];
    [self initMysearchBarAndMysearchDisPlay];

    [self loadCommunityData];
}
-(void)initMysearchBarAndMysearchDisPlay
{
    mySearchBar = [[UISearchBar alloc] init];
    mySearchBar.delegate = self;
    //设置选项
    [mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [mySearchBar sizeToFit];
    mySearchBar.backgroundColor = RGBA(249,249,249,1);
//    mySearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:mySearchBar.bounds.size];
    //加入列表的header里面
    myTableView.tableHeaderView = mySearchBar;
    
    mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
    mySearchDisplayController.delegate = self;
    mySearchDisplayController.searchResultsDataSource = self;
    mySearchDisplayController.searchResultsDelegate = self;
}
-(void)loadCommunityData
{
    NSArray *array = @[];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:GetQuartersPath successBlock:^(id successJsonData) {
        NSLog(@"successJsonData = %@",successJsonData);
        NSMutableArray *array = successJsonData;
        if (array.count) {
            dataSource = array;
        }
        [myTableView reloadData];
        
        
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);

    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *getCommunityIdentifire = @"getCommunityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:getCommunityIdentifire];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:getCommunityIdentifire];
    }
    cell.textLabel.text = [dataSource[indexPath.row] valueForKey:@"quarterName"];
    cell.textLabel.textColor = RGBA(50, 50, 50, 1);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth,40)];
    backView.backgroundColor = RGBA(240, 240, 240, 1);
    
    UILabel *lable = [RHMethods labelWithFrame:CGRectMake(10, 10, DeviceWidth-20, 20) font:Font(15) color:RGBA(153, 153, 153, 1) text:@"所有小区"];
    [backView addSubview:lable];
    return  backView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = dataSource[indexPath.row];
    quarterID = [dic valueForKey:@"id"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"是否确认选择%@",[dic valueForKey:@"quarterName"]] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == alertView.cancelButtonIndex)
    {
        return;
    }else
    {
        NSArray *array = @[[self.userDic valueForKey:@"id"],quarterID];
        [NetworkEngine postRequestWithUrl:AppService paramsArray:array WithPath:SetQuaterPath successBlock:^(id successJsonData)
        {
            NSLog(@"successJsonData = %@",successJsonData);
            [Utility saveToDefaults:quarterID forKey:@"quarterID"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } errorBlock:^(int code, NSString *errorJsonData) {
            NSLog(@"errorJsonData = %@",errorJsonData);
            [NetworkEngine showHUDString:errorJsonData Withshowtime:2 WithView:self.view];

        }];
    }
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
