//
//  UINavigationBar+myNavigationBar.m
//  MXClient
//
//  Created by wlq on 16/5/17.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "UINavigationBar+myNavigationBar.h"
//设置
#import "HTMISettingManager.h"
#import <objc/runtime.h>
//新增字体方法
#import "UIFont+HTMIFont.h"

@implementation UINavigationBar (myNavigationBar)

+ (void)load{
    
    bd_exchageClassMethod_setTitleTextAttributes([self class], @selector(setTitleTextAttributes:), @selector(hook_setTitleTextAttributes:));
}

void bd_exchageClassMethod_setTitleTextAttributes(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldClsMethod = class_getInstanceMethod(aClass, oldSEL);
    assert(oldClsMethod);
    Method newClsMethod = class_getInstanceMethod(aClass, newSEL);
    assert(newClsMethod);
    method_exchangeImplementations(oldClsMethod, newClsMethod);
}

- (void)hook_setTitleTextAttributes:(NSDictionary *)titleTextAttributes
{
    [self hook_setTitleTextAttributes:HTMINavigationBarTitleFont];
}

- (void)hideBottomHairline {
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = YES;
}

- (void)showBottomHairline {
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = NO;
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)makeTransparent {
    [self setTranslucent:YES];
    [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.backgroundColor = [UIColor clearColor];
    self.shadowImage = [UIImage new];    // Hides the hairline
    [self hideBottomHairline];
}

- (void)makeDefault {
    [self setTranslucent:YES];
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:nil forBarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.backgroundColor = nil;
    self.shadowImage = nil;    // Hides the hairline
    [self showBottomHairline];
}



@end
