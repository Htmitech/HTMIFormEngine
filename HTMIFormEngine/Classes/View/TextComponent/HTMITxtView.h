//
//  HTMITxtView.h
//  自定义输入框
//
//  Created by 赵志国 on 16/6/29.
//  Copyright © 2016年 htmitech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTMITxtViewProtocol.h"

@class HTMITextView;
@class HTMITextField;

typedef void(^HTMITxtViewBlock)(NSString *string);

typedef void(^HTMITextViewEditEndBlock)(NSString *string);

typedef NS_ENUM(NSInteger, TextType) {
    TextTypeTextField,
    TextTypeTextFieldInteger,
    TextTypeTextFieldIntegerSplitbyThousand,
    TextTypeTextFieldDecimal,
    TextTypeTextFieldDecimalSplitbyThousand,
    TextTypeTextView,
};

@interface HTMITxtView : UIView

/**
 *  初始化
 */
- (instancetype)initWithFrame:(CGRect)frame
                     textType:(TextType)textType
                   beforValue:(NSString *)beforValue
                    textValue:(NSString *)textValue
                     endValue:(NSString *)endValue
                  isMustInput:(BOOL)isMustInput
                     textFont:(NSInteger)textFont
                    maxLength:(NSInteger)maxLength
                isShowWarning:(BOOL)isShowWarning;


#pragma mark - 返回，类型


@property(nonatomic,weak)id <HTMITxtViewProtocol> delegate;

/**
 *  textView编辑完成后收键盘
 */
@property (nonatomic, copy) HTMITextViewEditEndBlock editEndBlock;

/**
 *  block 编辑字段
 */
@property (nonatomic, copy) HTMITxtViewBlock editBlock;
/**
 *  文本类型
 */
@property (nonatomic, assign) TextType textType;

/**
 *  字体大小
 */
@property (nonatomic, assign) NSInteger formLabelFont;

#pragma mark - 控件
/** 多行文本框 */
@property (nonatomic, strong)HTMITextField *textField;
/** 多行文本框 */
@property (nonatomic, strong)HTMITextView *textView;
/** 左侧Label */
@property (nonatomic, strong)UILabel *beforLabel;
/** 右侧Label */
@property (nonatomic, strong)UILabel *endLabel;

#pragma mark - 样式属性
/** 高亮颜色 */
@property (nonatomic, copy) UIColor * highlightBorderColor;
/** 正常颜色 */
@property (nonatomic, copy) UIColor * nomarlBorderColor;
/** 错误颜色（提交时没有填写的必填字段，设置为nil，用默认的颜色） */
@property (nonatomic, copy) UIColor * errorBorderColor;
/** 控件背景颜色 */
@property (nonatomic, copy) UIColor * innerBackgroundColor;
/** 左侧Label背景颜色 */
@property (nonatomic, copy) UIColor * beginLabelBackgroundColor;
/** 右侧Label背景颜色 */
@property (nonatomic, copy) UIColor * endLabelBackgroundColor;
/** 必填背景颜色 */
@property (nonatomic, copy) UIColor * mustInputBackgroundColor;
/** 输入框字体 */
@property (nonatomic, copy) UIFont * inputViewFont;
/** 占位符 */
@property (nonatomic, copy) NSString * placeholder;
/** 占位符颜色 */
@property (nonatomic, copy) UIColor * placeholderColor;

/** Label字体大小 */
@property (nonatomic, assign) float labelFontSize;
/** textView最大高度 */
@property (nonatomic, assign) float maxHeight;
/** 边距大小 */
@property (nonatomic, assign) float marginSize;
/** 行间距 */
@property (nonatomic, assign) float lineSpace;
/** 字间距 */
@property (nonatomic, assign) float charSpace;
/** 是否为必填 */
@property (nonatomic, assign) BOOL  isMustInput;
/** 允许输入的最大长度 */
@property (nonatomic, assign) NSInteger maxLength;
/** 多行文本字体、段落属性字典 */
@property (nonatomic, strong)NSDictionary * attributesDic;

@end
