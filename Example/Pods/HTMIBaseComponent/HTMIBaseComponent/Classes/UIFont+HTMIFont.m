//
//  UIFont+HTMIFont.m
//  OuLianWang
//
//  Created by hzq on 16/7/13.
//  Copyright © 2016年 我连网. All rights reserved.
//

#import "UIFont+HTMIFont.h"
#import "HTMIUserdefaultHelper.h"

#import <objc/runtime.h>

@implementation UIFont (HTMIFont)

+ (void)load {
    
    bd_exchageClassMethod_systemFontOfSize([self class], @selector(systemFontOfSize:), @selector(hook_systemFontOfSize:));
    
    bd_exchageClassMethod_systemFontOfSize([self class], @selector(boldSystemFontOfSize:), @selector(hook_boldSystemFontOfSize:));
    
    bd_exchageClassMethod_systemFontOfSize([self class], @selector(fontWithName:size:), @selector(hook_fontWithName:size:));
    
    Method ibImp = class_getInstanceMethod([self class], @selector(fontWithSize:));
    Method myIbImp = class_getInstanceMethod([self class], @selector(myFontWithSize:));
    method_exchangeImplementations(ibImp, myIbImp);
}

+ (UIFont *)htmi_systemFontOfSize:(CGFloat)fontSize{
    return [UIFont systemFontOfSize:fontSize];
}

+ (nullable UIFont *)htmi_fontWithName:(NSString *)fontName size:(CGFloat)fontSize{
    return [UIFont fontWithName:fontName size:fontSize];
}

- (UIFont *)htmi_fontWithSize:(CGFloat)fontSize{
    return [self fontWithSize:fontSize];
}

void bd_exchageClassMethod_systemFontOfSize(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldClsMethod = class_getClassMethod(aClass, oldSEL);
    assert(oldClsMethod);
    Method newClsMethod = class_getClassMethod(aClass, newSEL);
    assert(newClsMethod);
    method_exchangeImplementations(oldClsMethod, newClsMethod);
}

//void bd_exchageClassMethod_FontWithName(Class aClass, SEL oldSEL, SEL newSEL)
//{
//    Method oldClsMethod = class_getClassMethod(aClass, oldSEL);
//    assert(oldClsMethod);
//    Method newClsMethod = class_getClassMethod(aClass, newSEL);
//    assert(newClsMethod);
//    method_exchangeImplementations(oldClsMethod, newClsMethod);
//}

- (UIFont *)myFontWithSize:(CGFloat)fontSize{
 
    float coefficient = [HTMIUserdefaultHelper defaultLoadNewCoefficient];
    
    return [self myFontWithSize:fontSize* coefficient * [UIFont getScale]];
}

+ (UIFont *)hook_fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    float coefficient = [HTMIUserdefaultHelper defaultLoadNewCoefficient];
    
    return [UIFont hook_fontWithName:fontName size:fontSize * coefficient * [UIFont getScale]];
}

+ (UIFont *)hook_systemFontOfSize:(CGFloat)fontSize
{
    float coefficient = [HTMIUserdefaultHelper defaultLoadNewCoefficient];
    
    return [UIFont hook_systemFontOfSize:fontSize * coefficient * [UIFont getScale]];
}

+ (UIFont *)hook_boldSystemFontOfSize:(CGFloat)fontSize
{
    float coefficient = [HTMIUserdefaultHelper defaultLoadNewCoefficient];
    
 
    return [UIFont hook_boldSystemFontOfSize:fontSize * coefficient * [UIFont getScale]];
}


#pragma mark --6plus 导航栏字体应该是放大 应该是1.5倍

+ (UIFont *)myFontWithNameAmplifyForSixPlus:(NSString *)fontName size:(CGFloat)fontSize
{
    
    return [UIFont hook_fontWithName:fontName size:fontSize * [UIFont getScale]];
}

+ (UIFont *)mySystemFontOfSizeAmplifyForSixPlus:(CGFloat)fontSize
{
    
    return [UIFont hook_systemFontOfSize:fontSize * [UIFont getScale]];
}

#pragma mark --不需要适配放大的方法

+ (UIFont *)myFontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    return [UIFont hook_fontWithName:fontName size:fontSize* [UIFont getScale]];
}

+ (UIFont *)mySystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont hook_systemFontOfSize:fontSize* [UIFont getScale]];
}

+ (UIFont *)myBoldSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont hook_boldSystemFontOfSize:fontSize* [UIFont getScale]];
}

+ (UIFont *)imFontOfSize:(CGFloat)fontSize{
    
    NSInteger coefficient = [HTMIUserdefaultHelper defaultLoadFontEditePageCoefficient];
    
    float x = 0.1*(coefficient-2)+1; //改变系数x 为0.9 --1.30
    return  [UIFont hook_systemFontOfSize:fontSize*x* [UIFont getScale]];
}

+ (UIFont *)imFontOfSize:(CGFloat)fontSize coefficient:(NSInteger)coefficient{
    
    float x = 0.1*(coefficient-2)+1; //改变系数x 为0.9 --1.30
    return  [UIFont hook_systemFontOfSize:fontSize*x* [UIFont getScale]];
}

+ (CGFloat)getScale{
    float scale = 1.0;
    if([UIScreen mainScreen].scale >= 3.0) {
        scale = 1.1;
    } else {
        scale = 1.0;
    }
    return scale;
}

@end
