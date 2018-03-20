//
//  HTMINetWorkTextField.h
//  MXClient
//
//  Created by 赵志国 on 2017/9/6.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HTMINetWorkTextFieldEndEditBlock)(NSString *string);

typedef NS_ENUM(NSInteger, NetWorkTextType) {
    NetWorkTextTypeTextField,
    NetWorkTextTypeTextFieldInteger,
    NetWorkTextTypeTextFieldIntegerSplitbyThousand,
    NetWorkTextTypeTextFieldDecimal,
    NetWorkTextTypeTextFieldDecimalSplitbyThousand,
    NetWorkTextTypeTextView,
};

@interface HTMINetWorkTextField : UIView

/**
 *  textView编辑完成后收键盘
 */
@property (nonatomic, copy) HTMINetWorkTextFieldEndEditBlock editEndBlock;


- (instancetype)initWithFrame:(CGRect)frame
                   nameString:(NSString *)nameString
                  beforeValue:(NSString *)beforeValue
                  valueString:(NSString *)valueString
                     endValue:(NSString *)endValue
                  isMustInput:(BOOL)isMustInput
                     textFont:(CGFloat)textFont
                     textType:(NetWorkTextType)textType;



@end
