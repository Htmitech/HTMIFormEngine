//
//  HTMITxtView.m
//  自定义输入框
//
//  Created by 赵志国 on 16/6/29.
//  Copyright © 2016年 htmitech.com. All rights reserved.
//

#import "HTMITxtView.h"
#import "HTMITextView.h"
#import "HTMITextField.h"

#import "UIView+Extension.h"

#import "NSString+HTMISize.h"

#import "HTMIFormComponentHeader.h"

#import "UIFont+HTMIFont.h"

#define kOwnWidth self.bounds.size.width
#define kOwnHeight self.bounds.size.height

@interface HTMITxtView ()<UITextFieldDelegate,UITextViewDelegate>
{
    float _labelFontSize;
    UIFont * _inputViewFont;
}
/** 左侧控件的宽度 */
@property (nonatomic, assign) float beforValueWidth;
/** 右侧控件的宽度 */
@property (nonatomic, assign) float endValueWidth;
/** 起始控件高度 */
@property (nonatomic, assign) float  beginHeight;

@property (nonatomic, assign) BOOL isShowWarning;

@end

@implementation HTMITxtView

- (instancetype)initWithFrame:(CGRect)frame textType:(TextType)textType beforValue:(NSString *)beforValue textValue:(NSString *)textValue endValue:(NSString *)endValue isMustInput:(BOOL)isMustInput textFont:(NSInteger)textFont maxLength:(NSInteger)maxLength isShowWarning:(BOOL)isShowWarning {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //是必填
        self.isMustInput = isMustInput;
        self.isShowWarning = isShowWarning;
        //起始高度赋值
        self.beginHeight = self.bounds.size.height;
        //类型赋值
        self.textType = textType;
        //字体大小
        self.formLabelFont = textFont;
        //允许输入的最大长度

        if (maxLength) {
             self.maxLength = maxLength;
        }
        else{
            self.maxLength = 0;
        }

        //左侧Label
        if (beforValue.length > 0) {
            self.beforValueWidth = [NSString labelSizeWithMaxWidth:0 content:beforValue FontOfSize:self.labelFontSize].width;
            
            self.beforLabel.text = beforValue;
            [self addSubview:self.beforLabel];
        }
        else{
            self.beforValueWidth = 0;
        }
        //右侧侧Label
        if (endValue.length > 0) {
            self.endValueWidth = [NSString labelSizeWithMaxWidth:0 content:endValue FontOfSize:self.labelFontSize].width;
            self.endLabel.text = endValue;
            [self addSubview:self.endLabel];
        }
        else{
            self.endValueWidth = 0;
        }
        
        if (textType != TextTypeTextView) {
            
            //单行文本(TextField)
            [self addSubview:self.textField];
            
            //格式
//            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            
            if (textType == TextTypeTextFieldInteger) {
                //整数
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                
                self.textField.text = textValue;
                
            } else if (textType == TextTypeTextFieldIntegerSplitbyThousand) {
                //整数  千分符
                self.textField.keyboardType = UIKeyboardTypeNumberPad;
                
                if (textValue.length > 0) {
                    
                    //如果传入的值不是整数，该如何处理
                    /*
                     NSNumber *number = [NSNumber numberWithLongLong:[textValue longLongValue]];
                     [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                     NSString *qianfenfuString = [formatter stringFromNumber:number];
                     */
                    
                    NSString * numberValue = [textValue stringByReplacingOccurrencesOfString:@"," withString:@""];
                    NSString * qianfenfuString = [self changeNumberFormat:numberValue];
                    
                    
                    self.textField.text = qianfenfuString;
                }
                
            } else if (textType == TextTypeTextFieldDecimal) {
                //小数
                self.textField.keyboardType = UIKeyboardTypeDecimalPad;
                
                self.textField.text = textValue;
                
            } else if (textType == TextTypeTextFieldDecimalSplitbyThousand) {
                
                //小数  千分符 小数点前边的加千分符，后边不加
                self.textField.keyboardType = UIKeyboardTypeDecimalPad;
                
                if (textValue.length > 0) {
                    
                    if ([textValue rangeOfString:@"."].location == NSNotFound) {
                        //没 .
                        textValue = [textValue stringByAppendingString:@".00"];
                    }
                    
                    NSArray *xiaoshuArray = [textValue componentsSeparatedByString:@"."];
                    NSString *intString = [xiaoshuArray firstObject];
                    NSString *doubleString = [NSString stringWithFormat:@".%@",[xiaoshuArray lastObject]];
                    /*
                     NSNumber *number = [NSNumber numberWithLongLong:[intString longLongValue]];
                     [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                     NSString *qianfenfuString = [formatter stringFromNumber:number];
                     */
                    NSString * numberValue = [intString stringByReplacingOccurrencesOfString:@"," withString:@""];
                    NSString * qianfenfuString = [self changeNumberFormat:numberValue];
                    
                    
                    NSString * valueString = [qianfenfuString stringByAppendingString:doubleString];
                    
                    self.textField.text = valueString;
                }
                
            } else {
                self.textField.text = textValue;
            }
            
            //如果是必填设置控件内部背景色为相应的颜色
            if (self.isMustInput) {
//                if (self.textField.text.length <= 0) {
                
                    self.textField.backgroundColor = self.mustInputBackgroundColor;
//                }
            }
            
            //添加监听  实时监听输入框变化
            [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
            
        } else if (textType == TextTypeTextView) {
            
            //1、设置文字
            self.textView.text = textValue;
            
            self.textView.attributedText = [[NSAttributedString alloc]initWithString:_textView.text attributes:self.attributesDic];
            self.textView.typingAttributes = self.attributesDic;
            
            [self addSubview:self.textView];
            
            if (self.isMustInput) {
//                if (self.textView.text.length <= 0) {
                
                    self.textView.backgroundColor = self.mustInputBackgroundColor;
//                }
            }
        }
    }
    
    return self;
}

#pragma mark ------ UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([self.delegate respondsToSelector:@selector(txtViewDelegateBeginEdit:)]) {
        [self.delegate txtViewDelegateBeginEdit:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    textField.layer.borderColor = self.highlightBorderColor.CGColor;
    
    if (self.isMustInput) {
        //设置必填背景色
        textField.backgroundColor = self.mustInputBackgroundColor;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = self.nomarlBorderColor.CGColor;
    
    if (self.isMustInput) {
//        if ([textField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
            //设置必填背景色
            textField.backgroundColor = self.mustInputBackgroundColor;
//        }
//        else{
//            textField.backgroundColor = self.innerBackgroundColor;
//        }
    }
    
    self.editEndBlock(textField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //不是小数的时候不限制输入
    if (self.textType == TextTypeTextField) {
        return YES;
    }
    else if (self.textType == TextTypeTextFieldInteger || self.textType == TextTypeTextFieldIntegerSplitbyThousand) {
        return [self validateNumber:string];//限制只能输入数字
    }
    else if(self.textType == TextTypeTextFieldDecimal || self.textType == TextTypeTextFieldDecimalSplitbyThousand){
        return  [self isValidAboutInputText:textField shouldChangeCharactersInRange:range replacementString:string decimalNumber:10];
    }
    
    /*
     NSMutableString *textString = [NSMutableString stringWithString:textField.text];
     
     if (string.length > 0 && range.length < 1) {//添加
     [textString insertString:string atIndex:range.location];
     
     } else {//删除
     [textString deleteCharactersInRange:range];
     }
     
     //带有千分符的，需要将千分符去掉然后返回
     if (self.textType == TextTypeTextFieldIntegerSplitbyThousand || self.textType == TextTypeTextFieldDecimalSplitbyThousand) {
     self.editBlock([[textString componentsSeparatedByString:@","] componentsJoinedByString:@""]);
     }
     else {
     self.editBlock(textString);
     }
     */
    
    return YES;
}

- (void)textFieldChange:(UITextField *)textField{
    
    if (self.isMustInput ) {//&& textField.text.length<=0
        textField.backgroundColor = self.mustInputBackgroundColor;
    } else {
        textField.backgroundColor = self.innerBackgroundColor;
    }
    
    if (textField.text.length <= 0) {
        self.editBlock(textField.text);
        return;
    }
    if (self.textType == TextTypeTextFieldIntegerSplitbyThousand) {
        //格式 千分符需要处理
        /*
         NSArray *array = [textField.text componentsSeparatedByString:@","];
         NSString *string = [array componentsJoinedByString:@""];
         NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
         NSNumber *number = [NSNumber numberWithUnsignedLongLong:[string longLongValue]];
         [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
         NSString *qianfenfuString = [formatter stringFromNumber:number];
         */
        
        
        NSString * numberValue = [textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
        //wlq add 2016/09/12 限制输入长度
        if (numberValue.length > self.maxLength) {
            numberValue = [numberValue substringToIndex:self.maxLength];
        }
        NSString * qianfenfuString = [self changeNumberFormat:numberValue];
        
        textField.text = qianfenfuString;
        
    }
    else if (self.textType == TextTypeTextFieldDecimalSplitbyThousand) {
        
        if (textField.text.length > 0) {
            
            if ([textField.text rangeOfString:@"."].location == NSNotFound) {
                //没有小数点
                /*
                 NSArray *array = [textField.text componentsSeparatedByString:@","];
                 NSString *string = [array componentsJoinedByString:@""];
                 NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                 NSNumber *number = [NSNumber numberWithUnsignedLongLong:[string longLongValue]];
                 [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                 NSString *qianfenfuString = [formatter stringFromNumber:number];
                 */
                
                NSString * numberValue = [textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
                
                //wlq add 2016/09/12 限制输入长度
                if (numberValue.length > self.maxLength) {
                    numberValue = [numberValue substringToIndex:self.maxLength];
                }
                NSString * qianfenfuString = [self changeNumberFormat:numberValue];
                
                textField.text = qianfenfuString;
            }
            else {
                
                //有小数点
                
                NSArray *array = [textField.text componentsSeparatedByString:@"."];
                NSString *beforeString = [array firstObject];
                NSArray *beforeArray = [beforeString componentsSeparatedByString:@","];
                NSString *newbeforeString = [beforeArray componentsJoinedByString:@""];
                NSString *endString = [NSString stringWithFormat:@".%@",[array lastObject]];
                
                /*
                 NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                 NSNumber *number = [NSNumber numberWithUnsignedLongLong:[newbeforeString longLongValue]];
                 [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                 NSString *qianfenfuString = [formatter stringFromNumber:number];
                 */
                
                NSString * numberValue = [newbeforeString stringByReplacingOccurrencesOfString:@"," withString:@""];
                //wlq add 2016/09/12 限制输入长度
                if (numberValue.length > self.maxLength) {
                    numberValue = [numberValue substringToIndex:self.maxLength];
                }
                NSString * qianfenfuString = [self changeNumberFormat:numberValue];
                
                textField.text = [qianfenfuString stringByAppendingString:endString];
            }
        }
    }
    else{
        //wlq add 2016/09/12 限制输入长度
        if (textField.text.length > self.maxLength) {
            textField.text = [textField.text substringToIndex:self.maxLength];
        }
    }

    self.editBlock(textField.text);
}

#pragma mark ------ UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.layer.borderColor = self.highlightBorderColor.CGColor;
    
    if (self.isMustInput) {
        //设置必填背景色
        textView.backgroundColor = self.mustInputBackgroundColor;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    textView.layer.borderColor = self.nomarlBorderColor.CGColor;
    
    if (self.isMustInput) {
//        if ([textView.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
            //设置必填背景色
            textView.backgroundColor = self.mustInputBackgroundColor;
//        }else{
//            textView.backgroundColor = self.innerBackgroundColor;
//        }
    }
    
    self.editEndBlock(textView.text);
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    
    //wlq add 2016/09/12 限制输入长度
    if (textView.text.length > self.maxLength) {
        textView.text = [textView.text substringToIndex:self.maxLength];
    }
    
    if (self.editBlock) {
        self.editBlock(textView.text);
    }
    
    //不要删除 这段代码是为了获得textview高度的，暂时不用了CGFloat textViewHeight = [self heightForString:textView andWidth:textView.width];
    CGFloat maxHeight = MAX(0, self.beginHeight - 10);//textViewHeight
    textView.height = maxHeight;
    self.height = maxHeight + 10;
    self.beforLabel.height =  kOwnHeight;
    self.endLabel.height =  kOwnHeight;
}

- (void)textViewDidChange:(UITextView *)textView{
    
}

#pragma mark - 系统方法（UIView）

//超出父控件后一样可以相应处理事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.textView convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.textView.bounds, tempoint))
        {
            view = self.textView;
       	}
    }
    return view;
}

#pragma mark - 私有方法

//输入框中只能输入数字和小数点，且小数点只能输入一位，参数number 可以设置小数的位数
- (BOOL)isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number{
    
    NSScanner      *scanner    = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange         pointRange = [textField.text rangeOfString:@"."];
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) ){
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }else{
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] ){
        return NO;
    }
    short remain = number; //保留 number位小数
    NSString *tempStr = [textField.text stringByAppendingString:string];
    NSUInteger strlen = [tempStr length];
    if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
        if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
            return NO;
        }
    }
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
        if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
            textField.text = string;
            return NO;
        }else{
            if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                if([string isEqualToString:@"0"]){
                    return NO;
                }
            }
        }
    }
    NSString *buffer;
    if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) ){
        return NO;
    }else{
        
        
        if (self.textType == TextTypeTextFieldDecimalSplitbyThousand) {
            
            /*  //如果能转换成功让它返回yes，如果转换失败返回no
             NSString * valueString = [NSString stringWithFormat:@"%@%@",textField.text,string];
             NSString * tempString = [valueString stringByReplacingOccurrencesOfString:@"," withString:@""];
             
             
             NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
             NSNumber *number = [NSNumber numberWithUnsignedLongLong:[tempString longLongValue]];
             [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
             NSString *qianfenfu = [formatter stringFromNumber:number];
             
             if ([tempString isEqualToString:[qianfenfu stringByReplacingOccurrencesOfString:@"," withString:@""]]) {
             return YES;
             }
             else{
             return NO;
             }*/
            
            return YES;
            
        }
        else{
            return YES;
        }
        
        return YES;
    }
}

/**
 *  只能输入数字
 *
 *  @param number 输入的字符串
 *
 *  @return 是否是数字
 */
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    if (res) {
        
        /*
         if (self.textType == TextTypeTextFieldIntegerSplitbyThousand) {
         //如果能转换成功让它返回yes，如果转换失败返回no
         
         NSString * valueString = [NSString stringWithFormat:@"%@%@",self.textField.text,number];
         NSString * tempString = [valueString stringByReplacingOccurrencesOfString:@"," withString:@""];
         
         
         NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
         NSNumber *number = [NSNumber numberWithUnsignedLongLong:[tempString longLongValue]];
         [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
         NSString *qianfenfu = [formatter stringFromNumber:number];
         
         if ([tempString isEqualToString:[qianfenfu stringByReplacingOccurrencesOfString:@"," withString:@""]]) {
         return YES;
         }
         else{
         return NO;
         }
         
         }
         else{
         return YES;
         }*/
        
        
        return YES;
    }
    else{
        return NO;
    }
    
}

/**
 *  字符串千分符
 *
 *  @param num 想要转换的字符串
 *
 *  @return 转换完成的字符串
 */
- (NSString *)changeNumberFormat:(NSString *)num
{
    if (num == nil) {
        return @"";
    }
    NSInteger count = num.length;//0;
    
    /*
     long long int a = num.longLongValue;//这个方法道理是一样的，如果超过证书的最大值，就不能再继续输入了
     while (a != 0)
     {
     count++;
     a /= 10;
     }
     */
    
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

/*
 - (CGFloat)calculateMeaasgeHeightWithText:(NSString *)string andWidth:(CGFloat)width andFont:(UIFont *)font {
 static UILabel *stringLabel = nil;
 static dispatch_once_t onceToken;
 dispatch_once(&onceToken, ^{//生成一个同于计算文本高度的label
 stringLabel = [[UILabel alloc] init];
 stringLabel.numberOfLines = 0;
 });
 stringLabel.font = font;
 stringLabel.attributedText = self.textView.attributedText;
 return [stringLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)].height;
 }
 */

/**
 @method 获取指定宽度width的字符串在UITextView上的高度
 @param textView 待计算的UITextView
 @param Width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float)heightForString:(UITextView *)textView andWidth:(float)width{
    CGSize sizeToFit = [textView sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    return sizeToFit.height;
}

//自定义千分符格式转换
+ (NSString *)stringSeparatedDouble:(double)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.positiveFormat = @",###.##";
    return [formatter stringFromNumber:@(number)];
}

#pragma mark - Getters
- (float)beginHeight{
    if (!_beginHeight) {
        _beginHeight = self.bounds.size.height;
    }
    return  _beginHeight;
}

- (UIColor *)highlightBorderColor{
    if (!_highlightBorderColor) {
        _highlightBorderColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
    }
    return _highlightBorderColor;
}

- (UIColor *)nomarlBorderColor{
    if (!_nomarlBorderColor) {
        _nomarlBorderColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    }
    return _nomarlBorderColor;
}

//水印
- (UIColor *)innerBackgroundColor{
    if (!_innerBackgroundColor) {
        //        _innerBackgroundColor = [UIColor whiteColor];
        _innerBackgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.0];
    }
    return _innerBackgroundColor;
}

//水印
- (UIColor *)mustInputBackgroundColor{
    if (!_mustInputBackgroundColor) {
        //        _mustInputBackgroundColor = RGB(254, 250, 235);
        _mustInputBackgroundColor = [UIColor colorWithRed:254/255.0 green:250/255.0 blue:235/255.0 alpha:0.6];
    }
    return _mustInputBackgroundColor;
}

- (UIColor *)beginLabelBackgroundColor{
    if (!_beginLabelBackgroundColor) {
        _beginLabelBackgroundColor = [UIColor clearColor];
    }
    return _beginLabelBackgroundColor;
}

- (UIColor *)endLabelBackgroundColor{
    if (!_endLabelBackgroundColor) {
        _endLabelBackgroundColor = [UIColor clearColor];
    }
    return _endLabelBackgroundColor;
}

- (UILabel *)beforLabel{
    if (!_beforLabel) {
        _beforLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.marginSize, 0, self.beforValueWidth, kOwnHeight)];
        _beforLabel.font = [UIFont htmi_systemFontOfSize:self.labelFontSize];
        _beforLabel.backgroundColor =  self.beginLabelBackgroundColor;
        _beforLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _beforLabel;
}

- (UILabel *)endLabel{
    if (!_endLabel) {
        _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(kOwnWidth - (self.marginSize * 2) - self.endValueWidth, 0, self.endValueWidth, kOwnHeight)];
        _endLabel.font = [UIFont htmi_systemFontOfSize:self.labelFontSize];
        _endLabel.backgroundColor =  self.endLabelBackgroundColor;
        _endLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _endLabel;
}

- (float)labelFontSize{
    if (!_labelFontSize) {
        _labelFontSize = self.formLabelFont;
    }
    return  _labelFontSize;
}

- (void)setLabelFontSize:(float)labelFontSize{
    _labelFontSize = labelFontSize;
    
    //此处可以根据不同的字体大小来设置行间距以及字间距
    self.charSpace = 10;
    self.lineSpace = 30;
}

- (float)maxHeight{
    if (!_maxHeight) {
        _maxHeight = 1000;
    }
    return  _maxHeight;
}

- (float)marginSize{
    if (!_marginSize) {
        _marginSize = 5;
    }
    return  _marginSize;
}

- (float)lineSpace{
    if (!_lineSpace) {
        _lineSpace = 5;
    }
    return  _lineSpace;
}

- (float)charSpace{
    if (!_charSpace) {
        _charSpace = 0;
    }
    return  _charSpace;
}

- (BOOL)isMustInput{
    if (!_isMustInput) {
        _isMustInput = NO;
    }
    return _isMustInput;
}

- (NSDictionary *)attributesDic{
    if (!_attributesDic) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineSpacing = self.lineSpace;
        _attributesDic = @{ NSFontAttributeName:[UIFont htmi_systemFontOfSize:self.labelFontSize], NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(self.charSpace)};
    }
    return _attributesDic;
}

- (UITextField *)textField{
    if (!_textField) {
        
        float leftLabelMaxX;
        float rightLabelMinX;
        if (self.beforValueWidth > 0) {
            leftLabelMaxX = CGRectGetMaxX(self.beforLabel.frame);
        }
        else{
            leftLabelMaxX = 0;
        }
        if (self.endValueWidth > 0) {
            rightLabelMinX = CGRectGetMinX(self.endLabel.frame);
            rightLabelMinX =  kOwnWidth - rightLabelMinX;
        }
        else{
            rightLabelMinX = 0;
        }
        
        _textField = [[HTMITextField alloc] initWithFrame:CGRectMake(self.marginSize + leftLabelMaxX, (kOwnHeight-kH6(40))/2, kOwnWidth - (self.marginSize * 2) - leftLabelMaxX - rightLabelMinX, kOwnHeight - kH6(10))];
        _textField.font = self.inputViewFont;
        
        _textField.layer.borderWidth = 1.0;
        if (self.isShowWarning) {
            _textField.layer.borderColor = WARNING_BORDER_COLOR;
        } else {
            _textField.layer.borderColor = self.nomarlBorderColor.CGColor;
        }
        _textField.layer.cornerRadius = 2;
        _textField.layer.masksToBounds = YES;
        _textField.backgroundColor = self.innerBackgroundColor;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.delegate = self;
    }
    return _textField;
}

- (HTMITextView *)textView{
    
    if (!_textView) {
        
        float leftLabelMaxX;
        float rightLabelMinX;
        if (self.beforValueWidth > 0) {
            leftLabelMaxX = CGRectGetMaxX(self.beforLabel.frame);
        }
        else{
            leftLabelMaxX = 0;
        }
        if (self.endValueWidth > 0) {
            rightLabelMinX = CGRectGetMinX(self.endLabel.frame);
        }
        else{
            rightLabelMinX = 0;
        }
        _textView = [[HTMITextView alloc] initWithFrame:CGRectMake(self.marginSize + leftLabelMaxX, kH6(5), kOwnWidth - (self.marginSize * 2) - leftLabelMaxX - rightLabelMinX, kOwnHeight - kH6(10))];
        
        _textView.font = self.inputViewFont;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_textView setContentSize:CGSizeMake(99999, 50)];
        
        _textView.backgroundColor = self.innerBackgroundColor;
        _textView.layer.borderWidth = 1.0;
        _textView.layer.masksToBounds = YES;
        if (self.isShowWarning) {
            _textView.layer.borderColor = WARNING_BORDER_COLOR;
        } else {
            _textView.layer.borderColor = self.nomarlBorderColor.CGColor;
        }
        
        _textView.layer.cornerRadius = 2;
        
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(13, 15, 13, 15);
        
    }
    return _textView;
}

- (UIFont *)inputViewFont{
    if (!_inputViewFont) {
        _inputViewFont = [UIFont htmi_systemFontOfSize:self.labelFontSize];
    }
    return _inputViewFont;
}

- (NSString *)placeholder{
    if (!_placeholder) {
        _placeholder = @"请输入";
    }
    return _placeholder;
}

- (UIColor *)placeholderColor{
    if (!_placeholderColor) {
        _placeholderColor = [UIColor lightGrayColor];
    }
    return _placeholderColor;
}

- (void)setInputViewFont:(UIFont *)inputViewFont{
    _inputViewFont = inputViewFont;
    
    if (self.textType == TextTypeTextView) {
        if (_textView) {
            self.textView.font = _inputViewFont;
        }
    }
    else{
        if (_textField) {
            self.textField.font = _inputViewFont;
        }
    }
}

- (void)setErrorBorderColor:(UIColor *)errorBorderColor{
    _errorBorderColor = errorBorderColor;
    
    if (!_errorBorderColor) {
        _errorBorderColor = [UIColor colorWithRed:237/255.0 green:150/255.0 blue:151/255.0 alpha:1.0];//默认的红色
    }
    
    if (_errorBorderColor) {
        
        if (self.textType == TextTypeTextView) {
            if (_textView) {
                self.textView.layer.borderColor = _errorBorderColor.CGColor;
            }
        }
        else{
            if (_textField) {
                self.textField.layer.borderColor = _errorBorderColor.CGColor;
            }
        }
    }
}

@end
