//
//  SVProgressHUD+Swizzling.m
//  MXClient
//
//  Created by wlq on 2017/3/14.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "SVProgressHUD+Swizzling.h"

#import "objc/runtime.h"

@implementation SVProgressHUD (Swizzling)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
       // Class class = [self class];
        
        // When swizzling a class method, use the following:
        Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(dismiss);
        SEL swizzledSelector = @selector(swizzling_dismiss);
        
        Method originalMethod = class_getClassMethod(class, originalSelector);
        Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

+ (void)swizzling_dismiss {
    
    [self setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [self swizzling_dismiss];
}

@end
