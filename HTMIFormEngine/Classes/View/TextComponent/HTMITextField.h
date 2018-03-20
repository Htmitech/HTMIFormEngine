//
//  HTMITextField.h
//  CustomInputView
//
//  Created by wlq on 16/7/11.
//  Copyright © 2016年 wlq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMITextField : UITextField

/**
 是否支持拷贝和粘贴等操作
 */
@property (nonatomic,assign,getter=isSuportCopyAndPast)BOOL suportCopyAndPast;

@end
