//
//  NSObject+Extend.m
//  GitHubYi
//
//  Created by coderyi on 15/3/24.
//  Copyright (c) 2015年 www.coderyi.com. All rights reserved.
//

#import "NSObject+HTMIObject.h"
#import <objc/runtime.h>

UIAlertView *alertView;

@implementation NSObject (HTMIObject)

//static const void *customAnimatingKey = @"HTMI_CustomAnimatingKey";//&customAnimatingKey;
//
//@dynamic originalFontSize;
//
//- (NSNumber *)originalFontSize {
//    return objc_getAssociatedObject(self, &customAnimatingKey);
//}
//
//- (void)setOriginalFontSize:(NSNumber *)animating{
//    objc_setAssociatedObject(self, &customAnimatingKey, animating, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

- (void)showYiProgressHUD:(NSString *)title  afterDelay:(NSTimeInterval)delay
{
    [self showYiProgressHUD:title];
    [NSTimer scheduledTimerWithTimeInterval:delay
                                     target:self
                                   selector:@selector(hideYiProgressHUD:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)showYiProgressHUD:(NSString *)title
{
    alertView = [[UIAlertView alloc] initWithTitle:@""
                                           message:title
                                          delegate:nil
                                 cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)hideYiProgressHUD
{
    [self hideYiProgressHUD:nil];
}

- (void)hideYiProgressHUD:(NSTimer*)timer
{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict andClassStr:(NSString *)classStr andPrdfix:(NSString *)prdfix
{
    NSMutableString *strM = [NSMutableString string];
    // 遍历字典
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull propertyName, id  _Nonnull value, BOOL * _Nonnull stop) {
        
        NSString *code;
        
        if ([value isKindOfClass:[NSString class]]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSString *%@;",propertyName]
            ;
        }else if ([value isKindOfClass:[NSNumber class]]){
            //这里写的不完善 暂时都用int 保存
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) int %@;",propertyName]
            ;
        }else if ([value isKindOfClass:[NSArray class]]){
            
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@;",propertyName]
            ;
            [self createPropertyCodeWithKey:propertyName andArray:value andPrdfix:prdfix];
        }else if ([value isKindOfClass:[NSDictionary class]]){
            
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) %@ *%@;",[NSString stringWithFormat:@"%@%@Model",prdfix,propertyName],propertyName]
            ;
            [self createPropertyCodeWithKey:propertyName andDIC:value andPrdfix:prdfix];
        }else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@;",propertyName]
            ;
        }
        [strM appendFormat:@"\n%@\n",code];
    }];
    NSString *top = nil;
    
    top = [NSString stringWithFormat:@"@interface %@ : NSObject",classStr];
    NSString *bottom = @"@end";
    NSString *allStr= [NSString stringWithFormat:@"\n%@\n%@\n%@\n\n",top,strM,bottom];
    const char *cString1 = [allStr cStringUsingEncoding:NSUTF8StringEncoding];
    printf("%s",cString1);
}

+ (void)createPropertyCodeWithKey:(NSString *)key andArray:(NSArray *)arr andPrdfix:(NSString *)prdfix{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *classStr = [NSString stringWithFormat:@"%@%@Model",prdfix,key];
        [self createPropertyCodeWithDict:arr[0] andClassStr:classStr andPrdfix:prdfix];
    });
}

+ (void)createPropertyCodeWithKey:(NSString *)key andDIC:(NSDictionary *)dic andPrdfix:(NSString *)prdfix{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *classStr = [NSString stringWithFormat:@"%@%@Model",prdfix,key];
        [self createPropertyCodeWithDict:dic andClassStr:classStr andPrdfix:prdfix];
    });
}

/**
 是否包含某一个属性
 
 @param object 对象
 @param fieldString 属性名称字符串
 @return 是否包含
 */
+ (BOOL)isContainProperty:(id)object fieldString:(NSString *)fieldString{
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([object class], &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        NSString *propertyString = [NSString stringWithUTF8String:propertyName];
        
        if ([propertyString isEqualToString:fieldString]) {
            return YES;
        }
    }
    
    ///释放
    free(propertys);
    
    return NO;
}

@end
