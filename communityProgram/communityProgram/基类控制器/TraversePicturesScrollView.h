//
//  TraversePicturesScrollView.h
//  imageviewshow
//
//  Created by 谢泽锋 on 16/4/5.
//  Copyright © 2016年 xiezefeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TraversePicturesDelegte <NSObject>

-(void)TraversePicturesSelectImage:(NSInteger)imageNum;

@end
@interface TraversePicturesScrollView : UIScrollView
{
    NSInteger nowImageCount;
}
@property(nonatomic,assign)id<TraversePicturesDelegte>TPdelegte;
@property (nonatomic,strong)NSMutableArray * allImageArray;
@property(nonatomic,strong)NSMutableArray * AllImageViewArray;
-(void)addImage:(UIImage*)imageName;
@end
