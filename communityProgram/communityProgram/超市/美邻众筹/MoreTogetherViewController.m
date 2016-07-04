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
#import "CrowdFundingView.h"
#import "MoreTogetherViewController.h"
#import "UIImageView+WebCache.h"
#import "PictureCarouselScrollView.h"
#import "AllChipModel.h"
#import "AllChipLogoModel.h"
#import "CrowdFundingRequest.h"
#import "ToRaisePublicViewController.h"
#import "myCrowdFundingViewController.h"
#define pageSize    [NSNumber numberWithInteger:15]//显示多少页


@interface MoreTogetherViewController ()<PictureCarouselDelegate>
{
    NSInteger pageIndex;
}
@property(nonatomic,strong)NSArray * allChipLogo_array;
@end

@implementation MoreTogetherViewController
#pragma mark ----------------历史
-(void)rightBarButtonAction
{
   
}
-(void)PictureCarouselSelectImageViewNumber:(NSInteger)number{
    MoreTogetherDetailViewController *detailVC = [MoreTogetherDetailViewController new];
    detailVC.model=_allChipLogo_array[number];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"众筹";
  
    pageIndex=1;
    dataSource = [[NSMutableArray alloc] init];
    [self showLoading];
    [CrowdFundingRequest getChipByPagerquest:pageIndex successBlock:^(id successJsonData) {
        [dataSource addObjectsFromArray:successJsonData];
        [self dismissShow];
        [self.dataSource addObject:successJsonData];

        [self.tableView reloadData];
    } errorBlock:^(int code, NSString *errorJsonData) {
        [self showPrompt:errorJsonData];
    }];
    
//    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[[NSNumber numberWithInteger:pageIndex],pageSize] WithPath:getChipByPage successBlock:^(NSArray*  successJsonData) {
//        NSLog(@"%@",successJsonData);
////        dataSource=successJsonData;
//        [dataSource addObjectsFromArray:successJsonData];
//        [self.tableView reloadData];
//        [self.dataSource addObject:successJsonData];
//    } errorBlock:^(int code, NSString *errorJsonData) {
//        
//    }];
    
   
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"众筹规划" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
    
    
    
    
    
    UIView * headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceWidth/2+70)];
    
    PictureCarouselScrollView * pic=[[PictureCarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceWidth/2)];

    pic.PictureDelegate=self;
    [self showLoading];
    [CrowdFundingRequest getAllChipBannerRquestSuccessBlock:^(NSArray* successJsonData) {
        _allChipLogo_array=successJsonData;
        NSMutableArray * logo=[NSMutableArray array];
        for (int i=0; i<successJsonData.count; i++) {
            AllChipLogoModel * model=successJsonData[i];
            [logo addObject:imageString(model.imageLogo)];
        }
        pic.page.frame=CGRectMake(0, DeviceWidth/2-20, DeviceWidth, 20);
//        MoreTogetherDetailViewController *detailVC = [MoreTogetherDetailViewController new];
////        detailVC.model=dataSource[indexPath.row];
//        //    NSDictionary * unit =dataSource[indexPath.row];
//        //    detailVC.ID=[unit objectForKey:@"id"];
//        [self.navigationController pushViewController:detailVC animated:YES];
        

        [pic Viewframe:CGRectMake(0, 0, DeviceWidth, DeviceWidth/2) andViewAllimage:logo andChangeTime:10];
        [headView addSubview:pic];
        [headView addSubview: pic.page];
        [self dismissShow];
    } errorBlock:^(int code, NSString *errorJsonData) {
        [self showPrompt:errorJsonData];
    }];
    
    
    
    
    UIView * secondView=[[UIView alloc]initWithFrame:CGRectMake(0, DeviceWidth/2,DeviceWidth, 70)];
    CrowdFundingView* one=[[[NSBundle mainBundle]loadNibNamed:@"CrowdFundingView" owner:nil options:nil]lastObject];
    one.iconImageView.image=[UIImage imageNamed:@"往期众筹"];
    [secondView addSubview:one];
    one.frame=CGRectMake(0, 0, secondView.getWidth/2, 70);
    
    CrowdFundingView* two=[[[NSBundle mainBundle]loadNibNamed:@"CrowdFundingView" owner:nil options:nil]lastObject];
    two.action=^{
        myCrowdFundingViewController * to=[myCrowdFundingViewController new];
        [self.navigationController pushViewController:to animated:YES];

    };
    one.action=^{
        ToRaisePublicViewController * to=[ToRaisePublicViewController new];
        [self.navigationController pushViewController:to animated:YES];

    };
    two.iconImageView.image=[UIImage imageNamed:@"我的众筹"];
    one.name.text=@"往期众筹";
    two.name.text=@"我的众筹";
    one.detaile.text=@"查看往期众筹情况";
    two.detaile.text=@"查看众筹进行情况";
    [secondView addSubview:two];
    two.frame=CGRectMake(secondView.getWidth/2,0,  secondView.getWidth/2, 70);
    [headView addSubview:secondView];
    self.tableView.tableHeaderView=headView;

}
- (void)pullDown:(_Nonnull id)sender{
}
- (void)pullUp:(_Nonnull id)sender{
    
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
 
    AllChipModel * model=dataSource[indexPath.row];
//    NSDictionary * unit =dataSource[indexPath.row];
    [cell.leftImageView sd_setImageWithURL:urlImage(model.chipsIcon) placeholderImage:[UIImage imageNamed:@"cell图片"]];
    cell.titleLable.text = model.title;
    cell.descriptionLable.text = model.simpleIntro;
    cell.persentLable.text = [NSString stringWithFormat:@"支持人数 %ld",(long)model.supportNum];
    
    float all=model.descInfo;
    float now=model.chipNum;
    
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
    detailVC.model=dataSource[indexPath.row];
//    NSDictionary * unit =dataSource[indexPath.row];
//    detailVC.ID=[unit objectForKey:@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            [self.tableView.header endRefreshing];
            
        });
    });
}
@end
