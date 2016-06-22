//
//  CommentModle.h
//  自适应cell
//
//  Created by xiaogao on 16/1/30.
//  Copyright © 2016年 高国峰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModle : NSObject
@property(nonatomic,copy)NSString *commentHeadImageUrl;
@property(nonatomic,copy)NSString *commentName;
@property(nonatomic,copy)NSString *commentTime;
@property(nonatomic,copy)NSString *commentContent;
@property(nonatomic,copy)NSString *additionalCommentContent;
@property(nonatomic,strong)NSDictionary *addDic;
@property (nonatomic, strong) NSArray *picNamesArray;
@end
