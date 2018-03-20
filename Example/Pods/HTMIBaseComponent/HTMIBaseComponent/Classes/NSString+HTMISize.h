//
//  NSString+HTMISize.h
//  MXClient
//
//  Created by wlq on 2017/7/31.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HTMISize)
//提供一个类的接口,方便在整个项目中调用

+ (CGSize)htmi_sizeWithString:(NSString*)str font:(UIFont*)font maxSize:(CGSize)size;

- (CGSize)htmi_sizeWithFont:(UIFont*)font maxSize:(CGSize)size;

/**
 计算label的size

 @param width <#width description#>
 @param content <#content description#>
 @param FontOfSize <#FontOfSize description#>
 @return <#return value description#>
 */
+ (CGSize)labelSizeWithMaxWidth:(CGFloat)width content:(NSString *)content FontOfSize:(CGFloat)FontOfSize;

@end
