//
//  HTMINetWorkTextField.m
//  MXClient
//
//  Created by 赵志国 on 2017/9/6.
//  Copyright © 2017年 MXClient. All rights reserved.
//

#import "HTMINetWorkTextField.h"

#import "NSString+HTMISize.h"

#import "HTMISupportCopyLabel.h"

#import "Masonry.h"

#import "HTMIFormComponentHeader.h"

#import "UIFont+HTMIFont.h"

@interface HTMINetWorkTextField ()<UITextFieldDelegate>

/**
 请假天数，意见等标识
 */
@property (nonatomic, strong) HTMISupportCopyLabel *nameLabel;

/**
 弹出键盘后底部蓝色线条
 */
@property (nonatomic, strong) UIImageView *bottomLineImageView;

/**
 字体大小
 */
@property (nonatomic, assign) CGFloat textFont;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) NetWorkTextType textType;

@end

@implementation HTMINetWorkTextField

- (instancetype)initWithFrame:(CGRect)frame
                   nameString:(NSString *)nameString
                  beforeValue:(NSString *)beforeValue
                  valueString:(NSString *)valueString
                     endValue:(NSString *)endValue
                  isMustInput:(BOOL)isMustInput
                     textFont:(CGFloat)textFont
                     textType:(NetWorkTextType)textType {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textFont = textFont;
        self.textType = textType;
        CGFloat nameWidth = 0;
        
        if (nameString.length > 0) {
            [self initNameLabel:nameString];
            nameWidth = W(self)*0.3;
        }
        
        CGRect beforRect = CGRectMake(nameWidth+stringLeftWidth,
                                      0,
                                      [NSString labelSizeWithMaxWidth:0 content:beforeValue FontOfSize:textFont].width,
                                      H(self));
        HTMISupportCopyLabel *beforLabel = [[HTMISupportCopyLabel alloc] initWithFrame:beforRect];
        beforLabel.text = beforeValue;
        beforLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        beforLabel.font = [UIFont htmi_systemFontOfSize:textFont];
        [self addSubview:beforLabel];
        
        CGFloat endWidth = [NSString labelSizeWithMaxWidth:0 content:endValue FontOfSize:textFont].width;
        CGRect endRect = CGRectMake(W(self)-endWidth-stringLeftWidth, 0, endWidth, H(self));
        HTMISupportCopyLabel *endLabel = [[HTMISupportCopyLabel alloc] initWithFrame:endRect];
        endLabel.text = endValue;
        endLabel.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        endLabel.font = [UIFont htmi_systemFontOfSize:textFont];
        [self addSubview:endLabel];
        
        CGRect textFieldRect = CGRectMake(nameWidth+stringLeftWidth+W(beforLabel),
                                          0,
                                          W(self)-nameWidth-stringLeftWidth*2-W(beforLabel)-W(endLabel),
                                          H(self));
        self.textField = [[UITextField alloc] initWithFrame:textFieldRect];
        if (isMustInput) {
            self.textField.placeholder = @"(必填)";
        }
        self.textField.delegate = self;
        self.textField.text = valueString;
        self.textField.backgroundColor = [UIColor clearColor];
        self.textField.font = [UIFont htmi_systemFontOfSize:textFont];
        self.textField.textColor = [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0];
        [self addSubview:self.textField];
        
        if (textType == NetWorkTextTypeTextFieldInteger) {
            //整数
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            
        } else if (textType == NetWorkTextTypeTextFieldIntegerSplitbyThousand) {
            //整数  千分符
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            
            if (valueString.length > 0) {
                
                //如果传入的值不是整数，该如何处理
                /*
                 NSNumber *number = [NSNumber numberWithLongLong:[textValue longLongValue]];
                 [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                 NSString *qianfenfuString = [formatter stringFromNumber:number];
                 */
                
                NSString * numberValue = [valueString stringByReplacingOccurrencesOfString:@"," withString:@""];
                NSString * qianfenfuString = [self changeNumberFormat:numberValue];
                
                self.textField.text = qianfenfuString;
            }
            
        } else if (textType == NetWorkTextTypeTextFieldDecimal) {
            //小数
            self.textField.keyboardType = UIKeyboardTypeDecimalPad;
            
        } else if (textType == NetWorkTextTypeTextFieldDecimalSplitbyThousand) {
            
            //小数  千分符 小数点前边的加千分符，后边不加
            self.textField.keyboardType = UIKeyboardTypeDecimalPad;
            
            if (valueString.length > 0) {
                
                if ([valueString rangeOfString:@"."].location == NSNotFound) {
                    //没 .
                    valueString = [valueString stringByAppendingString:@".00"];
                }
                
                NSArray *xiaoshuArray = [valueString componentsSeparatedByString:@"."];
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
            
        }
        
        //添加监听  实时监听输入框变化
        [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return self;
}

#pragma mark ------ UI
- (void)initNameLabel:(NSString *)nameString  {
    self.nameLabel = [[HTMISupportCopyLabel alloc] init];
    self.nameLabel.text = nameString;
    self.nameLabel.font = [UIFont htmi_systemFontOfSize:self.textFont];
    self.nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    self.nameLabel.numberOfLines = 0;
    [self addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(stringLeftWidth);
        make.top.equalTo(self);
        make.width.mas_equalTo(W(self)*0.3-stringLeftWidth*2);
        make.height.mas_equalTo(H(self));
    }];

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

- (void)textFieldChange:(UITextField *)textField{
    
    if (textField.text.length <= 0) {
//        self.editEndBlock(textField.text);
        return;
    }
    if (self.textType == NetWorkTextTypeTextFieldIntegerSplitbyThousand) {
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
        NSString * qianfenfuString = [self changeNumberFormat:numberValue];
        
        textField.text = qianfenfuString;
        
    }
    else if (self.textType == NetWorkTextTypeTextFieldDecimalSplitbyThousand) {
        
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
                NSString * qianfenfuString = [self changeNumberFormat:numberValue];
                
                textField.text = [qianfenfuString stringByAppendingString:endString];
            }
        }
    }
    else{
        
    }
    
//    self.editEndBlock(textField.text);
}

#pragma mark ------ UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.bottomLineImageView.hidden = NO;
    self.nameLabel.textColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.bottomLineImageView.hidden = YES;
    self.nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    
    self.editEndBlock(textField.text);
}

#pragma mark ------ 懒加载
- (UIImageView *)bottomLineImageView {
    if (!_bottomLineImageView) {
        _bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.textField.frame.origin.x, H(self)-2, W(self.textField), 2)];
        _bottomLineImageView.backgroundColor = [UIColor colorWithRed:41/255.0 green:123/255.0 blue:251/255.0 alpha:1.0];
        _bottomLineImageView.hidden = YES;
    }
    return _bottomLineImageView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
