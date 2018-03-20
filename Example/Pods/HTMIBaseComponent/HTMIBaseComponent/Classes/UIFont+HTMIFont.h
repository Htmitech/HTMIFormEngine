//
//  UIFont+HTMIFont.h
//  OuLianWang
//
//  Created by hzq on 16/7/13.
//  Copyright © 2016年 我连网. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (HTMIFont)

+ (UIFont *)htmi_systemFontOfSize:(CGFloat)fontSize;

+ (nullable UIFont *)htmi_fontWithName:(NSString *)fontName size:(CGFloat)fontSize;

- (UIFont *)htmi_fontWithSize:(CGFloat)fontSize;

+ (UIFont *)imFontOfSize:(CGFloat)fontSize;
+ (UIFont *)imFontOfSize:(CGFloat)fontSize coefficient:(NSInteger)coefficient;

//wlq add 2016/05/10 自定义字体设置方法，这个是用系统的，不需要缩放的

/**
 *  设置字体 （不需要缩放的）
 *
 *  @param fontName 字体
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+ (UIFont *)myFontWithName:(NSString *)fontName size:(CGFloat)fontSize;

/**
 *  设置字体 （不需要缩放的）
 *
 *  @param fontSize 字体
 *
 *  @return 字体
 */
+ (UIFont *)mySystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)myBoldSystemFontOfSize:(CGFloat)fontSize;


/**
 *  字体放大1.5倍
 *
 *  @param fontName 字体
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+ (UIFont *)myFontWithNameAmplifyForSixPlus:(NSString *)fontName size:(CGFloat)fontSize;

/**
 *  字体放大1.5倍
 *
 *  @param fontSize 字体大小
 *
 *  @return 字体
 */
+ (UIFont *)mySystemFontOfSizeAmplifyForSixPlus:(CGFloat)fontSize;



NS_ASSUME_NONNULL_END

@end
