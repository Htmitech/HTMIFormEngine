//
//  NSArray+HTMIExtension.m
//  MXClient
//
//  Created by wlq on 2017/6/27.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "NSArray+HTMIExtension.h"

@implementation NSArray (HTMIExtension)

/**
 将空值转为空字符串

 @param array 数组
 @return 转换完的数组
 */
+ (NSArray *)isStringNull:(NSArray *)array{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        if([array[i] isEqual:[NSNull null]] || !array[i] || [array[i] isEqualToString:@"null"])
        {
            [mutableArray addObject:@""];
        }else{
            [mutableArray addObject:array[i]];
        }
    }
    
    return mutableArray;
    
}

@end
