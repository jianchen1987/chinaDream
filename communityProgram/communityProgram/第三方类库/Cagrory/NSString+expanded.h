//
//  StringRef.h
//  beta1
//
//  Created by jack ray on 11-1-17.
//  Copyright 2011 重庆奥芬多网络科技有限公司. All rights reserved.
//
typedef enum {
    imageSmallType,
    imageMiddlType,
    imageBigType,
}imageType;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString(expanded) 

-(NSString*)replaceControlString;
-(NSString*)imagePathType:(imageType)__type;
- (CGFloat)getHeightByWidth:(NSInteger)_width font:(UIFont *)_font;
//- (NSString *)indentString:(NSString*)_string font:(UIFont *)_font;
- (NSString *)indentLength:(CGFloat)_len font:(UIFont *)_font;
- (BOOL)notEmptyOrNull;
+ (NSString *)replaceEmptyOrNull:(NSString *)checkString;
-(NSString*)replaceTime;
-(NSString*)replaceStoreKey;
- (NSString*)soapMessage:(NSString *)key,...;
- (NSString *)md5;
@end
