//
//  WMPageController.m
//  WMPageController
//
//  Created by Mark on 15/6/11.
//  Copyright (c) 2015年 yq. All rights reserved.
//

#import "WMPageController.h"
#import "WMPageConst.h"

@interface WMPageController () <WMMenuViewDelegate,UIScrollViewDelegate> {
    CGFloat _viewHeight;
    CGFloat _viewWidth;
    CGFloat _viewX;
    CGFloat _viewY;
    CGFloat _targetX;
    BOOL    _animate;
    
    
}
@property (nonatomic, strong, readwrite) UIViewController *currentViewController;
@property (nonatomic, weak) WMMenuView *menuView;
@property (nonatomic, weak) UIScrollView *scrollView;
// 用于记录子控制器view的frame，用于 scrollView 上的展示的位置
@property (nonatomic, strong) NSMutableArray *childViewFrames;
// 当前展示在屏幕上的控制器，方便在滚动的时候读取 (避免不必要计算)
@property (nonatomic, strong) NSMutableDictionary *displayVC;
// 用于记录销毁的viewController的位置 (如果它是某一种scrollView的Controller的话)
@property (nonatomic, strong) NSMutableDictionary *posRecords;
// 用于缓存加载过的控制器
@property (nonatomic, strong) NSCache *memCache;
// 收到内存警告的次数
@property (nonatomic, assign) int memoryWarningCount;
@property(nonatomic,assign)BOOL show;
@end

@implementation WMPageController
@synthesize selectedPhotos;

#pragma mark - Lazy Loading
- (NSMutableDictionary *)posRecords {
    if (_posRecords == nil) {
        _posRecords = [[NSMutableDictionary alloc] init];
    }
    return _posRecords;
}

- (NSMutableDictionary *)displayVC {
    if (_displayVC == nil) {
        _displayVC = [[NSMutableDictionary alloc] init];
    }
    return _displayVC;
}

#pragma mark - Public Methods
- (instancetype)initWithViewControllerClasses:(NSArray *)classes andTheirTitles:(NSArray *)titles WithShowMenu:(BOOL)show {
    if (self = [super init])
    {
        NSAssert(classes.count == titles.count, @"classes.count != titles.count");
        _viewControllerClasses = [NSArray arrayWithArray:classes];
        _titles = [NSArray arrayWithArray:titles];
        _show = show;
        self.selectedPhotos = [NSMutableArray array];
        [self setup];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setCachePolicy:(WMPageControllerCachePolicy)cachePolicy {
    _cachePolicy = cachePolicy;
    self.memCache.countLimit = _cachePolicy;
}

- (void)setItemsMargins:(NSArray *)itemsMargins {
    NSAssert(itemsMargins.count == self.viewControllerClasses.count + 1, @"item's margin's number must equal to viewControllers's count + 1");
    _itemsMargins = itemsMargins;
}

- (void)setItemsWidths:(NSArray *)itemsWidths {
    NSAssert(itemsWidths.count == self.titles.count, @"itemsWidths.count != self.titles.count");
    _itemsWidths = [itemsWidths copy];
}

- (void)setSelectIndex:(int)selectIndex {
    _selectIndex = selectIndex;
    if (self.menuView) {
        [self.menuView selectItemAtIndex:selectIndex];
    }
}

- (void)setViewFrame:(CGRect)viewFrame {
    _viewFrame = viewFrame;
    if (self.menuView) {
        [self viewDidLayoutSubviews];
    }
}

#pragma mark - Private Methods

// 当子控制器init完成时发送通知
- (void)postAddToSuperViewNotificationWithIndex:(int)index {
    if (!self.postNotification) return;
    NSDictionary *info = @{
                           @"index":@(index),
                           @"title":self.titles[index]
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:WMControllerDidAddToSuperViewNotification
                                                        object:info];
}

// 当子控制器完全展示在user面前时发送通知
- (void)postFullyDisplayedNotificationWithCurrentIndex:(int)index {
    if (!self.postNotification) return;
    NSDictionary *info = @{
                           @"index":@(index),
                           @"title":self.titles[index]
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:WMControllerDidFullyDisplayedNotification
                                                        object:info];
}

// 初始化一些参数，在init中调用
- (void)setup {
    _titleSizeSelected  = WMTitleSizeSelected;
    _titleColorSelected = WMTitleColorSelected;
    _titleSizeNormal    = WMTitleSizeNormal;
    _titleColorNormal   = WMTitleColorNormal;
    
    _menuBGColor   = WMMenuBGColor;
    _menuHeight    = WMMenuHeight;
    _menuItemWidth = WMMenuItemWidth;
    
    _memCache = [[NSCache alloc] init];
}

// 包括宽高，子控制器视图 frame
- (void)calculateSize {
    if (CGRectEqualToRect(self.viewFrame, CGRectZero)) {
        _viewWidth = self.view.frame.size.width;
        _viewHeight = self.view.frame.size.height - self.menuHeight;
    } else {
        _viewWidth = self.viewFrame.size.width;
        _viewHeight = self.viewFrame.size.height - self.menuHeight;
    }
    _viewX = self.viewFrame.origin.x;
    _viewY = self.viewFrame.origin.y;
    // 重新计算各个控制器视图的宽高
    _childViewFrames = [NSMutableArray array];
    for (int i = 0; i < self.viewControllerClasses.count; i++) {
        CGRect frame = CGRectMake(i*_viewWidth, 0, _viewWidth, _viewHeight);
        [_childViewFrames addObject:[NSValue valueWithCGRect:frame]];
    }
}

- (void)addScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = self.bounces;//反弹
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
}

- (void)addMenuView {
    CGRect frame = CGRectMake(_viewX, _viewY, _viewWidth, self.menuHeight);
    WMMenuView *menuView = [[WMMenuView alloc] initWithFrame:frame buttonItems:self.titles backgroundColor:self.menuBGColor norSize:self.titleSizeNormal selSize:self.titleSizeSelected norColor:self.titleColorNormal selColor:self.titleColorSelected];
    menuView.delegate = self;
    menuView.style = self.menuViewStyle;
    menuView.progressHeight = self.progressHeight;
    if (self.titleFontName) {
        menuView.fontName = self.titleFontName;
    }
    if (self.progressColor) {
        menuView.lineColor = self.progressColor;
    }
    [self.view addSubview:menuView];
    self.menuView = menuView;
    // 如果设置了初始选择的序号，那么选中该item
    if (self.selectIndex != 0) {
        [self.menuView selectItemAtIndex:self.selectIndex];
    }
}

- (void)layoutChildViewControllers {
    int currentPage = (int)self.scrollView.contentOffset.x / _viewWidth;
    int start = currentPage == 0 ? currentPage : (currentPage - 1);
    int end = (currentPage == self.viewControllerClasses.count - 1) ? currentPage : (currentPage + 1);
    for (int i = start; i <= end; i++) {
        CGRect frame = [self.childViewFrames[i] CGRectValue];
        UIViewController *vc = [self.displayVC objectForKey:@(i)];
        if ([self isInScreen:frame]) {
            if (vc == nil) {
                // 先从 cache 中取
                vc = [self.memCache objectForKey:@(i)];
                if (vc) {
                    // cache 中存在，添加到 scrollView 上，并放入display
                    [self addCachedViewController:vc atIndex:i];
                } else {
                    // cache 中也不存在，创建并添加到display
                    [self addViewControllerAtIndex:i];
                }
                [self postAddToSuperViewNotificationWithIndex:i];
            }
        } else {
            if (vc) {
                // vc不在视野中且存在，移除他
                [self removeViewController:vc atIndex:i];
            }
        }
    }
}

- (void)addCachedViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    [self addChildViewController:viewController];
    viewController.view.frame = [self.childViewFrames[index] CGRectValue];
    [viewController didMoveToParentViewController:self];
    [self.scrollView addSubview:viewController.view];
    [self.displayVC setObject:viewController forKey:@(index)];
}

// 添加子控制器
- (void)addViewControllerAtIndex:(int)index {
    Class vcClass = self.viewControllerClasses[index];
    UIViewController *viewController = [[vcClass alloc] init];
    if (self.values && self.keys) {
        [viewController setValue:self.values[index] forKey:self.keys[index]];
    }
    [self addChildViewController:viewController];
    viewController.view.frame = [self.childViewFrames[index] CGRectValue];
    [viewController didMoveToParentViewController:self];
    [self.scrollView addSubview:viewController.view];
    [self.displayVC setObject:viewController forKey:@(index)];
    
    [self backToPositionIfNeeded:viewController atIndex:index];
}

// 移除控制器，且从display中移除
- (void)removeViewController:(UIViewController *)viewController atIndex:(NSInteger)index {
    [self rememberPositionIfNeeded:viewController atIndex:index];
    [viewController.view removeFromSuperview];
    [viewController willMoveToParentViewController:nil];
    [viewController removeFromParentViewController];
    [self.displayVC removeObjectForKey:@(index)];
    
    // 放入缓存
    if (![self.memCache objectForKey:@(index)]) {
        [self.memCache setObject:viewController forKey:@(index)];
    }
}

- (void)backToPositionIfNeeded:(UIViewController *)controller atIndex:(NSInteger)index {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (!self.rememberLocation) return;
#pragma clang diagnostic pop
    if ([self.memCache objectForKey:@(index)]) return;
    UIScrollView *scrollView = [self isKindOfScrollViewController:controller];
    if (scrollView) {
        NSValue *pointValue = self.posRecords[@(index)];
        if (pointValue) {
            CGPoint pos = [pointValue CGPointValue];
            // 奇怪的现象，我发现 collectionView 的 contentSize 是 {0, 0};
            [scrollView setContentOffset:pos];
        }
    }
}

- (void)rememberPositionIfNeeded:(UIViewController *)controller atIndex:(NSInteger)index {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if (!self.rememberLocation) return;
#pragma clang diagnostic pop
    UIScrollView *scrollView = [self isKindOfScrollViewController:controller];
    if (scrollView) {
        CGPoint pos = scrollView.contentOffset;
        self.posRecords[@(index)] = [NSValue valueWithCGPoint:pos];
    }
}

- (UIScrollView *)isKindOfScrollViewController:(UIViewController *)controller {
    UIScrollView *scrollView = nil;
    if ([controller.view isKindOfClass:[UIScrollView class]]) {
        // Controller的view是scrollView的子类(UITableViewController/UIViewController替换view为scrollView)
        scrollView = (UIScrollView *)controller.view;
    } else if (controller.view.subviews.count >= 1) {
        // Controller的view的subViews[0]存在且是scrollView的子类，并且frame等与view得frame(UICollectionViewController/UIViewController添加UIScrollView)
        UIView *view = controller.view.subviews[0];
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)view;
        }
    }
    return scrollView;
}

- (BOOL)isInScreen:(CGRect)frame {
    CGFloat x = frame.origin.x;
    CGFloat ScreenWidth = self.scrollView.frame.size.width;
    
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    if (CGRectGetMaxX(frame) > contentOffsetX && x-contentOffsetX < ScreenWidth) {
        return YES;
    } else {
        return NO;
    }
}

- (void)resetMenuView {
    WMMenuView *oldMenuView = self.menuView;
    [self addMenuView];
    [oldMenuView removeFromSuperview];
}

- (void)growCachePolicyAfterMemoryWarning {
    self.cachePolicy = WMPageControllerCachePolicyBalanced;
    [self performSelector:@selector(growCachePolicyToHigh) withObject:nil afterDelay:2.0 inModes:@[NSRunLoopCommonModes]];
}

- (void)growCachePolicyToHigh {
    self.cachePolicy = WMPageControllerCachePolicyHigh;
}
#pragma mark 更多按钮
-(void)click:(UIButton *)sender
{
    if (sender.selected == NO)
    {
        sender.selected = YES;
        [self loadButton];
    }else
    {
        sender.selected = NO;
        [KxMenu dismissMenu];
    }
    
}
-(void)loadButton
{
    KxMenuItem *item1 = [KxMenuItem menuItem:@"发布问问" image:[UIImage imageNamed:@"supermarket_fruit"] target:self action:@selector(clickItem:)];
    
    KxMenuItem *item2 = [KxMenuItem menuItem:@"发布说说" image:[UIImage imageNamed:@"supermaket_vegetables"] target:self action:@selector(clickItem:)];
    
    KxMenuItem *item3 = [KxMenuItem menuItem:@"发布闲置" image:[UIImage imageNamed:@"supermatket_grain_oil"] target:self action:@selector(clickItem:)];
    
    NSArray *arr = @[item1,item2,item3];
    OptionalConfiguration optional;
    optional.arrowSize = 9;
    optional.marginXSpacing = 7;
    optional.marginYSpacing = 9;
    optional.intervalSpacing = 25;
    optional.menuCornerRadius = 6.5;
    optional.maskToBackground = YES;
    optional.shadowOfMenu = NO;
    optional.hasSeperatorLine = YES;
    optional.seperatorLineHasInsets = NO;
    optional.textColor = MakeColor(0, 0, 0);
    optional.menuBackgroundColor = MakeColor(1, 1, 1);
    [KxMenu setTitleFont:[UIFont systemFontOfSize:16]];
    [KxMenu setTintColor:[UIColor whiteColor]];
    [KxMenu showMenuInView:self.view.window fromRect:CGRectMake(self.view.frame.size.width-60, 35, 60, 30) menuItems:arr withOptions:optional];
    
}
-(void)clickItem:(KxMenuItem *)target
{
    rightSelectBtn.selected = NO;
    [NetworkEngine showHUDString:[NSString stringWithFormat:@"您点击的是%@",target.title] Withshowtime:2 WithView:self.view];

    NSLog(@"target.title = %@",target.title);
    UINavigationController *publishNavi = [[UINavigationController alloc] initWithRootViewController:[PublishCommunityViewController new]];
    [self presentViewController:publishNavi animated:YES completion:nil];
    

}
#pragma mark 添加更多按钮
-(void)addMenuViewItems
{
    if (_show) {
        rightSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightSelectBtn.frame = CGRectMake(0, 0, 25, 25);
        [rightSelectBtn setTitle:@"分类" forState:0];
        [rightSelectBtn setTitleColor:[UIColor grayColor] forState:0];
        [rightSelectBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        rightSelectBtn.selected = NO;
        
        UIBarButtonItem *itemButton = [[UIBarButtonItem alloc] initWithCustomView:rightSelectBtn];
        self.navigationItem.rightBarButtonItem = itemButton;
    }
}
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self addMenuViewItems];
    
    
    [self addScrollView];
    [self addViewControllerAtIndex:self.selectIndex];
    self.currentViewController = self.displayVC[@(self.selectIndex)];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 计算宽高及子控制器的视图frame
    [self calculateSize];
    CGRect scrollFrame = CGRectMake(_viewX, _viewY + self.menuHeight, _viewWidth, _viewHeight);
    self.scrollView.frame = scrollFrame;
    self.scrollView.contentSize = CGSizeMake(self.titles.count*_viewWidth, _viewHeight-self.menuHeight);
    [self.scrollView setContentOffset:CGPointMake(self.selectIndex*_viewWidth, 0)];

    self.currentViewController.view.frame = [self.childViewFrames[self.selectIndex] CGRectValue];
    
    [self resetMenuView];

    [self.view layoutIfNeeded];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.memoryWarningCount++;
    self.cachePolicy = WMPageControllerCachePolicyLowMemory;
    // 取消正在增长的 cache 操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(growCachePolicyAfterMemoryWarning) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(growCachePolicyToHigh) object:nil];
    
    [self.memCache removeAllObjects];
    [self.posRecords removeAllObjects];
    self.posRecords = nil;
    
    // 如果收到内存警告次数小于 3，一段时间后切换到模式 Balanced
    if (self.memoryWarningCount < 3) {
        [self performSelector:@selector(growCachePolicyAfterMemoryWarning) withObject:nil afterDelay:3.0 inModes:@[NSRunLoopCommonModes]];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self layoutChildViewControllers];
    if (_animate) {
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        if (contentOffsetX < 0 ) {
            contentOffsetX = 0;
        }
        if (contentOffsetX > scrollView.contentSize.width - _viewWidth) {
            contentOffsetX = scrollView.contentSize.width - _viewWidth;
        }
        CGFloat rate = contentOffsetX / _viewWidth;
        [self.menuView slideMenuAtProgress:rate];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _animate = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _selectIndex = (int)scrollView.contentOffset.x / _viewWidth;
    self.currentViewController = self.displayVC[@(self.selectIndex)];
    [self postFullyDisplayedNotificationWithCurrentIndex:self.selectIndex];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self postFullyDisplayedNotificationWithCurrentIndex:self.selectIndex];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        CGFloat rate = _targetX / _viewWidth;
        [self.menuView slideMenuAtProgress:rate];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    _targetX = targetContentOffset->x;
}

#pragma mark - WMMenuView Delegate
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
    NSInteger gap = (NSInteger)labs(index - currentIndex);
    _selectIndex = (int)index;
    _animate = NO;
    CGPoint targetP = CGPointMake(_viewWidth*index, 0);
    
    [self.scrollView setContentOffset:targetP animated:gap > 1 ? NO : self.pageAnimatable];
    if (gap > 1 || !self.pageAnimatable) {
        // 由于不触发 -scrollViewDidScroll: 手动处理控制器
        [self layoutChildViewControllers];
        self.currentViewController = self.displayVC[@(self.selectIndex)];
        
        [self postFullyDisplayedNotificationWithCurrentIndex:(int)index];
    }
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    if (self.itemsWidths) {
        return [self.itemsWidths[index] floatValue];
    }
    return self.menuItemWidth;
}

- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index {
    if (self.itemsMargins) {
        return [self.itemsMargins[index] floatValue];
    }
    return self.itemMargin;
}




@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com