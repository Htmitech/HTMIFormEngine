//
//  UISearchBar+HTMISearchBar.m
//  MXClient
//
//  Created by wlq on 16/7/4.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import "UISearchBar+HTMISearchBar.h"

@implementation UISearchBar (HTMISearchBar)

//其中fm_setCancelButtonTitle是我写的UISearchBar一个分类的方法
- (void)fm_setCancelButtonTitle:(NSString *)title {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
    }else {
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title];
    }
}

@end
