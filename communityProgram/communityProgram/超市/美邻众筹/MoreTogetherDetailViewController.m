//
//  MoreTogetherDetailViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/2.
//  Copyright © 2016年 高国峰. All rights reserved.
//
#import "SelectBar.h"
#import "MJRefreshBackGifFooter.h"
#import "MoreTogetherDetailViewController.h"
#import "DetaiHeadView.h"
#import "UpImageButton.h"
#import "UIView+Getlength.h"
#import "PictureCarouselScrollView.h"
#import "MJRefreshGifHeader.h"
#import "MJRefreshAutoNormalFooter.h"
@interface MoreTogetherDetailViewController ()
@property(nonatomic,strong)DetaiHeadView * detailHeadView;
@property(nonatomic,strong)UIView  * headView;
@property(nonatomic,strong)NSDictionary * Information;
@property(nonatomic,strong)PictureCarouselScrollView * Picture_Scroll ;
@property(nonatomic,strong)UIView * TooMoreView;
@property(nonatomic,strong)UIButton * TooMore_BT ;

/**
 *  底部
 */
@property (nonatomic,strong) UIView *bottomView;

/** 商品详情整体 */
@property(strong,nonatomic)UIScrollView *scrollView;


/** 第二页 */
@property (nonatomic, strong) UIView *twoPageView;
/** 网页 */
@property (strong,nonatomic)  UIWebView *webView;
/***评论table***/
@property (strong,nonatomic)  UITableView *commentTableView;
@property(nonatomic,strong) SelectBar *secondTopView;
@end

@implementation MoreTogetherDetailViewController
@synthesize Picture_Scroll;
-(void)GetComment
{
    /**
     *  用户id
     *  类型的唯一id
     *  pageIndex 当前页码数
     *   pageSize 显示数量
     *
     */
    
    
    NSArray * array=@[self.user.id,_ID,allchip,@1,@4];
    [NetworkEngine postRequestWithUrl:AppService paramsArray:array  WithPath:getComment successBlock:^(id successJsonData)
     {
         for (NSDictionary *dic in successJsonData) {
             CommentModle *modle = [CommentModle new];
             NSDictionary * user=[dic objectForKey:@"user"];
             
             modle.commentHeadImageUrl = [dic valueForKey:@"headIcon"];
             modle.commentName = [user valueForKey:@"nickName"];//名字
             modle.commentTime = [dic valueForKey:@"createTime"];//评论时间
             modle.commentContent = [dic valueForKey:@"commentInfo"];//评论信息
             
             if ([dic valueForKey:@"appendComment"]) {
                 modle.addDic=[NSDictionary dictionaryWithObjectsAndKeys:
                               [user valueForKey:@"nickName"],@"nickName",
                               //                              @"2016-1-13",@"time",
                               [dic valueForKey:@"appendComment"],@"comment", nil];
                 NSLog(@"%@",[dic valueForKey:@"appendComment"]);
             }
             
             //            modle.addDic = [dic valueForKey:@"other"];
             //            modle.picNamesArray =@[@"/resource/admin/quarterLogo/83b6678f-b6cd-479d-94f9-b7a585c5808c.jpg",@"/resource/admin/quarterLogo/83b6678f-b6cd-479d-94f9-b7a585c5808c.jpg"];
             [dic valueForKey:@"commentLogos"];//图片数组
             [commentDataSource addObject:modle];
         }
         [myTableView reloadData];
         
     } errorBlock:^(int code, NSString *errorJsonData) {
     }];
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.secondTopView.frame), DeviceWidth, DeviceHeight - 100)];
    }
    return _webView;
}
-(UITableView *)commentTableView
{
    if (!_commentTableView) {
        
        _commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.secondTopView.frame), myTableView.width, myTableView. height - self.secondTopView.height) style:UITableViewStyleGrouped];
        _commentTableView.delegate = self;
        _commentTableView.dataSource = self;
    }
    return _commentTableView;
}

-(UIView *)secondTopView
{
    if (!_secondTopView) {
        
        _secondTopView = [[SelectBar alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 50)];
        _secondTopView.backgroundColor = [UIColor whiteColor];
        
        [_secondTopView creatTitle: @[@"图文详情",@"评价晒单"] color:RGBA(148,148,148,1) selectColor:RGBA(77,195,5,1) frame:CGRectMake(0, 0, DeviceWidth, 50)];
        __weak typeof(self) weakself = self;

        _secondTopView.SelectBarClick=^(NSInteger number){
            
            if (number==0) {
                weakself.webView.hidden = NO;
                weakself.commentTableView.hidden = YES;
                [weakself.twoPageView addSubview:weakself.webView];
            }else if (number==1)
            {
                weakself.webView.hidden = YES;
                weakself.commentTableView.hidden = NO;
                [weakself.twoPageView addSubview:weakself.commentTableView];
            }
 
        };
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, DeviceWidth, 1)];
//        lineView.backgroundColor = RGBA(240, 240, 240, 1);
//        [_secondTopView addSubview:lineView];
//        
//        NSArray *titleArr = @[@"图文详情",@"评价晒单"];
//        for (int i = 0; i < 2; i++) {
//            UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            secondButton.frame = CGRectMake(DeviceWidth/2*i, 0, DeviceWidth/2, 50);
//            [secondButton setTitle:titleArr[i] forState:0];
//            [secondButton setTitleColor:[UIColor blackColor] forState:0];
//            [secondButton addTarget:self action:@selector(secondButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//            [_secondTopView addSubview:secondButton];
//            
//        }
    }
    return _secondTopView;
}
-(void)secondButtonAction:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"图文详情"]) {
        self.webView.hidden = NO;
        self.commentTableView.hidden = YES;
        [self.twoPageView addSubview:self.webView];
    }else if ([sender.titleLabel.text isEqualToString:@"评价晒单"])
    {
        self.webView.hidden = YES;
        self.commentTableView.hidden = NO;
        [self.twoPageView addSubview:self.commentTableView];
    }
    
}
- (void)configureRefresh {
    // 动画时间
    CGFloat duration = 0.3f;
    
    // 1.设置 UITableView 上拉显示商品详情
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.height);
        } completion:^(BOOL finished) {
            [myTableView.footer endRefreshing];
        }];
    }];
    footer.automaticallyHidden = NO; // 关闭自动隐藏(若为YES，cell无数据时，不会执行上拉操作)
    footer.stateLabel.backgroundColor =myTableView.footer.backgroundColor;
    [footer setTitle:@"继续拖动，查看图文" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStatePulling];
    [footer setTitle:@"松开，即可查看图文详情" forState:MJRefreshStateRefreshing];
    myTableView.footer = footer;
    
    
    // 2.设置 UIWebView 下拉显示商品详情
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //设置动画效果
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            //结束加载
            [self.webView.scrollView.header endRefreshing];
        }];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置文字、颜色、字体
    [header setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [header setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];
    self.webView.scrollView.header = header;

    _webView.backgroundColor=[UIColor clearColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];

    [self.webView loadHTMLString:[self.Information  objectForKey:@"imageText"] baseURL:nil];
    

    // 3.设置 UICollectionView 下拉显示商品详情
    MJRefreshGifHeader *dHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [self.commentTableView.header endRefreshing];
        }];
    }];
    dHeader.lastUpdatedTimeLabel.hidden = YES;
    [dHeader setTitle:@"下拉，返回商品简介" forState:MJRefreshStateIdle];
    [dHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStatePulling];
    [dHeader setTitle:@"释放，返回商品简介" forState:MJRefreshStateRefreshing];

    self.commentTableView.header = dHeader;
    
    
   
}

#pragma mark - 第二页
- (UIView *)twoPageView {
    if (!_twoPageView) {
        _twoPageView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myTableView.frame), myTableView.width, myTableView.height)];
    }
    return _twoPageView;
}
-(void)creatView{
    dataSource = [[NSMutableArray alloc] init];
    commentDataSource = [[NSMutableArray alloc] init];
    
    [self GetComment];
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight-64-50) style:UITableViewStyleGrouped];
    myTableView.tableHeaderView=_headView;
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, DeviceHeight-64-45, DeviceWidth, 45)];
    bottomView.backgroundColor = RGBA(213, 213, 213, 1);
    [self.view addSubview:bottomView];
    
    UpImageButton * Collection=[[UpImageButton alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth/5, 45)];
    [Collection setTitle:@"收藏" forState:UIControlStateNormal];
    [Collection setImage:[UIImage imageNamed:@"商品详情收藏"] forState:UIControlStateNormal];
    [bottomView addSubview:Collection];
    
    UpImageButton * share_BT=[[UpImageButton alloc]initWithFrame:CGRectMake( Collection.getW_X+1,0, DeviceWidth/5, 45)];
    [share_BT setTitle:@"分享" forState:UIControlStateNormal];
    [share_BT setImage:[UIImage imageNamed:@"分享-社区首页"] forState:UIControlStateNormal];
    [bottomView addSubview:share_BT];
    UIButton * sure=[[UIButton alloc]initWithFrame:CGRectMake(share_BT.getW_X, 0, DeviceWidth*3/5, 45)];
    sure.backgroundColor=[UIColor redColor];
    [sure setTitle:@"我要支持" forState:UIControlStateNormal];
    [bottomView addSubview:sure];
    [sure addTarget:self action:@selector(joinButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    joinButton.frame = CGRectMake(0, 0, DeviceWidth, 50);
//    [joinButton setBackgroundColor:[UIColor redColor]];
//    [joinButton setTitle:@"我要参与" forState:0];
//    [joinButton setTitleColor:[UIColor whiteColor] forState:0];
//    [joinButton addTarget:self action:@selector(joinButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [bottomView addSubview:joinButton];
    
//    //虚拟数据
//    NSMutableArray *muArray = [NSMutableArray array];
//    NSArray *image1Arr = @[@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg"];
//    NSArray *image2Arr = @[@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg",@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg"];
//    NSArray *image3Arr = @[@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg",@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg",@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg",@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg",@"http://img.taopic.com/uploads/allimg/140714/234975-140G4155Z571.jpg"];
//    NSArray *image4Arr = @[];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"image",image4Arr,@"imageArr",@"小明",@"name",@"2016-1-13",@"time",@"不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手",@"comment", nil];
//    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"image",image1Arr,@"imageArr",@"小明",@"name",@"2016-1-13",@"time",@"不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手",@"comment", nil];
//    
//    NSDictionary *secondDic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"image",image2Arr,@"imageArr",@"小明",@"name",@"2016-1-13",@"time",@"不负家人众望，实至名归，苹果香，脆，甜，喜欢的赶紧下手不负家望，实至名归，苹果香，脆，甜，喜欢的赶紧下手",@"comment",[NSDictionary dictionaryWithObjectsAndKeys:@"",@"image",@"小明",@"name",@"2016-1-13",@"time",@"不负脆，甜，喜欢的赶紧下手",@"comment", nil],@"other", nil];
//    [muArray addObject:dic];
//    [muArray addObject:dic1];
//    [muArray addObject:secondDic];
//    
//    for (NSDictionary *dic in muArray) {
//        CommentModle *modle = [CommentModle new];
//        modle.commentHeadImageUrl = [dic valueForKey:@"image"];
//        modle.commentName = [dic valueForKey:@"name"];
//        modle.commentTime = [dic valueForKey:@"time"];
//        modle.commentContent = [dic valueForKey:@"comment"];
//        modle.addDic = [dic valueForKey:@"other"];
//        modle.picNamesArray = [dic valueForKey:@"imageArr"];
//        [commentDataSource addObject:modle];
//    }

}
#pragma mark - Lazy Methods
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceHeight - kSTATUSBAR_NAVIGATION_HEIGHT - kTOOLHEIGHT)];
        _scrollView.contentSize = CGSizeMake(DeviceWidth, (DeviceHeight - kSTATUSBAR_NAVIGATION_HEIGHT) * 2);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"产品详情";
    
    _headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, 260+DeviceWidth/2)];
    
    _TooMoreView = [[UIView alloc] initWithFrame:CGRectMake(0, 220+DeviceWidth/2, DeviceWidth, 40)];
    [_headView addSubview:_TooMoreView];
    _TooMore_BT = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, DeviceWidth-10, 20)];
    _TooMore_BT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_TooMore_BT setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
  
    _TooMoreView.backgroundColor=[UIColor whiteColor];
    [_TooMoreView addSubview:_TooMore_BT];
    
    
    
    Picture_Scroll=[[PictureCarouselScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceWidth, DeviceWidth/2)];
   Picture_Scroll.imagePlaceName=@"专题";
    [_headView addSubview:Picture_Scroll];
    _detailHeadView=[[[NSBundle mainBundle]loadNibNamed:@"DetaiHeadView" owner:nil options:nil]lastObject];
    __weak typeof(self) weakself=self;
    
    _detailHeadView.ClickDetail=^{
        [UIView animateWithDuration:0.5 animations:^{
              weakself.scrollView.contentOffset = CGPointMake(0, weakself.scrollView.height);
        }];
     
    };
    [_headView addSubview:_detailHeadView];

    _detailHeadView.frame=CGRectMake(0, DeviceWidth/2, DeviceWidth, 220);
    [NetworkEngine postRequestWithUrl:AppService paramsArray:@[self.ID] WithPath:getChipById successBlock:^(NSDictionary* successJsonData) {
        NSArray * imageArr=[successJsonData objectForKey:@"allChipBanners"];
        NSMutableArray * imageArray=[NSMutableArray array];
        for (int i=0; i<imageArr.count; i++) {
            NSString * name=[NSString stringWithFormat:@"%@%@",AppendingImageUrl,imageArr[i]];
            [imageArray addObject:name];
        }
 
      [Picture_Scroll Viewframe:CGRectMake(0, 0, DeviceWidth, DeviceWidth/2) andViewAllimage:imageArray andChangeTime:1];
        _detailHeadView.titleName.text=[successJsonData objectForKey:@"title"];
        NSString * stirng=[NSString stringWithFormat:@"已筹到:%@斤",[successJsonData objectForKey:@"chipNum"]];
        _detailHeadView.descInfo.attributedText=[self AttributedString: stirng  image:@"已筹到"];
        _detailHeadView.price.attributedText= [self AttributedString:[NSString stringWithFormat:@"¥%@/斤",[successJsonData objectForKey:@"price"]] rangeString:@"/斤" color: [UIColor grayColor]];
        _detailHeadView.supportNum.attributedText= [self AttributedString:[NSString stringWithFormat:@"已有%@人支持", [successJsonData objectForKey:@"supportNum"]] image:@"人数" ];
        _detailHeadView.chipNum.attributedText=[self AttributedString: [NSString stringWithFormat:@"项目目标%@斤",  [successJsonData objectForKey:@"chipNum"]]image:@"项目目标"];
        _detailHeadView.detaiData.text= [successJsonData objectForKey:@"simpleIntro"];
        _Information=successJsonData;
        
        NSNumber * number=[_Information objectForKey:@"commentPeople"];
        if ([number intValue]>0 ) {
            [_TooMore_BT setTitle:[NSString stringWithFormat:@"查看全部评论%@",number ] forState:UIControlStateNormal];
            
        }else{
            [_TooMore_BT setTitle:[NSString stringWithFormat:@"无人评论评论"] forState:UIControlStateNormal];
            _TooMore_BT.enabled=NO;
        }
        [myTableView reloadData];
    } errorBlock:^(int code, NSString *errorJsonData) {

    }];
    
     [self creatView];
     [self addSubView];
     [self configureRefresh];

}


- (void)addSubView{
    [self.view  addSubview:self.scrollView];
    [self.scrollView  addSubview:myTableView];
    [self.scrollView  addSubview:self.twoPageView];
    [self.twoPageView addSubview:self.webView];
    [self.twoPageView addSubview:self.secondTopView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return commentDataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *commendIdentifire = @"commendIdentifire";

        ProductCommendTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:commendIdentifire];
        if (!secondCell) {
            secondCell = [[ProductCommendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commendIdentifire];
        }
        secondCell.model = commentDataSource[indexPath.row];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return secondCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 10)];
    backView.backgroundColor = RGBA(240, 240, 240, 1);
    return backView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        id model = commentDataSource[indexPath.row];
        return [myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ProductCommendTableViewCell class] contentViewWidth:DeviceWidth-40];
}


#pragma mark ------------------------------我要参与
-(void)joinButtonAction
{
    [self.navigationController pushViewController:[ComfirmOrderViewController new] animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
