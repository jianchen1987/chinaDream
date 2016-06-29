//
//  MyCollectionViewController.m
//  communityProgram
//
//  Created by xiaogao on 16/3/24.
//  Copyright © 2016年 高国峰. All rights reserved.
//
#import "MyCollectionViewController.h"


@interface MyCollectionViewController ()
{
    NSMutableArray *_buttons;
}

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonHeght  = _BUTTONVIEW_BUTTON_HEIGHT;
    _buttons = [[NSMutableArray alloc] init];
    
    if(self.buttonTitles.count > 0)
    {
        UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DeviceWidth, self.buttonHeght + 10)];
        buttonView.backgroundColor = [UIColor whiteColor];
        
        for(int i = 0; i < self.buttonTitles.count; i++)
        {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((DeviceWidth/self.buttonTitles.count)*i + 5, 5, DeviceWidth/self.buttonTitles.count - 10, self.buttonHeght)];
            [button setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"collection_btn_disable"] forState:UIControlStateDisabled];
            [button setBackgroundImage:[UIImage imageNamed:@"collection_btn_normal"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_];
            button.tag = 101 + i;
            [button addTarget:self action:@selector(clickOnButton:) forControlEvents:UIControlEventTouchUpInside];
            if(i == 0)
            {
                [button setEnabled:NO];
            }
            else
            {
                [button setEnabled:YES];
            }
            [_buttons addObject:button];
            [buttonView addSubview:button];
        }
        [self.view addSubview:buttonView];
    }
    
    self.tableView.frame = CGRectMake(0, self.buttonHeght + 10, DeviceWidth, DeviceHeight - kSTATUSBAR_HEIGHT - kNAVIGATION_HEIGHT - kPageMenusHeight - self.buttonHeght - 10);
    

}




- (void)clickOnButton:(id)sender
{
    UIButton *button = sender;
    for (UIButton *tmp in _buttons)
    {
        if(tmp.tag == button.tag)
        {
            [tmp setEnabled:NO];
        }
        else
        {
            [tmp setEnabled:YES];
        }
    }
    
    [self clickOnButton:button atIndex:(button.tag - 101)];
    
}


- (void)clickOnButton:(UIButton *)button atIndex:(NSUInteger)index
{
    
}


#pragma mark -- tableview delegate --
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"qqqq"];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
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
    return 120;
}

#pragma mark -- empty delete --


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_TITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor blackColor]};
    return [[NSAttributedString alloc] initWithString:@"您未收藏过该类商品" attributes:attribute];
}


- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:_SUBTITLE_FONT_SIZE_],NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:@"去超市逛逛看有什么合您心意吧!" attributes:attribute];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"collectionEmpty"];
}


@end
