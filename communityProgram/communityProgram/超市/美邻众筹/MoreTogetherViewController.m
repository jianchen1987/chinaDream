//
//  MoreTogetherViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/1/3.
//  Copyright © 2016年 高国峰. All rights reserved.
//

//static NSString *headCellIdentifire = @"headCellIdentifire";
//static NSString *footCellIdentifire = @"footCellIdentifire";
//static NSString *SectionCellIdentifire = @"sectionCellIdentifire";

static NSString *moreTogetherIdentifire = @"moreTogetherIdentifire";

#import "MoreTogetherViewController.h"
#import "UIImageView+WebCache.h"
#define pageSize    [NSNumber numberWithInteger:15]//显示多少页


@interface MoreTogetherViewController ()
{
    NSInteger pageIndex;
}
@end

@implementation MoreTogetherViewController
#pragma mark ----------------历史
-(void)rightBarButtonAction
{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"众筹";
    pageIndex=1;
    dataSource = [[NSMutableArray alloc] init];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[[NSNumber numberWithInteger:pageIndex],pageSize] WithPath:getChipByPage successBlock:^(id successJsonData) {
        NSLog(@"%@",successJsonData);
        dataSource=successJsonData;
        [myTableView reloadData];
    } errorBlock:^(int code, NSString *errorJsonData) {
        
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"众筹规划" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    UIView * headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 100)];
    

}

-(void)loadNewData
{
    NSArray *imageArr = @[@"http://pic.xcarimg.com/img/news_photo/2015/10/23/a_3MG719GijC1445553775645577144555377564.jpg",@"http://pic.xcarimg.com/img/news_photo/2015/10/23/6UPnv2Ri8C1445553798657813144555379865.jpg",@"http://pic.xcarimg.com/img/news_photo/2015/10/22/RH2q5IDN3m1445476692067529144547669206.jpg",@"http://pic.xcarimg.com/img/news_photo/2015/10/22/RH2q5IDN3m1445476692067529144547669206.jpg",@"http://pic.xcarimg.com/img/news_photo/2015/10/22/RH2q5IDN3m1445476692067529144547669206.jpg"];
    // 异步下载图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.imgsArr = [NSMutableArray array];
        for (NSString *str in imageArr) {
            NSURL *imageUrl = [NSURL URLWithString:str];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            
            if (!image) {
                UIImage *newsImage = [UIImage imageNamed:@"img"];
                [self.imgsArr addObject:newsImage];
                
            }else
            {
                [self.imgsArr addObject:image];
            }
            
        }
        
        // 当图片下载完成后，在主线程设置tableHeaderView的数据
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.loopView setLoopViewImages:self.imgsArr titles:titleArr autoPlay:YES delay:3.0];
            [self.loopView setLoopViewImages:self.imgsArr autoPlay:YES delay:3.0];
            [myTableView.header endRefreshing];
            
        });
    });
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTogetherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreTogetherIdentifire];
    if (!cell) {
        cell = [[MoreTogetherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreTogetherIdentifire];
    }
 
    NSDictionary * unit =dataSource[indexPath.row];
    NSString * imagestring=[NSString stringWithFormat:@"%@%@",AppendingImageUrl,[unit objectForKey:@"chipsIcon"]];
    [cell.leftImageView sd_setImageWithURL:[NSURL URLWithString:imagestring] placeholderImage:[UIImage imageNamed:@"cell图片"]];
    cell.titleLable.text = [unit objectForKey:@"title"];
    cell.descriptionLable.text = [unit objectForKey:@"simpleIntro"];
    cell.persentLable.text = [NSString stringWithFormat:@"支持人数%@",[unit objectForKey:@"supportNum"]];
    
    float all=[[unit objectForKey:@"descInfo"] floatValue];
    float now=[[unit objectForKey:@"chipNum"] floatValue];
    cell.progressView.progressValue=now/all*1.0;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreTogetherDetailViewController *detailVC = [MoreTogetherDetailViewController new];
    NSDictionary * unit =dataSource[indexPath.row];
    detailVC.ID=[unit objectForKey:@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
