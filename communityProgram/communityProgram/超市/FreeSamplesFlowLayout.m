//
//  FreeSamplesFlowLayout.m
//  uiconent
//
//  Created by 谢泽锋 on 16/6/20.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import "FreeSamplesFlowLayout.h"

static const CGFloat size_H =200;
@implementation FreeSamplesFlowLayout
-(instancetype)init{
    if (self=[super init]) {
        //初始化
        //每一个cell的尺寸
        float width= [[UIScreen mainScreen] bounds].size.width;
        self.itemSize=CGSizeMake(width, width);
        self.minimumLineSpacing=1;
        self.minimumInteritemSpacing=1;
        self.scrollDirection=UICollectionViewScrollDirectionHorizontal;//水平滚动
    
    
//           self.sectionInset=UIEdgeInsetsMake(20, 0, DeviceWidth-120-(200+DeviceWidth*2/3-30), 0);
//        UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//        每一个cell（item都有自己UICollectionViewLayoutAttributes）
//        UICollectionViewLayoutAttributes
//        self.sectionInset=UIEdgeInsetsMake(20, 0, 20, 0);
    
    }
    return self;
}
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
//    
//    NSLog(@"%f",rect.size.width);
//    return [super layoutAttributesForElementsInRect:rect];
//}
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
//    return YES;
//}
@end
































