//
//  NSArray+Swizzling.m
//  MXClient
//
//  Created by wlq on 2017/3/1.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "NSArray+Swizzling.h"

#import "objc/runtime.h"

@implementation NSArray (Swizzling)
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(objectAtIndex:);
        SEL swizzledSelector = @selector(swizzling_objectAtIndex:);
        
        Method originalMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), originalSelector);
        Method swizzledMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), swizzledSelector);
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

- (id)swizzling_objectAtIndex:(NSUInteger)index {
    if (self.count-1 < index) {
        // 异常处理
        @try {
            return [self swizzling_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 打印崩溃信息
            return nil;
        }
        @finally {}
    } else {
        return [self swizzling_objectAtIndex:index];
    }
}

@end
