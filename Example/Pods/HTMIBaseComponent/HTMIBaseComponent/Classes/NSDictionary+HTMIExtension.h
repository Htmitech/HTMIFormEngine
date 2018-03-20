//
//  NSDictionary+HTMIExtension.h
//  MXClient
//
//  Created by wlq on 2017/6/20.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HTMIExtension)

/**
 json字符串转字典
 
 @param jsonString json字符串
 @return 字典
 */
+ (NSDictionary *)htmi_dictionaryWithJsonString:(NSString *)jsonString;

@end
