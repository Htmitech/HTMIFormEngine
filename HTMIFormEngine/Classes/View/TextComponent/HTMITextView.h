//
//  HTMITextView.h
//  自定义输入框
//
//  Created by wlq on 16/7/8.
//  Copyright © 2016年 htmitech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMITextView : UITextView

/**placeholder占位文字*/
@property (nonatomic, copy) NSString *placeholder;
/**placeholderColor占位文字颜色*/
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 是否支持拷贝和粘贴等操作
 */
@property (nonatomic,assign,getter=isSuportCopyAndPast)BOOL suportCopyAndPast;

@end
