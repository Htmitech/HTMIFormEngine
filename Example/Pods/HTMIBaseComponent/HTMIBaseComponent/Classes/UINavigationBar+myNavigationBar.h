//
//  UINavigationBar+myNavigationBar.h
//  MXClient
//
//  Created by wlq on 16/5/17.
//  Copyright © 2016年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (myNavigationBar)


/**
 * 隐藏下边线
 */
- (void)hideBottomHairline;

/**
 * 显示下边线
 */
- (void)showBottomHairline;

/**
 * navigationbar 透明
 */
- (void)makeTransparent;

/**
 * 恢复
 **/
- (void)makeDefault;

@end
