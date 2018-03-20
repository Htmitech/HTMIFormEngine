//
//  HTMICurrentViewController.h
//  HTMITemplate
//
//  Created by wlq on 17/5/8.
//  Copyright © 2017年 htmi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern UIViewController * kHTMICurrentViewController;

@interface CurrentViewController : UIViewController

/**
 *  获取当前屏幕显示的viewcontroller
 *
 *  @return 当前屏幕显示的viewcontroller
 */
+ (UIViewController *)currentViewController;

@end
