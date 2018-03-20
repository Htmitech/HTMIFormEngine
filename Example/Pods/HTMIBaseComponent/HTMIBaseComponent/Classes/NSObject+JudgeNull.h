//
//  NSObject+JudgeNull.h
//  Monkey
//
//  Created by coderyi on 15/7/11.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JudgeNull)

/**
 *  judge a object it is null or not
 *
 *  @return a object it is null or not
 */
- (BOOL)isNull;

/**
 请求参数不能为nil

 @param obj 对象
 @return 不为空对象或者NSNull
 */
+ (NSObject *)objectNotNil:(NSObject *)obj;

+ (NSObject *)objectNotNilWithString:(NSObject *)obj;
@end
