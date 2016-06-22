//
//  NeighborAskViewController.m
//  communityProgram
//
//  Created by xiaogao on 15/12/12.
//  Copyright © 2015年 高国峰. All rights reserved.
//

#import "NeighborAskViewController.h"

@interface NeighborAskViewController ()

@end

@implementation NeighborAskViewController



-(void)loadData
{
    NSArray *params = @[@"35ba59d6-c5f3-497d-9a81-3e466977ffec",@0,@0,@0,@10,@"neartalk",@1];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:params WithPath:GetNearAsksOrTalkPath successBlock:^(id successJsonData) {
        NSLog(@"successJsonData = %@",successJsonData);
        NSMutableArray *muArray = successJsonData;
        if (muArray.count)
        {
            for (NSDictionary *dic in muArray) {
                NSLog(@"dic = %@",dic);
                NSMutableArray *imformationArray = [NSMutableArray array];
                
                NeighborModel *model = [[NeighborModel alloc] init];
                model.userImageUrl = [dic valueForKey:@"userImage"];
                model.userName = [[dic valueForKey:@"user"] valueForKey:@"nickName"];
                model.userSex = [[dic valueForKey:@"user"] valueForKey:@"gender"];
                model.createTime = [dic valueForKey:@"createTime"];
                model.quarterName = [dic valueForKey:@"quarterName"];
                model.remark = [dic valueForKey:@"remark"];
                NSLog(@"model.remark = %@",model.remark);
                NSMutableArray *imageArray = [NSMutableArray array];
                for (NSDictionary *imageDic in [dic valueForKey:@"nearAskLogos"])
                {
                    [imageArray addObject:[AppendingImageUrl stringByAppendingString:[imageDic valueForKey:@"imageLogo"]]];
                }
                model.images = imageArray;
                [imformationArray addObject:model];
                [dataSource addObject:imformationArray];
                [myTableView reloadData];
            }
        }else
        {
            NSLog(@"暂无数据");
        }
        
    } errorBlock:^(int code, NSString *errorJsonData)
     {
        NSLog(@"errorJsonData = %@",errorJsonData);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [[NSMutableArray alloc] init];
    [self loadData];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-49-40) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    UIView *selectHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 40)];
    selectHeadView.backgroundColor = RGBA(231, 231, 231, 1);
    NSArray *selectHeadTitleArray = @[@"只看本小区",@"只看未解决"];
    for (int i = 0; i < 2; i++) {
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectButton.frame = CGRectMake(DeviceWidth/2*i, 10, DeviceWidth/2, 20);
        selectButton.tag = 1000+i;
        [selectButton setImage:[UIImage imageNamed:@"vertification_non"] forState:0];
        [selectButton setImage:[UIImage imageNamed:@"vertification_select"] forState:UIControlStateSelected];
        [selectButton setTitle:selectHeadTitleArray[i] forState:0];
        [selectButton setTitleColor:[UIColor grayColor] forState:0];
        selectButton.titleLabel.font = Font(12);
        selectButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [selectButton addTarget:self action:@selector(selectAdictionAction:) forControlEvents:UIControlEventTouchUpInside];
        [selectHeadView addSubview:selectButton];
    }
    
    myTableView.tableHeaderView = selectHeadView;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *neighborAskIdentifire = @"neighborAskCell";
    NeiborTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:neighborAskIdentifire];
    if (!cell) {
        cell = [[NeiborTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:neighborAskIdentifire];
    }

    cell.model = dataSource[indexPath.section][indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    id model = dataSource[indexPath.section][indexPath.row];
    return [myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[NeiborTableViewCell class] contentViewWidth:DeviceWidth-40];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [myTableView beginUpdates];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [myTableView endUpdates];
}
#pragma mark ------------只看本小区，只看未解决
-(void)selectAdictionAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
}


- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
