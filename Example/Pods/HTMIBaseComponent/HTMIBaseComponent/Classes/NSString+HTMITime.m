//
//  NSString+HTMITime.m
//  MXClient
//
//  Created by wlq on 2017/7/31.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "NSString+HTMITime.h"

@implementation NSString (HTMITime)

+ (NSString *)htmi_GetCurrentTimeDate:(long)iDenty{
    
    NSDate *pDate = [NSDate dateWithTimeIntervalSince1970:(iDenty)/1000];
    NSDateFormatter *pFormatter = [[NSDateFormatter alloc]init];
    [pFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [pFormatter stringFromDate:pDate];
}


/**
 获取当地时间
 
 @return 获取当地时间
 */
+ (NSString *)htmi_getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

/**
 将字符串转成NSDate类型
 
 @param dateString 将字符串转成NSDate类型
 @return 将字符串转成NSDate类型
 */
- (NSDate *)htmi_dateFromString:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

/**
 传入今天的时间，返回明天的时间
 
 @param aDate 时间
 @return 明天的时间
 */
- (NSString *)htmi_getTomorrowDay:(NSDate *)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

@end
