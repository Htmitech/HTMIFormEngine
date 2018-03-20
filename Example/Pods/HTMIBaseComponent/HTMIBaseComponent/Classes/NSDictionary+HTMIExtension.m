//
//  NSDictionary+HTMIExtension.m
//  MXClient
//
//  Created by wlq on 2017/6/20.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "NSDictionary+HTMIExtension.h"

@implementation NSDictionary (HTMIExtension)

/**
 json字符串转字典
 
 @param jsonString json字符串
 @return 字典
 */
+ (NSDictionary *)htmi_dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}

@end
