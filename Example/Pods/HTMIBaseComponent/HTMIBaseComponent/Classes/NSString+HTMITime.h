//
//  NSString+HTMITime.h
//  MXClient
//
//  Created by wlq on 2017/7/31.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTMITime)

+ (NSString *)htmi_GetCurrentTimeDate:(long)iDenty;


/**
 获取当地时间
 
 @return 获取当地时间
 */
+ (NSString *)htmi_getCurrentTime;
/**
 将字符串转成NSDate类型
 
 @param dateString 将字符串转成NSDate类型
 @return 将字符串转成NSDate类型
 */
- (NSDate *)htmi_dateFromString:(NSString *)dateString;

/**
 传入今天的时间，返回明天的时间
 
 @param aDate 时间
 @return 明天的时间
 */
- (NSString *)htmi_getTomorrowDay:(NSDate *)aDate;

@end
