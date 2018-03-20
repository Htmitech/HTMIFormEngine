//
//  NSArray+HTMIExtension.h
//  MXClient
//
//  Created by wlq on 2017/6/27.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HTMIExtension)

/**
 将空值转为空字符串
 
 @param array 数组
 @return 转换完的数组
 */
+ (NSArray *)isStringNull:(NSArray *)array;

@end
