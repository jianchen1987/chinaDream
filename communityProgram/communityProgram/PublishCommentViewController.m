//
//  PublishCommentViewController.m
//  communityProgram
//
//  Created by 谢泽锋 on 16/6/26.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import "PublishCommentViewController.h"
#import "BaseViewController.h"
#import "CustomPublishImageView.h"
#import "VIPhotoView.h"
#import "CustomTextView.h"
#import "NSString+Emoji.h"
#import "NSMutableAttributedString+Emoji.h"
#import "PublishCommunityViewController.h"
#import "TZImagePickerController.h"
#import "CoreEmotionView.h"
#import "NSArray+SubArray.h"
#import "EmotionModel.h"
#import "NSString+EmotionExtend.h"
#import "UITextView+Emotion.h"

@interface PublishCommentViewController ()<UITextViewDelegate,CustomPublishImageDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    
    NSInteger photoCount;
    
    UIView *bottomView;
    UIScrollView *myScrollView;
    
    
    UILabel *textLable;
    
}
//@property(nonatomic,strong)CustomTextView *myTextView;
@property(nonatomic,strong) UITextView *myTextView;
@property (nonatomic,strong) CoreEmotionView *emotionView;
@property (nonatomic,assign) NSUInteger curve;

@property (nonatomic,assign) CGFloat time;
@end

@implementation PublishCommentViewController
-(void)leftButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark ----------------------发布
-(void)rightBarButtonAction
{
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i = 0; i < _selectedPhotos.count; i++) {
        NSData *imageData = UIImageJPEGRepresentation(_selectedPhotos[i], 0.05);
        NSString *baseImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [muArray addObject:baseImageStr];
    }
    NSLog(@"self.emotionView.textView.attributedText = %@",self.emotionView.textView.attributedText);
    
    
    NSArray *params  = @[self.user.identifyName,muArray,self.emotionView.textView.attributedText.emotionNormalText,@"neartalk"];
    
    [NetworkEngine postRequestWithUrl:AppService paramsArray:params WithPath:PublishAskorTalkPath successBlock:^(id successJsonData) {
        NSLog(@"successJsonData = %@",successJsonData);
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"errorJsonData = %@",errorJsonData);
    }];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     * 发布二手闲置｜超市产品｜众筹｜免费试吃的评论
     * @param orderId 订单唯一id type==supermarket 或者==integralstore才需要传orderId
     * @param userId 用户唯一id
     * @param commentId 上一个评论id  这个是针对二手闲置才需要有回复功能，才需要回复的时候传入，超市产品｜众筹｜免费试吃的评论不需要传入
     * @param commentInfo 评论信息|或者追加评论
     * @param typeId 对应类型的唯一id
     * @param type 类型   二手闲置评论(secondhand) | 超市产品评论(supermarket) 众筹产品评论(allchip) 免费试吃评论(freeeat) 积分商城（integralstore）
     * @param imageBase64 图片base64的集合 (默认不传入评论图片可为空值)
     **/
//    	public boolean publishCommentByType(String orderId, String userId, String commentId, String commentInfo, String typeId, String type, List<String> imageBase64);
    UIImage * image =[UIImage imageNamed:@"cell图片"];
    NSData *mydata=UIImageJPEGRepresentation(image , 0.4);
 
    NSString *pictureDataString=[mydata base64EncodedStringWithOptions:0];
    NSArray * arr= @[
                     @"",
                     self.user.identifyName,
                     @"",            //commentId
                     @"commentInfo",//评论信息
                     self.model.id,//typeId 对应类型的唯一id
                     freeeat, //type 类型
                     @[pictureDataString],
                     ];

    [NetworkEngine postRequestWithUrl:AppService paramsArray:arr WithPath:@"publishCommentByType" successBlock:^(id successJsonData) {
        NSLog(@"%@",successJsonData);
    } errorBlock:^(int code, NSString *errorJsonData) {
        NSLog(@"%@",errorJsonData);
    }];
   [NetworkEngine postImageRequestWithUrl:AppService paramsArray:arr  WithImage:@[] WithPath:@"publishCommentByType" WithFileName:@"订单" successBlock:^(id successJsonData, NSString *massege) {
       
       NSLog(@"%@",successJsonData);
   } errorBlock:^(int code, id errorJsonData) {
       [self showPrompt:errorJsonData];
   }];
    self.title = @"发布评论";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction)];
    UIButton * rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 75, 27)];
    rightButton.layer.cornerRadius=6;
    rightButton.layer.borderWidth=0.01;
    rightButton.backgroundColor=RGBA(132, 132, 132, 1);
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * right= [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonAction)];
   UIBarButtonItem * right= [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
    self.myTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, DeviceWidth-10, 100)];
    self.myTextView.font = PublishFont;
    self.myTextView.textColor = RGBA(200, 200, 200, 1);
    //    self.myTextView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:nil];
    [self.view addSubview:self.myTextView];
    
    
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, DeviceHeight-140-64, DeviceWidth, 140)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    //视图准备
    [self viewPrepare];
    
    //事件
    [self event];
    
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, 90)];
    myScrollView.delegate = self;
    [myScrollView setContentSize:CGSizeMake(70*6+12*6+20, 80)];
    
    [bottomView addSubview:myScrollView];
    
    
    
    
//    NSArray *imageArray = @[@"community_publish_selectPicture",@"community_publish_face",@"community_publish_@"];
      NSArray *imageArray = @[@"community_publish_selectPicture",@"community_publish_face"];
    for (int i = 0; i < 2; i++) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(40*i, bottomView.height-40, 40, 40);
        [leftButton setImage:[UIImage imageNamed:imageArray[i]] forState:0];
        leftButton.tag = 8400+i;
        [leftButton addTarget:self action:@selector(leftButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:leftButton];
    }
    

}
#pragma mark ----------------selectButtonAction
-(void)leftButtonTouchAction:(UIButton *)sender
{
    if (sender.tag == 8400) {
        
        NSInteger selectNumber = 0;
        if (photoCount == 0) {
            selectNumber = 6;
        }else if(photoCount == 1)
        {
            selectNumber = 5;
            
        }else if(photoCount == 2)
        {
            selectNumber = 4;
        }else if(photoCount == 3)
        {
            selectNumber = 3;
        }else if(photoCount == 4)
        {
            selectNumber = 2;
        }else if(photoCount == 5)
        {
            selectNumber = 1;
        }
        
        if (photoCount < 6)
        {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:selectNumber delegate:self];
            
            // You can get the photos by block, the same as by delegate.
            // 你可以通过block或者代理，来得到用户选择的照片.
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
                NSLog(@"photoCount = %ld",(long)photoCount);
                
            }];
            
            //设置是否可以选择视频/原图
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }else
        {
            NSLog(@"最多只能选择6张");
        }
        
        
    }else if(sender.tag == 8401)
    {
        [self.myTextView resignFirstResponder];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.myTextView.inputView=self.myTextView.inputView?nil:self.emotionView;
            [self.myTextView becomeFirstResponder];
        });
    }
}

#pragma mark TZImagePickerControllerDelegate

/// 用户点击了取消
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    
}

/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets{
    [_selectedPhotos addObjectsFromArray:photos];
    [self addView];
}
-(void)addView
{
    for (UIImageView *view in myScrollView.subviews) {
        [view removeFromSuperview];
    }
    photoCount = _selectedPhotos.count;
    
    for (int i = 0; i < _selectedPhotos.count; i++) {
        CustomPublishImageView *cusImageView = [[CustomPublishImageView alloc] initWithFrame:CGRectMake(70*i+12*i+10, 15, 70, 70)];
        cusImageView.image = _selectedPhotos[i];
        cusImageView.layer.cornerRadius = 4;
        cusImageView.userInteractionEnabled = YES;
        cusImageView.delegate = self;
        cusImageView.tag = 3000+i;
        [cusImageView setButtonTag];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [cusImageView addGestureRecognizer:tap];
        [myScrollView addSubview:cusImageView];
        
    }
}
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    UIImageView *senderImageView = (UIImageView *)tap.view;
    
    if (senderImageView.image) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        UIPageControl *pageController = [[UIPageControl alloc] initWithFrame:[window bounds]];
        pageController.backgroundColor = [UIColor blackColor];
        
        UIScrollView *mainScroll = [[UIScrollView alloc] initWithFrame:[window bounds]];
        mainScroll.delegate = self;
        mainScroll.contentSize = CGSizeMake([window bounds].size.width * _selectedPhotos.count, [window bounds].size.height);
        mainScroll.pagingEnabled=YES;
        mainScroll.tag = 2;
        mainScroll.contentOffset = CGPointMake(DeviceWidth*(senderImageView.tag-3000), 0);
        [pageController addSubview:mainScroll];
        [window addSubview:pageController];
        
        
        UILabel *choiceLable = [[UILabel alloc] initWithFrame:CGRectMake(DeviceWidth/2-40, 44, 80, 30)];
        choiceLable.tag = 40000;
        choiceLable.text = [NSString stringWithFormat:@"%ld/%ld",(senderImageView.tag-3000)+1,(unsigned long)_selectedPhotos.count];
        choiceLable.font = Font(20);
        choiceLable.layer.cornerRadius = 10;
        choiceLable.textColor = [UIColor whiteColor];
        choiceLable.backgroundColor = [UIColor clearColor];
        [choiceLable.layer setBorderWidth:0.1];
        [choiceLable setTextAlignment:NSTextAlignmentCenter];
        [pageController addSubview:choiceLable];
        
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMoreImage:)];
        [pageController addGestureRecognizer:tap];
        
        for (int i = 0; i < _selectedPhotos.count; i++)
        {
            VIPhotoView *photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(DeviceWidth*i, 0, DeviceWidth, DeviceHeight) andImage:[_selectedPhotos objectAtIndex:i]];
            photoView.autoresizingMask = (1 << 6) -1;
            [mainScroll addSubview:photoView];
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 2) {
        CGPoint point = scrollView.contentOffset;
        int currentPage=(int)fabs(point.x/DeviceWidth);
        UILabel *lbl = (UILabel *)[self.view.window viewWithTag:40000];
        lbl.text = [NSString stringWithFormat:@"%d/%lu",currentPage+1,(unsigned long)_selectedPhotos.count];
    }
    
}
-(void)hideMoreImage:(UITapGestureRecognizer *)sender
{
    UIPageControl *pageContro =(UIPageControl *) sender.view;
    [UIView animateWithDuration:0.3 animations:^{
        pageContro.alpha=0;
    } completion:^(BOOL finished) {
        [pageContro removeFromSuperview];
    }];
}

#pragma mark -----------------删除选中的图片
-(void)deleteButtonIndex:(UIImageView *)button
{
    for (UIImageView *imageView in myScrollView.subviews) {
        if (imageView.tag == button.tag) {
            [imageView  removeFromSuperview];
            [_selectedPhotos removeObjectAtIndex:button.tag-3000];
        }
    }
    photoCount = _selectedPhotos.count;
    [self addView];
}


#pragma mark ---------------自定义键盘
/*
 *  事件
 */
-(void)event{
    
    //删除按钮点击事件
    __weak typeof(self) weakSelf=self;
    self.emotionView.deleteBtnClickBlock=^(NSMutableString *contentStr, NSMutableArray *modelArr){
        if([contentStr length] <= 0){
            return;
        }
        //字符串末尾
        NSInteger length = [contentStr length] - 1;
        
        //字符串末尾位置
        NSRange range = NSMakeRange(length, 1);
        
        //获取末尾位置字符串
        NSString *lastStr = [contentStr substringWithRange:range];
        
        if ([lastStr isEqualToString:@"]"]) {
            //新浪,小浪花表情
            
            //获取[的位置
            NSRange biaoqingRang = [contentStr rangeOfString:@"[" options:NSBackwardsSearch];
            
            //获取[]长度
            NSInteger biaoqingLength = range.location - biaoqingRang.location;
            
            //重置删除的range
            range = NSMakeRange(length - biaoqingLength, biaoqingLength + 1);
            
        }else if ([lastStr intValue] < 0x1F600 || [lastStr intValue] > 0x1F64F) {
            //系统表情
            
            //重置删除的range
            range = NSMakeRange(length - 1, 2);
        }
        weakSelf.emotionView.textView.attributedText = nil;
        [contentStr deleteCharactersInRange:range];
        for (int i = 0; i < modelArr.count ; i++) {
            EmotionModel *model = modelArr[i];
            [weakSelf.emotionView.textView insertEmotionWithModel:model];
        }
        //        [weakSelf.myTextView deleteBackward];
    };
}

-(void)viewPrepare{
    
    self.emotionView.textView=self.myTextView;
    
    //设置代理
    self.myTextView.delegate=self;
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNoti:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:nil];
}


/*
 *  响应通知
 */
-(void)keyboardWillChangeFrameNoti:(NSNotification *)noti{
    
    NSDictionary *dict=noti.userInfo;
    
    //获取时间
    if(_time==0){
        NSTimeInterval time=[dict[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        _time=time;
    }
    
    //动画曲线
    if(_curve==0){
        NSUInteger curve=[dict[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        _curve=curve;
    }
    
    
    //键盘高度
    CGFloat keyboardH=[dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    //执行动画
    [UIView animateWithDuration:_time animations:^{
        
        //曲线
        [UIView setAnimationCurve:_curve];
        
        bottomView.transform=CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

/*
 *  键盘即将退下
 */
-(void)keyboardWillHide{
    
    //执行动画
    [UIView animateWithDuration:_time animations:^{
        
        //曲线
        [UIView setAnimationCurve:_curve];
        
        bottomView.transform=CGAffineTransformIdentity;
    }];
}

-(CoreEmotionView *)emotionView{
    
    if(_emotionView==nil){
        _emotionView = [CoreEmotionView emotionView];
    }
    
    return _emotionView;
}
-(void)textChanged
{
    NSString *str = self.emotionView.textView.attributedText.emotionNormalText;
    NSLog(@"str = %@",self.emotionView.textView.attributedText);
    NSLog(@"文字改变了");
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"a a  a a a  a");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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


