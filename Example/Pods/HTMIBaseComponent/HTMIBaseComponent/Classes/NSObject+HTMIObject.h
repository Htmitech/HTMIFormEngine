//
//  NSObject+Extend.h
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (HTMIObject)

//@property (retain, nonatomic) NSNumber *originalFontSize;

/**
 *  show progress HUD ,and afer delay time,it will be hided
 *
 *  @param title progress HUD title
 *  @param delay delay seconds
 */
- (void)showYiProgressHUD:(NSString *)title  afterDelay:(NSTimeInterval)delay;

/**
 *  show progress HUD
 *
 *  @param title title progress HUD title
 */
- (void)showYiProgressHUD:(NSString *)title;

/**
 *  hide progress HUD
 */
- (void)hideYiProgressHUD;

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict andClassStr:(NSString *)classStr andPrdfix:(NSString *)prdfix;

//栗子
//[LCTestModel createPropertyCodeWithDict:dic3 andClassStr:NSStringFromClass([LCTestModel class]) andPrdfix:@"LC"];

/**
 是否包含某一个属性
 
 @param object 对象
 @param fieldString 属性名称字符串
 @return 是否包含
 */
+ (BOOL)isContainProperty:(id)object fieldString:(NSString *)fieldString;

@end
